import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isEdit=false;


class EditCover extends StatefulWidget {
  String cover;
  EditCover({Key? key,required this.cover}) : super(key: key);

  @override
  State<EditCover> createState() => _EditCoverState();
}

class _EditCoverState extends State<EditCover> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
      builder: (context,state){

          var cubit=AppCubit.get(context);

          return  Scaffold(
            appBar: customAppbar('Edit Profile', context),
            body: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 20
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60,),
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                            image: cubit.coverImage == null
                                ? NetworkImage(
                                '${cubit.userModel!.cover}')
                                : cubit.cover,
                            fit: BoxFit.cover)),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: (){
                            cubit.getCoverImage().then((value) {
                              setState(() {
                              });
                            });
                          },
                          child:  Text('Edit Cover',style: TextStyle(
                              color: AppColors.primaryColor1,
                              fontFamily: AppStrings.appFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),),
                      ),
                      SizedBox(width: 15,),
                      TextButton(
                        onPressed: (){
                          cubit
                              .uploadUserCover(
                            name: cubit.changeUserNameController.text,
                            phone:
                            cubit.changeUserPhoneController.text,
                            bio: cubit.changeUserBioController.text,
                          )
                              .then((value) {
                            cubit.getUser();
                          });
                        },
                        child:  Text('Save Changes',style: TextStyle(
                            color: AppColors.primaryColor1,
                            fontFamily: AppStrings.appFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                        ),),
                      ),

                    ],
                  )
                ],
              ),
            ),


          );

      },
    );
  }
}