import 'package:cached_network_image/cached_network_image.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/matech_scedule.dart';
import 'package:fanchat/presentation/screens/matches/single_match.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_strings.dart';

class MatchDetails extends StatefulWidget {
  MatchDetails({Key? key}) : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  List <String>dateMatchs=[

    '20 Nov','21 Nov', '22 Nov', '23 Nov', '24 Nov', '25 Nov', '26 Nov', '27 Nov', '28 Nov', '29 Nov', '30 Nov', '1 Dec', '2 Dec', '3 Dec',
    '4 Dec', '6 Dec', '7 Dec', '8 Dec', '9 Dec', '10 Dec', '11 Dec', '12 Dec', '13 Dec', '14 Dec', '15 Dec', '16 Dec', '17 Dec', '18 Dec',
  ];

  List <String>dayMatchs=[

    'Sun','Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat',
  ];

  List isDay= List.generate(28, (index) => false);

  String ?dateMatch='22 Nov 2022';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){

      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.myWhite,
          body: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child:const Opacity(
                    opacity: 1,
                    child:  Image(
                      image: AssetImage('assets/images/imageback.jpg'),
                      fit: BoxFit.cover,

                    ),
                  )
              ),

              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height*.09,
                                  child: ListView.separated(
                                      scrollDirection:Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context,index){
                                        return InkWell(
                                          onTap: (){
                                            setState(() {
                                              isDay= List.generate(28, (index) => false);
                                              isDay[index]=!isDay[index];
                                            });

                                            AppCubit.get(context).getAllMatches(doc: dateMatchs[index]);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10
                                            ),
                                            padding: const EdgeInsets.only(
                                               right: 10
                                            ),

                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                // color: isDay[index]==true?AppColors.primaryColor1:AppColors.myGrey
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Container(
                                                //   width: 1,
                                                //   height: 25,
                                                //   color: AppColors.myGrey,
                                                // ),
                                                // SizedBox(width: 10,),
                                                Column(
                                                  children: [
                                                    Text(dayMatchs[index],style: TextStyle(
                                                        color: isDay[index]==true?AppColors.primaryColor1:AppColors.myGrey,
                                                        fontSize: 10,
                                                        fontFamily: AppStrings.appFont
                                                    ),),
                                                    const SizedBox(height: 10,),
                                                    Text(dateMatchs[index],style: TextStyle(
                                                        color: isDay[index]==true?AppColors.primaryColor1:AppColors.myGrey,
                                                        fontSize: 16,
                                                        fontFamily: AppStrings.appFont
                                                    ),),
                                                  ],
                                                ),
                                                 const SizedBox(width: 15,),
                                                Container(
                                                  width: 1,
                                                  height: 25,
                                                  color: AppColors.myGrey,
                                                ),
                                                // SizedBox(width: 10,),
                                                // const SizedBox(height: 25,),
                                                // Text(dayMatchs[index],style: TextStyle(
                                                //     color: Colors.grey.shade300,
                                                //     fontSize: 13,
                                                //     fontFamily: AppStrings.appFont
                                                // ),),
                                                const SizedBox(height: 5,),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context,index){
                                        return  const SizedBox(width: 0,);
                                      },
                                      itemCount:dateMatchs.length
                                  ),
                                ),

                                const SizedBox(height: 0,),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return InkWell(
                                        onTap: (){
                                          // Navigator.push(context, MaterialPageRoute(builder: (_){
                                          //   return const SingleMatch();
                                          // }));
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
                                              Text(AppCubit.get(context).allMatches[index].date!,style: TextStyle(
                                                  color: AppColors.myWhite,
                                                  fontSize: 16,
                                                  fontFamily: AppStrings.appFont
                                              ),),
                                              const SizedBox(height: 5,),
                                              // Text('GROUP 5',style: TextStyle(
                                              //     color: Colors.grey.shade300,
                                              //     fontSize: 13,
                                              //     fontFamily: AppStrings.appFont
                                              // ),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(50)
                                                        ),
                                                        child: CachedNetworkImage(
                                                          cacheManager: AppCubit.get(context).manager,
                                                          imageUrl: "${AppCubit.get(context).allMatches[index].firstImage!}",
                                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                          fit: BoxFit.fitWidth,
                                                        ) ,
                                                      ),
                                                      const  SizedBox(height: 5,),
                                                      Text(AppCubit.get(context).allMatches[index].firstTeam!,style: TextStyle(
                                                          color: AppColors.myWhite,
                                                          fontSize: 13,
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
                                                            // Text('4',style: TextStyle(
                                                            //     color: AppColors.myWhite,
                                                            //     fontSize: 25,
                                                            //     fontWeight: FontWeight.w500,
                                                            //     fontFamily: AppStrings.appFont
                                                            // ),
                                                            //   textAlign: TextAlign.center,
                                                            // ),
                                                            const SizedBox(width: 10,),
                                                            Text('Not Started',style: TextStyle(
                                                                color: AppColors.myWhite,
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: AppStrings.appFont
                                                            ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            const SizedBox(width: 10,),
                                                            // Text('3',style: TextStyle(
                                                            //     color: AppColors.myWhite,
                                                            //     fontSize: 25,
                                                            //     fontWeight: FontWeight.w500,
                                                            //     fontFamily: AppStrings.appFont
                                                            // ),
                                                            //   textAlign: TextAlign.center,
                                                            // ),
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                  const SizedBox(width: 25,),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50)
                                                        ),
                                                        child: CachedNetworkImage(
                                                          cacheManager: AppCubit.get(context).manager,
                                                          imageUrl: "${AppCubit.get(context).allMatches[index].secondImage!}",
                                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                          fit: BoxFit.fitWidth,
                                                        ) ,
                                                      ),

                                                      const SizedBox(height: 5,),
                                                      Text(AppCubit.get(context).allMatches[index].secondTeam!,style: TextStyle(
                                                          color: AppColors.myWhite,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: AppStrings.appFont
                                                      ),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20,),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context,index){
                                      return  const SizedBox(height: 0,);
                                    },
                                    itemCount:AppCubit.get(context).allMatches.length
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}