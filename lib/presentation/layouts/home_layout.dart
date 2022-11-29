import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/screens/advertising/advertising_screen.dart';
import 'package:fanchat/presentation/screens/countries_screen.dart';
import 'package:fanchat/presentation/screens/public_chat/public_chat_screen.dart';
import 'package:fanchat/presentation/should_pay.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_version/new_version.dart';

import '../screens/fan/fan_screen.dart';
import '../screens/home_screen.dart';
import '../screens/matches/match_details.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {

    print('ppppppppppppppppppppppppppppppppppppppppppayed 11111111111');
    AppCubit.get(context).getUser(context).then((value) async {
      print('///////////////////////////////////////////////////////////${AppCubit.get(context).userModel!.buyDate}');
      print('///////////////////////////////////////////////////////////${AppCubit.get(context).userModel!.trialStartDate}');
      print('ppppppppppppppppppppppppppppppppppppppppppayed 22222222222222222');
      if (AppCubit.get(context).userModel!.buyDate != null ) {
        print('ppppppppppppppppppppppppppppppppppppppppppayed 33333333333333333333');
        if ((DateTime.now().difference(AppCubit.get(context).userModel!.buyDate!)).inDays >= 365) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(AppStrings.uId)
              .update({
            'advertise': false,
            'premium': false,
          }).then((value) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const ShouldPay(),
                ),
                (route) => false);
          });
        }
      } else {
        print('1111111111111111111111111111111111111111111111');
        print('1111111111111111111111111111111111111111111111  -----${DateTime.parse(AppCubit.get(context).userModel!.trialStartDate!)}');
        print('1111111111111111111111111111111111111111111111  ${((DateTime.now()).difference(DateTime.parse(AppCubit.get(context).userModel!.trialStartDate!)).inSeconds) }');
        if (((DateTime.now()).difference(DateTime.parse(AppCubit.get(context).userModel!.trialStartDate!)).inDays) >= 3) {
          print('2222222222222222222222222222222222222222222222222222');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const ShouldPay(),
              ),
              (route) => false);
        }else{
          print('oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
        }
      }
    }).catchError((error) {
      // print('error');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(
          pageHeight: MediaQuery.of(context).size.height,
          pageWidth: MediaQuery.of(context).size.width),
      const MatchDetails(),
      const FanScreen(),
      const CountriesScreen(),
       PublicChatScreen(),
      const AdvertisingScreen(),
    ];

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar:
              customAppbar(cubit.screensTitles[cubit.currentIndex], context),
          body: screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              //border: Border.symmetric(horizontal: BorderSide(width: 1,color: AppColors.navBarActiveIcon),),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navBarActiveIcon,
                  offset: const Offset(0, .1), //(x,y)
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: AppColors.navBarActiveIcon,
                  offset: const Offset(0, .3), //(x,y)
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: AppColors.navBarActiveIcon,
                  offset: const Offset(0, .5), //(x,y)
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: AppColors.navBarActiveIcon,
                  offset: const Offset(0, .08), //(x,y)
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: AppColors.navBarActiveIcon,
                  offset: const Offset(0, .01), //(x,y)
                  blurRadius: 2,
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedIconTheme:
                  IconThemeData(color: AppColors.navBarActiveIcon, size: 25),
              unselectedIconTheme: IconThemeData(
                color: AppColors.myGrey,
                size: 20,
              ),
              unselectedItemColor: AppColors.myGrey,
              selectedLabelStyle:
                  const TextStyle(fontFamily: AppStrings.appFont),
              unselectedLabelStyle: const TextStyle(
                fontFamily: AppStrings.appFont,
              ),
              unselectedFontSize: 10,
              selectedFontSize: 13,
              backgroundColor: AppColors.primaryColor1.withOpacity(1),
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.navigateScreen(value, context);
              },
              elevation: 20,
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    const AssetImage("assets/images/home.png"),
                    color: AppColors.myGrey,
                  ),
                  activeIcon: ImageIcon(
                    const AssetImage("assets/images/home.png"),
                    color: AppColors.navBarActiveIcon,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    const AssetImage("assets/images/times.png"),
                    color: AppColors.myGrey,
                  ),
                  activeIcon: ImageIcon(
                    const AssetImage("assets/images/times.png"),
                    color: AppColors.navBarActiveIcon,
                  ),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage("assets/images/gallery.png"),
                      color: AppColors.myGrey,
                    ),
                    activeIcon: ImageIcon(
                      const AssetImage("assets/images/gallery.png"),
                      color: AppColors.navBarActiveIcon,
                    ),
                    label: 'Gallery'),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    const AssetImage("assets/images/teanchatn.png"),
                    color: AppColors.myGrey,
                  ),
                  label: 'Team chat',
                  activeIcon: ImageIcon(
                    const AssetImage("assets/images/teanchatn.png"),
                    color: AppColors.navBarActiveIcon,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    const AssetImage("assets/images/chat.png"),
                    color: AppColors.myGrey,
                  ),
                  activeIcon: ImageIcon(
                    const AssetImage("assets/images/chat.png"),
                    color: AppColors.navBarActiveIcon,
                  ),
                  label: 'Public chat',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    const AssetImage("assets/images/ad-icon.png"),
                    color: AppColors.myGrey,
                  ),
                  label: 'Ads',
                  activeIcon: ImageIcon(
                    const AssetImage("assets/images/ad-icon.png"),
                    color: AppColors.navBarActiveIcon,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<void> showMyDialog2(context) async {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 70,
                child: Image(
                  image: AssetImage('assets/images/ncolort.png'),
                  height: 100,
                  width: 100,
                ),
              ),
              Center(
                child: Text(
                  'Get a premium package',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.appFont,
                    color: AppColors.primaryColor1,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Column(
            children: [
              defaultButton(
                  width: MediaQuery.of(context).size.width * .7,
                  height: MediaQuery.of(context).size.height * .07,
                  buttonColor: AppColors.navBarActiveIcon,
                  textColor: AppColors.myWhite,
                  buttonText: 'Buy a package ',
                  fontSize: 15,
                  function: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChoosePayPackage(),
                        ));
                  })
            ],
          )
        ],
      );
    },
  );
}
