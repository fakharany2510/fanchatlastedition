import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/choosepaymentmethod.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/screens/countries_screen.dart';
import 'package:fanchat/presentation/screens/public_chat/public_chat_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/chat_screen.dart';
import '../screens/fan/fan_screen.dart';
import '../screens/home_screen.dart';
import '../screens/match_details.dart';
import '../screens/more_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState(){
    super.initState();
    AppCubit.get(context).getUser().then((value){
      print('llllljjjjjjjjjjjjjjjjjjjjjjjj${AppCubit.get(context).userModel!.accountActive }');
      Future.delayed(const Duration(days: 7),(){
        if( AppCubit.get(context).userModel!.accountActive == false){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChoosePaymentMethod()));
          print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        }else{
          print('payed');

        }
      });
    }).catchError((error){
      print('error');
    });



  }
  Widget build(BuildContext context) {
    List <Widget> screens=[

      HomeScreen(pageHeight: MediaQuery.of(context).size.height,pageWidth:MediaQuery.of(context).size.width),
      MatchDetails(),
      const FanScreen(),
      const CountriesScreen(),
      PublicChatScreen(),
      const MoreScreen(),


    ];

    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: customAppbar(cubit.screensTitles[cubit.currentIndex],context),
            body: screens[cubit.currentIndex],

            bottomNavigationBar:Container(

              decoration: BoxDecoration(
                //border: Border.symmetric(horizontal: BorderSide(width: 1,color: AppColors.navBarActiveIcon)),
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
              child: BottomNavigationBar
                (
                  selectedIconTheme:IconThemeData(
                      color: AppColors.navBarActiveIcon,
                      size: 25
                  ) ,
                  unselectedIconTheme:IconThemeData(
                    color: AppColors.myGrey,
                    size:20,
                  ) ,

                  unselectedItemColor: AppColors.myGrey,
                  selectedLabelStyle: const TextStyle(
                      fontFamily: AppStrings.appFont
                  ),
                  unselectedLabelStyle:const TextStyle(
                      fontFamily: AppStrings.appFont
                  ),
                  unselectedFontSize: 10,
                  selectedFontSize: 13,
                  backgroundColor: AppColors.primaryColor1.withOpacity(1),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  onTap: (value){
                    cubit.navigateScreen(value,context);
                  },
                  elevation: 20,

                  items: [
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        const AssetImage("assets/images/home.png"),
                        color:AppColors.myGrey,
                      ),
                      activeIcon:ImageIcon(
                        const AssetImage("assets/images/home.png"),
                        color:AppColors.navBarActiveIcon,
                      ),
                      label: 'Home',

                    ),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          const AssetImage("assets/images/times.png"),
                          color:AppColors.myGrey,
                        ),
                        activeIcon:ImageIcon(
                          const AssetImage("assets/images/times.png"),
                          color:AppColors.navBarActiveIcon,
                        ),
                        label: 'Matches'
                    ),
                    BottomNavigationBarItem(
                        icon:ImageIcon(
                          const AssetImage("assets/images/fanarea1.png"),
                          color:AppColors.myGrey,
                        ),
                        activeIcon:ImageIcon(
                          const AssetImage("assets/images/fanarea1.png"),
                          color:AppColors.navBarActiveIcon,
                        ),
                        label: 'Fan'
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        const AssetImage("assets/images/team.png"),
                        color:AppColors.myGrey,
                      ),
                      label: 'Team Chat',
                      activeIcon:ImageIcon(
                        const AssetImage("assets/images/chat.png"),
                        color:AppColors.navBarActiveIcon,
                      ),

                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        const AssetImage("assets/images/chat.png"),
                        color:AppColors.myGrey,
                      ),
                      activeIcon:ImageIcon(
                        const AssetImage("assets/images/chat.png"),
                        color:AppColors.navBarActiveIcon,
                      ),
                      label: 'public chat',

                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                       const AssetImage("assets/images/profile.png"),
                        color:AppColors.myGrey,
                      ),
                      label: 'More',
                      activeIcon:ImageIcon(
                        const AssetImage("assets/images/profile.png"),
                        color:AppColors.navBarActiveIcon,
                      ),


                    ),

                  ]
              ),
            )


          );
        },
    );
  }
}
