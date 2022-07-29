import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleMatch extends StatelessWidget {
  const SingleMatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){

      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          appBar: customAppbar('Match Details'),

          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: AppColors.myWhite,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0,5, 0, 10),
                    child: Column(
                      children: [
                        Material(
                            color: Colors.grey[200],
                            elevation: 5,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 110,
                                  height: 50,
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 12,),
                                      Text('Group 5',style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500
                                      ),
                                        textAlign: TextAlign.center,
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Egypt',style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                              const  SizedBox(width: 5,),
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage:  NetworkImage(AppCubit.get(context).groupsImages[0+1]),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 5,),
                                          Container(
                                            height: 2,
                                            width: 8,
                                            color: AppColors.primaryColor,
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
                                                        color: AppColors.primaryColor
                                                    ),
                                                    color: AppColors.primaryColor
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(height: 5,),
                                                    Text('Not start',style: TextStyle(
                                                        color: AppColors.myWhite,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 5,),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Text('20:10',style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500
                                              ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 5,),
                                          Container(
                                            height: 2,
                                            width: 8,
                                            color: AppColors.primaryColor,
                                          ),
                                          const SizedBox(width: 5,),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage:  NetworkImage(AppCubit.get(context).groupsImages[0]),
                                              ),
                                              const SizedBox(width: 5,),
                                              Text('Italy',style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20,),

                                    ],
                                  ),
                                ),

                              ],
                            )
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Most Matches',style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900
                            ),
                              textAlign: TextAlign.center,
                            ),
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

                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(15, 5,15,5),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
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
                                                    color: AppColors.myWhite,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500
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
                                              color: AppColors.primaryColor,
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
                                                          color: AppColors.myWhite
                                                      ),
                                                      color: AppColors.myWhite
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(height: 5,),
                                                      Text('4 - 2',style: TextStyle(
                                                          color: AppColors.primaryColor,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      const SizedBox(height: 5,),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                            const SizedBox(width: 5,),
                                            Container(
                                              height: 2,
                                              width: 8,
                                              color: AppColors.primaryColor,
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
                                                    color: AppColors.myWhite,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,)
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
