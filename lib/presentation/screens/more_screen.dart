import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/login_screen.dart';
import 'package:fanchat/presentation/screens/team_chat/team_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
      },
      builder: (context,state){
        var cubit =AppCubit.get(context);
        cubit.userModel!.uId=AppStrings.uId;
        return Scaffold(
            backgroundColor: AppColors.primaryColor1,
            body:(cubit.userModel!.uId !=null)
                ? Padding(
              padding:const  EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  CircleAvatar(
                    backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                    radius: 60,
                  ),
                  const SizedBox(height: 10,),
                  Text('${cubit.userModel!.username}',style:  TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      fontFamily: AppStrings.appFont,
                    color: AppColors.myWhite
                  ),),
                  const SizedBox(height: 40,),
                  Expanded(
                    child: Container(
                      height: size.height,
                      child: ListView(
                        children: [
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10
                              ),
                              width: size.width,
                              height: size.height*.05,
                              decoration: BoxDecoration(
                                  color: AppColors.myGrey,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.person,color: AppColors.primaryColor1,size: 25,),
                                  const SizedBox(width: 5,),
                                  Text('Profile',style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor1,
                                      fontFamily: AppStrings.appFont
                                  ),),
                                  const Spacer(),
                                  Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryColor1,size: 20,),
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.pushNamed(context, 'profile');
                            },
                          ),
                          const SizedBox(height:10),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10
                              ),
                              width: size.width,
                              height: size.height*.05,
                              decoration: BoxDecoration(
                                  color: AppColors.myGrey,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.family_restroom_sharp,color: AppColors.primaryColor1,size: 25,),
                                  const SizedBox(width: 5,),
                                  Text('Team Chat',style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor1,
                                      fontFamily: AppStrings.appFont
                                  ),),
                                  const Spacer(),
                                  Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryColor1,size: 20,),
                                ],
                              ),
                            ),
                            onTap: (){
                              AppCubit.get(context).getTeamChat();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>TeamChatScreen())
                              );
                            },
                          ),
                          const SizedBox(height:10),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10
                              ),
                              width: size.width,
                              height: size.height*.05,
                              decoration: BoxDecoration(
                                  color: AppColors.myGrey,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.logout,color: AppColors.primaryColor1,size: 25,),
                                  const SizedBox(width: 5,),
                                  Text('SignOut',style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor1,
                                      fontFamily: AppStrings.appFont
                                  ),),
                                  const Spacer(),
                                  Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryColor1,size: 20,),
                                ],
                              ),
                            ),
                            onTap: (){
                              AppCubit.get(context).signOut();
                              Navigator.pushReplacement(context, 
                              MaterialPageRoute(builder: (context)=>LoginScreen())
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
                :Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor1,
              ),
            )

        );
      },
    );
  }
}

