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
                              // Container(
                              //   alignment: Alignment.center,
                              //   width: 110,
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(35),
                              //     border: Border.all(
                              //         width: 2,
                              //         color: AppColors.primaryColor1
                              //     ),
                              //     color: AppColors.primaryColor1
                              //   ),
                              //   child:Column(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       // const SizedBox(height: 5,),
                              //       // Text('Today',style: TextStyle(
                              //       //     color: AppColors.myWhite,
                              //       //     fontSize: 15,
                              //       //     fontWeight: FontWeight.w500,
                              //       //     fontFamily: AppStrings.appFont
                              //       // ),
                              //       //   textAlign: TextAlign.center,
                              //       // ),
                              //       // const SizedBox(height: 7,),
                              //       // Text('25-7-2022',style: TextStyle(
                              //       //     color: AppColors.myWhite,
                              //       //     fontSize: 13,
                              //       //     fontWeight: FontWeight.w500,
                              //       //     fontFamily: AppStrings.appFont
                              //       // ),),
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(height: 15,),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context,index){
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (_){
                                          return const SingleMatch();
                                        }));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            color: AppColors.primaryColor1
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10,),
                                            Text('FRI 29 JUL 2022',style: TextStyle(
                                                color: AppColors.myWhite,
                                                fontSize: 16,
                                                fontFamily: AppStrings.appFont
                                            ),),
                                            const SizedBox(height: 5,),
                                            Text('GROUP 5',style: TextStyle(
                                                color: Colors.grey.shade300,
                                                fontSize: 13,
                                                fontFamily: AppStrings.appFont
                                            ),),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:  NetworkImage(AppCubit.get(context).groupsImages[index+1]),
                                                    ),
                                                    const  SizedBox(height: 5,),
                                                    Text('Egypt',style: TextStyle(
                                                        color: AppColors.myWhite,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: AppStrings.appFont
                                                    ),),
                                                  ],
                                                ),

                                                const SizedBox(width: 25,),
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(
                                                              color: AppColors.myWhite
                                                          ),
                                                          color: AppColors.primaryColor1
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text('4',style: TextStyle(
                                                              color: AppColors.myWhite,
                                                              fontSize: 25,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: AppStrings.appFont
                                                          ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          Text('FT',style: TextStyle(
                                                              color: AppColors.myWhite,
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: AppStrings.appFont
                                                          ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          Text('3',style: TextStyle(
                                                              color: AppColors.myWhite,
                                                              fontSize: 25,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: AppStrings.appFont
                                                          ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),

                                                const SizedBox(width: 25,),
                                                Column(
                                                  children: [

                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:  NetworkImage(AppCubit.get(context).groupsImages[index]),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    Text('Italy',style: TextStyle(
                                                        color: AppColors.myWhite,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: AppStrings.appFont
                                                    ),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context,index){
                                    return  const SizedBox(height: 0,);
                                  },
                                  itemCount:4
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