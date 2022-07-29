import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
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
            appBar: customAppbar(cubit.screensTitles[cubit.currentIndex]),
            body: screens[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar
              (
              type: BottomNavigationBarType.fixed,
               currentIndex: cubit.currentIndex,
                onTap: (value){
                  cubit.navigateScreen(value);
                },
                elevation: 5,

                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home,color: Colors.grey.shade600),
                      activeIcon:Icon(Icons.home,color: AppColors.primaryColor),
                      label: '',

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.timer_outlined,color:Colors.grey.shade600),
                      activeIcon:Icon(Icons.timer_outlined,color: AppColors.primaryColor),
                      label: ''
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people,color: Colors.grey.shade600),
                      activeIcon:Icon(Icons.people,color: AppColors.primaryColor),

                      label: ''
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat,color: Colors.grey.shade600),
                      label: '',
                    activeIcon:Icon(Icons.chat,color: AppColors.primaryColor),

                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu,color: Colors.grey.shade600,),
                      label: '',
                    activeIcon:Icon(Icons.menu,color: AppColors.primaryColor),


                  ),

                ]
            )

          );
        },
    );
  }
}
