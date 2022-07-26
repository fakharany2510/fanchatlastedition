import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MatchDetails extends StatelessWidget {
  const MatchDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myWhite,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: AppColors.myWhite,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Today',style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 7,),
                Text('25-7-2022',style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 7,),
                Container(
                  height: 1,
                  width: 140,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 1,
                  width: 110,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 5,),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  child: Material(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 15,
                                  backgroundImage: AssetImage('assets/images/worldcup.jpg'),
                                ),
                                const SizedBox(width: 10,),
                                Text('Matches',style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 1050,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                return Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const CircleAvatar(
                                                radius: 35,
                                                backgroundImage:  NetworkImage('https://img.freepik.com/premium-photo/flag-france_135932-1458.jpg?w=740'),
                                              ),
                                              const SizedBox(height: 5,),
                                              Text('France',style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500
                                              ),),

                                            ],
                                          ),
                                          const SizedBox(width: 15,),
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(90),
                                              border: Border.all(
                                                color: AppColors.primaryColor
                                              )
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('4 - 2',style: TextStyle(
                                                    color: AppColors.primaryColor,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                                const SizedBox(height: 5,),
                                               // const Text('Finish',style: TextStyle(
                                               //      color: Colors.red,
                                               //      fontSize: 15,
                                               //      fontWeight: FontWeight.w500
                                               //  ),),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 5,),
                                          Column(
                                            children: [
                                              const CircleAvatar(
                                                radius: 35,
                                                backgroundImage:  NetworkImage('https://img.freepik.com/premium-photo/argentinian-flag-close-up-view_625455-806.jpg?w=740'),
                                              ),
                                              const SizedBox(height: 5,),
                                              Text('Argentinian',style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context,index){
                                return const SizedBox(height: 15,);
                              },
                              itemCount: 9
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
    );
  }
}
