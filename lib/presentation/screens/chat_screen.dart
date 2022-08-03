import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
              backgroundColor: AppColors.primaryColor1,
              body:  Container(
                height: MediaQuery.of(context).size.height*.9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(cubit.chatImages[index]),
                                ),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text('Ahmed Ali',style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.myWhite,
                                        fontFamily: AppStrings.appFont
                                    ),),
                                    const SizedBox(height: 10,),
                                    Text('How are you...?!',style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.navBarActiveIcon,
                                        fontFamily: AppStrings.appFont
                                    ),),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('04:00',style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.navBarActiveIcon,
                                        fontFamily: AppStrings.appFont
                                    ),),
                                    const SizedBox(height: 10,),
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: AppColors.navBarActiveIcon,
                                      child: Text('8',style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.myWhite,
                                          fontFamily: AppStrings.appFont
                                      ),),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20,)
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 15
                          ),
                          height: .1,
                          color: AppColors.myGrey,
                        );
                      },
                      itemCount: cubit.chatImages.length
                  ),
                ),
              )

          );
      },
    );
  }
}
