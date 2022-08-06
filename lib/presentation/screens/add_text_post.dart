import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../constants/app_strings.dart';

class AddTextPost extends StatefulWidget {
  @override
  State<AddTextPost> createState() => _AddTextPostState();
}

class _AddTextPostState extends State<AddTextPost> {
  @override
  TextEditingController postText = TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is BrowiseGetPostsSuccessState) {
          AppCubit.get(context).testLikes();
          AppCubit.get(context).testComments();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeLayout()));
          AppCubit.get(context).postImage = null;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar: AppBar(
            backgroundColor: AppColors.myWhite,
            title: Text('Add new post',
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
                  //AppCubit.get(context).postImage='';
                  AppCubit.get(context).postImage = null;
                  print('${AppCubit.get(context).postImage}');
                  Navigator.pop(context);
                });
              },
            ),
            actions: [
              state is BrowiseCreateTextPostLoadingState &&
                      state is BrowiseGetPostsLoadingState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultButton(
                textColor: AppColors.myWhite,
                width: size.width*.2,
                height: size.height*.05,
                raduis: 10,
                        function: () {
                          AppCubit.get(context).createTextPost(
                              text: postText.text,
                              timeSpam: DateTime.now().toString(),
                              time: DateFormat.Hm().format(DateTime.now()),
                              dateTime: DateFormat.yMMMd().format(DateTime.now()),
                          );
                        },

                        buttonText: 'post',
                        buttonColor: AppColors.primaryColor1,
                      ),
                  ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20.0),
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
                    TextFormField(
                      controller: postText,
                      decoration: const InputDecoration(
                        hintMaxLines: 1,
                        hintText: 'what is on your mind.....',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .5,
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Container(
                            height: size.height * .001,
                            width: size.width,
                            color: AppColors.myGrey,
                          ),
                          TextButton(
                              onPressed: () {
                                AppCubit.get(context).pickPostImage();
                              },
                              child: Row(
                                children: [
                                    ImageIcon(
                                      AssetImage("assets/images/fanarea.png"),
                                      color:Colors.green,

                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Photo',
                                    style: TextStyle(
                                        color: AppColors.primaryColor1,
                                        fontFamily: AppStrings.appFont,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                          Container(
                            height: size.height * .001,
                            width: size.width,
                            color: AppColors.myGrey,
                          ),
                          TextButton(
                              onPressed: () {
                                AppCubit.get(context).pickPostVideo();
                              },
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage("assets/images/video.png"),
                                    color:Colors.red,

                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Video',
                                    style: TextStyle(
                                        color: AppColors.primaryColor1,
                                        fontFamily: AppStrings.appFont,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                          Container(
                            height: size.height * .001,
                            width: size.width,
                            color: AppColors.myGrey,
                          ),
                          TextButton(
                              onPressed: () {
                                AppCubit.get(context).pickPostImageFromCamera();
                              },
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage("assets/images/camera.png"),
                                    color:AppColors.navBarActiveIcon,

                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Camera',
                                    style: TextStyle(
                                        color: AppColors.primaryColor1,
                                        fontFamily: AppStrings.appFont,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
