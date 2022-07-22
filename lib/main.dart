import 'package:bloc/bloc.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/login_screen.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:fanchat/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/bloc/bloc_observer.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  //await CacheHelper.init();
  //dynamic userId = CacheHelper.getDatat(key: 'userId');
  Widget widget;
  //if(userId !=null){
   // widget = HomePage();
  //}else{
    //widget = SplashScreen();
  //}
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit(),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nash2en Masr',
            theme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: AppColors.primaryColor,
              ),
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
              '/' :(context)=>const SplashScreen(),
              'login':(context)=> LoginScreen(),
              'register':(context)=>RegisterScreen(),
            },
          );
        },
      )
    );
  }
}


