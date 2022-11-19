import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isEdit = false;

class EditImage extends StatefulWidget {
  const EditImage({super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is UpdateUserSuccessState) {}
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: customAppbar('Edit Profile', context),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {
                    cubit.getProfileImage();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 150,
                    child: CircleAvatar(
                      backgroundImage: cubit.profileImage == null
                          ? NetworkImage('${cubit.userModel!.image}')
                          : cubit.profile,
                      radius: 145,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (cubit.profileImage != null)
                      state is GetProfileImageLoadingState ||
                              state is UpdateUserLoadingState
                          ? CircularProgressIndicator(
                              color: AppColors.primaryColor1,
                            )
                          : TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                    color: AppColors.primaryColor1,
                                    fontFamily: AppStrings.appFont,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
