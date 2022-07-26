import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../widgets/shared_widgets.dart';
class EditProfileScreen extends StatelessWidget {
  //const EditProfileScreen({Key? key}) : super(key: key);
  TextEditingController changeUserNameController= TextEditingController();
  TextEditingController changeUserBioController= TextEditingController();
  TextEditingController changeUserPhoneController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                                image: DecorationImage(
                                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh3OAATrejFnDfO1YeDhvHNCgsepjMSXV-wA&usqp=CAU'),
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
                            backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh3OAATrejFnDfO1YeDhvHNCgsepjMSXV-wA&usqp=CAU'),
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
            SizedBox(height:10),
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
            Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
              child:textFormFieldWidget(
                  context: context,
                  controller: changeUserNameController,
                  errorMessage: "please enter your name",
                  inputType: TextInputType.emailAddress,
                  labelText:"Name",
                  prefixIcon: Icons.account_circle_sharp
              ),
            ),
            SizedBox(height:10),
            Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
              child:textFormFieldWidget(
                  context: context,
                  controller: changeUserPhoneController,
                  errorMessage:"please enter your phone",
                  inputType: TextInputType.visiblePassword,
                  labelText:"phone",
                  prefixIcon: Icons.phone
              ),
            ),
            SizedBox(height:10),
            Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
              child:textFormFieldWidget(
                  context: context,
                  controller: changeUserBioController,
                  errorMessage: "please enter your bio",
                  inputType: TextInputType.emailAddress,
                  labelText:"Bio",
                  prefixIcon: Icons.account_circle_sharp
              ),
            ),
            SizedBox(height:30),
            defaultButton(
                buttonText: 'Save Changes',
                buttonColor: AppColors.primaryColor,
                height: size.height*.06,
                width: size.width*.4,
                function: (){
                  Navigator.pushNamed(context, 'edit_profile');
                }
            ),
          ],
        ),

      ) ,
    );
  }
}
