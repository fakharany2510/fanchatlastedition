import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/screens/edit_profie_screen.dart';
import 'package:fanchat/presentation/screens/private_chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        cubit.userModel!.uId = AppStrings.uId;
        return Scaffold(
          backgroundColor: AppColors.primaryColor1,
          body: (cubit.userModel!.uId != null)
              ? SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage('${cubit.userModel!.image}'),
                            radius: 60,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${cubit.userModel!.username}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                fontFamily: AppStrings.appFont,
                                color: AppColors.myWhite),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: size.height,
                              child: ListView(
                                children: [
                                  InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      width: size.width,
                                      height: size.height * .05,
                                      decoration: BoxDecoration(
                                          color: const Color(0Xffd32330),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: AppColors.myWhite,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Profile',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.myWhite,
                                                fontFamily: AppStrings.appFont),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: AppColors.myWhite,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const EditProfileScreen();
                                      }));
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      width: size.width,
                                      height: size.height * .05,
                                      decoration: BoxDecoration(
                                          color: const Color(0Xffd32330),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const ImageIcon(
                                            AssetImage(
                                                "assets/images/chat.png"),
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Private Chat',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.myWhite,
                                                fontFamily: AppStrings.appFont),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: AppColors.myWhite,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChatsScreen()));
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      width: size.width,
                                      height: size.height * .05,
                                      decoration: BoxDecoration(
                                          color: const Color(0Xffd32330),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const ImageIcon(
                                            AssetImage(
                                                "assets/images/card.png"),
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Upgrade Your Package',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.myWhite,
                                                fontFamily: AppStrings.appFont),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: AppColors.myWhite,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChoosePayPackage()));
                                    },
                                  ),

                                  const SizedBox(height: 10),

                                  InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      width: size.width,
                                      height: size.height * .05,
                                      decoration: BoxDecoration(
                                          color: const Color(0Xffd32330),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            color: AppColors.myWhite,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Logout',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.myWhite,
                                                fontFamily: AppStrings.appFont),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: AppColors.myWhite,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showMyDialog(context);
                                    },
                                  ),
                                  // const SizedBox(height:10),
                                  // InkWell(
                                  //   child: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         vertical: 0,
                                  //         horizontal: 10
                                  //     ),
                                  //     margin: const EdgeInsets.symmetric(
                                  //         vertical: 0,
                                  //         horizontal: 10
                                  //     ),
                                  //     width: size.width,
                                  //     height: size.height*.05,
                                  //     decoration: BoxDecoration(
                                  //         color: AppColors.myGrey,
                                  //         borderRadius: BorderRadius.circular(10)
                                  //     ),
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       children: [
                                  //         Icon(Icons.logout,color: AppColors.primaryColor1,size: 25,),
                                  //         const SizedBox(width: 5,),
                                  //         Text('payment',style: TextStyle(
                                  //             fontSize: 17,
                                  //             fontWeight: FontWeight.w500,
                                  //             color: AppColors.primaryColor1,
                                  //             fontFamily: AppStrings.appFont
                                  //         ),
                                  //         ),
                                  //         const Spacer(),
                                  //         Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryColor1,size: 20,),
                                  //       ],
                                  //     ),
                                  //   ),
                                  //   onTap: (){
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  //     CardFormScreen()
                                  //     ));
                                  //   },
                                  // ),
                                  ///////////////////////////////////////////////////
                                  // InkWell(
                                  //   child: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         vertical: 0,
                                  //         horizontal: 10
                                  //     ),
                                  //     margin: const EdgeInsets.symmetric(
                                  //         vertical: 0,
                                  //         horizontal: 10
                                  //     ),
                                  //     width: size.width,
                                  //     height: size.height*.05,
                                  //     decoration: BoxDecoration(
                                  //         color: AppColors.myGrey,
                                  //         borderRadius: BorderRadius.circular(10)
                                  //     ),
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       children: [
                                  //         Icon(Icons.logout,color: AppColors.primaryColor1,size: 25,),
                                  //         const SizedBox(width: 5,),
                                  //         Text('Payment',style: TextStyle(
                                  //             fontSize: 17,
                                  //             fontWeight: FontWeight.w500,
                                  //             color: AppColors.primaryColor1,
                                  //             fontFamily: AppStrings.appFont
                                  //         ),
                                  //         ),
                                  //         const Spacer(),
                                  //         Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryColor1,size: 20,),
                                  //       ],
                                  //     ),
                                  //   ),
                                  //   onTap: (){
                                  //    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen() ));
                                  //   },
                                  // ),

                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor1,
                  ),
                ),
        );
      },
    );
  }

  Future<void> showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.myWhite,
          // title: const Text('Aew you sure you want to logout from FanChat'),
          content: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: const Image(
                      image: AssetImage('assets/images/x-mark.png'),
                      height: 20,
                      width: 20),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 70,
                child: Image(
                  image: AssetImage('assets/images/ncolort.png'),
                  height: 100,
                  width: 100,
                ),
              ),
              const Text(
                'Are you sure you want to logout from FanChat',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          )),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: AppColors.navBarActiveIcon,
                        fontSize: 18,
                        fontFamily: AppStrings.appFont,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    CashHelper.saveData(key: 'advertise', value: false);
                    CashHelper.saveData(key: 'business', value: false);
                    AppCubit.get(context).signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'register', (Route<dynamic> route) => false);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
