import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/chat_screen.dart';
import '../screens/fan_screen.dart';
import '../screens/home_screen.dart';
import '../screens/match_details.dart';
import '../screens/more_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List <Widget> screens=[

      HomeScreen(pageHeight: MediaQuery.of(context).size.height,pageWidth:MediaQuery.of(context).size.width),
      const MatchDetails(),
      const FanScreen(),
      const ChatScreen(),
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
                    offset: Offset(0.0, .1), //(x,y)
                    blurRadius: 5,
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
                  selectedLabelStyle: TextStyle(
                      fontFamily: AppStrings.appFont
                  ),
                  unselectedLabelStyle:TextStyle(
                      fontFamily: AppStrings.appFont
                  ),
                  unselectedFontSize: 10,
                  selectedFontSize: 13,
                  backgroundColor: AppColors.primaryColor1.withOpacity(1),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  onTap: (value){
                    cubit.navigateScreen(value);
                  },
                  elevation: 20,

                  items: [
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("assets/images/home.png"),
                        color:AppColors.myGrey,
                      ),
                      activeIcon:ImageIcon(
                        AssetImage("assets/images/home.png"),
                        color:AppColors.navBarActiveIcon,
                      ),
                      label: 'Home',

                    ),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage("assets/images/times.png"),
                          color:AppColors.myGrey,
                        ),
                        activeIcon:ImageIcon(
                          AssetImage("assets/images/times.png"),
                          color:AppColors.navBarActiveIcon,
                        ),
                        label: 'Matches'
                    ),
                    BottomNavigationBarItem(
                        icon:ImageIcon(
                          AssetImage("assets/images/fanarea1.png"),
                          color:AppColors.myGrey,
                        ),
                        activeIcon:ImageIcon(
                          AssetImage("assets/images/fanarea1.png"),
                          color:AppColors.navBarActiveIcon,
                        ),
                        label: 'Fan'
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("assets/images/chat.png"),
                        color:AppColors.myGrey,
                      ),
                      label: 'Chat',
                      activeIcon:ImageIcon(
                        AssetImage("assets/images/chat.png"),
                        color:AppColors.navBarActiveIcon,
                      ),

                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("assets/images/profile.png"),
                        color:AppColors.myGrey,
                      ),
                      label: 'More',
                      activeIcon:ImageIcon(
                        AssetImage("assets/images/profile.png"),
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
