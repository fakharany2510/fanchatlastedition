import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return Scaffold(
                backgroundColor: AppColors.myWhite,
                body:Padding(
                  padding:const  EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                        radius: 60,
                      ),
                      const SizedBox(height: 10,),
                      Text('${cubit.userModel!.username}',style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                      ),),
                      const SizedBox(height: 20,),
                      Expanded(
                        child: Container(
                          height: size.height,
                          child: ListView(
                            children: [
                              InkWell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10
                                  ),
                                  width: size.width,
                                  height: size.height*.08,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.person,color: AppColors.myWhite,size: 35,),
                                      const SizedBox(width: 5,),
                                      Text('Profile',style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.myWhite
                                      ),),
                                      const Spacer(),
                                      Icon(Icons.arrow_forward_ios_outlined,color: AppColors.myWhite,size: 20,),
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(context, 'profile');
                                },
                              ),
                              const SizedBox(height:10),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )

            );
        },
    );
  }
}
