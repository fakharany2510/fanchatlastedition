import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
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
          backgroundColor: AppColors.myWhite,
          appBar: customAppbar('Edit Profile'),
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                                        image: NetworkImage('${cubit.userModel!.cover}'),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  radius: 20,
                                  child: IconButton(onPressed: (){
                                  },
                                      icon: Icon(Icons.camera_alt_outlined,color:AppColors.myWhite,)
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
                                backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                                radius: 55,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 20,
                              child: IconButton(onPressed: (){
                                print('change personal photo');
                              },
                                  icon: Icon(Icons.camera_alt_outlined,color:AppColors.myWhite,)
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height:10),
                // if(BrowiseCubit.get(context).profileImage !=null || BrowiseCubit.get(context).coverImage !=null )
                //   Row(
                //     children: [
                //       if(BrowiseCubit.get(context).profileImage !=null)
                //         Expanded(
                //           child: Column(
                //             children: [
                //               defaultTextButton(
                //                   text: 'Upload profile image',
                //                   onpress: (){
                //                     BrowiseCubit.get(context).uploadProfileImage(
                //                         name:changeUserNameController.text,
                //                         phone:changeUserPhoneController.text,
                //                         bio:changeUserBioController.text
                //                     );
                //                   },
                //                   width: 150,
                //                   fontSize: 13
                //               ),
                //             ],
                //           ),
                //         ),
                //       SizedBox(width:5),
                //       if(BrowiseCubit.get(context).coverImage !=null)
                //         Expanded(
                //           child: Column(
                //             children: [
                //               defaultTextButton(
                //                   text: 'Upload cover image',
                //                   onpress: (){
                //                     BrowiseCubit.get(context).uploadCoverImage(
                //                         name:changeUserNameController.text,
                //                         phone:changeUserPhoneController.text,
                //                         bio:changeUserBioController.text
                //                     );
                //                   },
                //                   width: 150,
                //                   fontSize: 13
                //               ),
                //
                //             ],
                //           ),
                //         ),
                //     ],
                //   ),
                Padding(padding: const EdgeInsets.only(left:20,right: 20,top: 20),
                  child:textFormFieldWidget(
                      context: context,
                      controller: cubit.changeUserNameController,
                      errorMessage: "please enter your name",
                      inputType: TextInputType.emailAddress,
                      labelText:"Name",
                      prefixIcon: Icons.person
                  ),
                ),
                const SizedBox(height:10),
                Padding(padding: const EdgeInsets.only(left:20,right: 20,top: 20),
                  child:textFormFieldWidget(
                      context: context,
                      controller: cubit.changeUserPhoneController,
                      errorMessage:"please enter your phone",
                      inputType: TextInputType.visiblePassword,
                      labelText:"phone",
                      prefixIcon: Icons.phone
                  ),
                ),
                const SizedBox(height:10),
                Padding(padding: const EdgeInsets.only(left:20,right: 20,top: 20),
                  child:textFormFieldWidget(
                      context: context,
                      controller: cubit.changeUserBioController,
                      errorMessage: "please enter your bio",
                      inputType: TextInputType.emailAddress,
                      labelText:"Bio",
                      prefixIcon: Icons.info
                  ),
                ),
                const SizedBox(height:30),
                defaultButton(
                    buttonText: 'Save Changes',
                    buttonColor: AppColors.primaryColor,
                    height: size.height*.06,
                    width: size.width*.4,
                    function: (){
                      printMessage(cubit.changeUserNameController.text);
                      Navigator.pushNamed(context, 'edit_profile');
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

