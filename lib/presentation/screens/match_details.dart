import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/single_match.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';

class MatchDetails extends StatelessWidget {
  const MatchDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
      builder: (context,state){
          return Scaffold(
            backgroundColor: AppColors.myWhite,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  color: AppColors.myWhite,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Material(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 110,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(
                                        width: 2,
                                        color: AppColors.primaryColor1
                                    ),
                                    color: AppColors.primaryColor1
                                  ),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 5,),
                                      Text('Today',style: TextStyle(
                                          color: AppColors.myWhite,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: AppStrings.appFont
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 7,),
                                      Text('25-7-2022',style: TextStyle(
                                          color: AppColors.myWhite,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: AppStrings.appFont
                                      ),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                  height: 1050,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context,index){
                                        return InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (_){
                                              return SingleMatch();
                                            }));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 10,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('Egypt',style: TextStyle(
                                                            color: AppColors.primaryColor1,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: AppStrings.appFont
                                                        ),),
                                                        const  SizedBox(width: 5,),
                                                        CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage:  NetworkImage(AppCubit.get(context).groupsImages[index+1]),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    Container(
                                                      height: 2,
                                                      width: 8,
                                                      color: AppColors.primaryColor1,
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 70,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(90),
                                                              border: Border.all(
                                                                  color: AppColors.primaryColor1
                                                              ),
                                                            color: AppColors.primaryColor1
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              SizedBox(height: 5,),
                                                              Text('Not start',style: TextStyle(
                                                                  color: AppColors.myWhite,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w500,
                                                                  fontFamily: AppStrings.appFont
                                                              ),
                                                               textAlign: TextAlign.center,
                                                              ),
                                                              const SizedBox(height: 5,),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text('20:10',style: TextStyle(
                                                            color: AppColors.primaryColor1,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: AppStrings.appFont
                                                        ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    Container(
                                                      height: 2,
                                                      width: 8,
                                                      color: AppColors.primaryColor1,
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    Row(
                                                      children: [

                                                         CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage:  NetworkImage(AppCubit.get(context).groupsImages[index]),
                                                        ),
                                                        const SizedBox(width: 5,),
                                                        Text('Italy',style: TextStyle(
                                                            color: AppColors.primaryColor1,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: AppStrings.appFont
                                                        ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context,index){
                                        return  Container(
                                          margin: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                          height: 1,
                                          color: AppColors.primaryColor1,
                                          width: 100,
                                        );
                                      },
                                      itemCount:4
                                  ),
                                ),
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
      },
    );
  }
}
