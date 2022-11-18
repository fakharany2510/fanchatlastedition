import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/screens/profile_area/profile_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddProfileImage extends StatefulWidget {
  const AddProfileImage({super.key});

  @override
  State<AddProfileImage> createState() => _AddProfileImageState();
}

class _AddProfileImageState extends State<AddProfileImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ProfileCreatePostSuccessState) {
          // AppCubit.get(context).currentIndex=2;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
            (route) => false,
          );
          //Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar: AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add Image',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor1,
                    fontFamily: AppStrings.appFont)),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                setState(() {
                  // print('${AppCubit.get(context).profilePostImage}');
                  Navigator.pop(context);
                });
              },
            ),
            actions: [
              state is ProfileUploadImagePostLoadingState ||
                      state is BrowiseGetPostsLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultButton(
                          textColor: AppColors.myWhite,
                          width: size.width * .2,
                          height: size.height * .05,
                          raduis: 10,
                          function: () {
                            if (AppCubit.get(context).profilePostImage ==
                                null) {
                              // print('no image chossen');
                            } else {
                              AppCubit.get(context).uploadProfilePostImage(
                                  dateTime:
                                      DateFormat.yMMMd().format(DateTime.now()),
                                  time: DateFormat.Hm().format(DateTime.now()),
                                  timeSpam: DateTime.now().toString(),
                                  image: AppCubit.get(context).userModel!.image,
                                  name:
                                      AppCubit.get(context).userModel!.username,
                                  text: "");
                            }
                            // print(DateFormat.Hms().format(DateTime.now()));
                          },
                          buttonText: 'add',
                          buttonColor: AppColors.primaryColor1),
                    )
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${AppCubit.get(context).userModel!.image}'),
                        radius: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${AppCubit.get(context).userModel!.username}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppStrings.appFont),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  (AppCubit.get(context).profilePostImage != null)
                      ? Expanded(
                          child: SizedBox(
                            height: size.height,
                            width: size.width,
                            child: Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Image(
                                image: FileImage(
                                    AppCubit.get(context).profilePostImage!),
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text('No Photo Selected Yet',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor1,
                                      fontFamily: AppStrings.appFont,),),),),
                ],
              )),
        );
      },
    );
  }
}
