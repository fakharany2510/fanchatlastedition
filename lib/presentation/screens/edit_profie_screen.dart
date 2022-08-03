import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../widgets/shared_widgets.dart';
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);

        return Scaffold(
          backgroundColor: AppColors.primaryColor1,
          appBar: customAppbar('Edit Profile',context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is GetCoverImageLoadingState || state is GetProfileImageLoadingState)
                const LinearProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    child: Stack(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    image:  DecorationImage(
                                        image:  cubit.coverImage==null?NetworkImage('${cubit.userModel!.cover}'):cubit.cover,
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.myGrey,
                                  radius: 20,
                                  child: IconButton(onPressed: (){
                                    cubit.getCoverImage();
                                  },
                                      icon: Icon(Icons.camera_alt_outlined,color:AppColors.primaryColor1,)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 57,
                              child: CircleAvatar(
                                backgroundImage: cubit.profileImage==null?NetworkImage('${cubit.userModel!.image}'):cubit.profile,
                                radius: 55,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: AppColors.myGrey,
                              radius: 20,
                              child: IconButton(onPressed: (){
                                cubit.getProfileImage();
                                print('change personal photo');
                              },
                                  icon: Icon(Icons.camera_alt_outlined,color:AppColors.primaryColor1,)
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if(AppCubit.get(context).profileImage !=null || AppCubit.get(context).coverImage !=null )
                  Container(
                    margin: const EdgeInsets.symmetric(
                       horizontal: 10
                    ),
                    child: Row(
                      children: [
                        if(cubit.profileImage !=null)
                          Expanded(
                            child: Column(
                              children: [
                              defaultButton(
                                textColor: AppColors.primaryColor1,
                                width: size.width*.6,
                                height: size.height*.06,
                              fontSize: 14,
                              buttonColor: AppColors.myGrey,
                              buttonText: 'Upload profile image',
                                function: (){
                                  cubit.uploadUserImage(
                                    name: cubit.changeUserNameController.text,
                                    phone: cubit.changeUserPhoneController.text,
                                    bio: cubit.changeUserBioController.text,
                                  ).then((value) {
                                    cubit.getUser();
                                  });
                              },
                              )
                              ],
                            ),
                          ),
                        SizedBox(width:5),
                        if(cubit.coverImage !=null)
                          Expanded(
                            child: Column(
                              children: [

                                defaultButton(
                                  textColor: AppColors.primaryColor1,
                                  width: size.width*.6,
                                  height: size.height*.06,
                                  fontSize: 14,
                                    buttonColor: AppColors.myGrey,
                                    buttonText: 'Upload cover image',
                                    function: (){
                                      cubit.uploadUserCover(
                                        name: cubit.changeUserNameController.text,
                                        phone: cubit.changeUserPhoneController.text,
                                        bio: cubit.changeUserBioController.text,

                                      ).then((value) {
                                        cubit.getUser();
                                      });
                                    },
                                ),

                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                Padding(padding: const EdgeInsets.only(left:20,right: 20,top: 20),
                  child:textFormFieldWidget(
                      context: context,
                      controller: cubit.changeUserNameController,
                      errorMessage: "please enter your name",
                      inputType: TextInputType.name,
                      labelText:"Name",
                      prefixIcon: Icons.person
                  ),
                ),
                Padding(padding: const EdgeInsets.only(left:20,right: 20,top: 20),
                  child:textFormFieldWidget(
                      context: context,
                      controller: cubit.changeUserPhoneController,
                      errorMessage:"please enter your phone",
                      inputType: TextInputType.phone,
                      labelText:"phone",
                      prefixIcon: Icons.phone
                  ),
                ),
                Padding(padding: const EdgeInsets.only(left:20,right: 20,top: 20),
                  child:textFormFieldWidget(
                      context: context,
                      controller: cubit.changeUserBioController,
                      errorMessage: "please enter your bio",
                      inputType: TextInputType.text,
                      labelText:"Bio",
                      prefixIcon: Icons.info
                  ),
                ),
                const SizedBox(height:30),
                state is UpdateUserLoadingState || state is GetCoverImageSuccessState || state is GetProfileImageSuccessState?
                const CircularProgressIndicator():
                defaultButton(
                  textColor: AppColors.primaryColor1,
                    buttonText: 'Save Changes',
                    buttonColor: AppColors.myGrey,
                    height: size.height*.06,
                    width: size.width*.9,
                    function: (){
                      // if(cubit.coverImage !=null){
                      //   cubit.uploadUserCover(
                      //     name: cubit.changeUserNameController.text,
                      //     phone: cubit.changeUserPhoneController.text,
                      //     bio: cubit.changeUserBioController.text,
                      //   );
                      // }
                      // if(cubit.profileImage !=null){
                      //   cubit.uploadUserImage(
                      //     name: cubit.changeUserNameController.text,
                      //     phone: cubit.changeUserPhoneController.text,
                      //     bio: cubit.changeUserBioController.text,
                      //   );
                      // }
                      cubit.updateProfile(
                          image: cubit.profilePath,
                          cover: cubit.coverPath,
                          name: cubit.changeUserNameController.text,
                          phone: cubit.changeUserPhoneController.text,
                          bio: cubit.changeUserBioController.text,
                      );
                      printMessage(cubit.changeUserNameController.text);
                      // Navigator.pushNamed(context, 'edit_profile');
                    }
                ),
              ],
            ),

          ) ,
        );

      },
    );
  }
}

