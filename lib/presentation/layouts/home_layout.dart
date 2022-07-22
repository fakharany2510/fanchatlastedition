import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('World Cup'),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.navigateScreen(index);
              },

              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text("Home"),
                  selectedColor: AppColors.primaryColor,
                  unselectedColor: Colors.grey.shade600
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: const Icon(Icons.people_alt),
                  title: const Text("Fan"),
                  selectedColor: AppColors.primaryColor,
                    unselectedColor: Colors.grey.shade600
                ),

                /// Search
                SalomonBottomBarItem(
                  icon: const Icon(Icons.chat),
                  title: const Text("Chat"),
                  selectedColor: AppColors.primaryColor,
                    unselectedColor: Colors.grey.shade600
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: const Icon(Icons.menu),
                  title: const Text("More"),
                  selectedColor: AppColors.primaryColor,
                  unselectedColor: Colors.grey.shade600,
                ),
              ],
            ),

          );
        },
    );
  }
}
