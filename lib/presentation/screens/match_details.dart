import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/matech_scedule.dart';
import 'package:fanchat/presentation/screens/single_match.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';

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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                          if(dateMatchs[index]=='20 Nov'){
                                            setState(() {
                                              dateMatch='Sun 20 Nov 2022';
                                              MatchScaduele.realTeamMatchesRight=MatchScaduele.teamMatches21Right;
                                              MatchScaduele.realImagesMatchesRight=MatchScaduele.imageMatches21Right;
                                              MatchScaduele.realTeamMatchesLeft=MatchScaduele.teamMatches21Left;
                                              MatchScaduele.realImagesMatchesLeft=MatchScaduele.imageMatches21Left;
                                            });
                                          }
                                          else if (dateMatchs[index]=='21 Nov'){
                                            setState(() {
                                              dateMatch='Mon 21 Nov 2022';
                                              MatchScaduele.realTeamMatchesRight=MatchScaduele.teamMatches22Right;
                                              MatchScaduele.realImagesMatchesRight=MatchScaduele.imageMatches22Right;
                                              MatchScaduele.realTeamMatchesLeft=MatchScaduele.teamMatches22Left;
                                              MatchScaduele.realImagesMatchesLeft=MatchScaduele.imageMatches22Left;
                                            });
                                          }
                                          else{
                                            MatchScaduele.realTeamMatchesRight=[];
                                            MatchScaduele.realImagesMatchesRight=[];
                                            MatchScaduele.realTeamMatchesLeft=[];
                                            MatchScaduele.realImagesMatchesLeft=[];
                                          }
                                          // Navigator.push(context, MaterialPageRoute(builder: (_){
                                          //   return const SingleMatch();
                                          // }));
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
                                            Text(dateMatch!,style: TextStyle(
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
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:  NetworkImage(MatchScaduele.realImagesMatchesRight[index]),
                                                    ),
                                                    const  SizedBox(height: 5,),
                                                    Text(MatchScaduele.realTeamMatchesRight[index],style: TextStyle(
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
                                                          Text('Not Start',style: TextStyle(
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

                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:  NetworkImage(MatchScaduele.realImagesMatchesLeft[index]),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    Text(MatchScaduele.realTeamMatchesLeft[index],style: TextStyle(
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
                                  itemCount:MatchScaduele.realTeamMatchesLeft.length
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