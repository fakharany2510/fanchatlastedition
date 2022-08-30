import 'package:bloc/bloc.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/firebase_options.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/screens/add_new_image.dart';
import 'package:fanchat/presentation/screens/add_new_video.dart';
import 'package:fanchat/presentation/screens/add_text_post.dart';
import 'package:fanchat/presentation/screens/edit_profie_screen.dart';
import 'package:fanchat/presentation/screens/fan/fan_full_post.dart';
import 'package:fanchat/presentation/screens/login_screen.dart';
import 'package:fanchat/presentation/screens/messages_details.dart';
import 'package:fanchat/presentation/screens/profile_screen.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:fanchat/presentation/screens/splash_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/bloc/bloc_observer.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CashHelper.init();
  AppStrings.uId = CashHelper.getData(key: 'uid');
  printMessage('userId is: ${AppStrings.uId}');


  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers:[
          BlocProvider(create: (context)=>AppCubit()..getUser()..getPosts()..getAllUsers()..getFanPosts()),
        ],
        child: MaterialApp(
          title: 'fanchat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            navigationBarTheme: const NavigationBarThemeData(
              elevation: 1000,
            ),
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: AppColors.primaryColor1,
              )
            )
          ),
          initialRoute: '/',
          routes: {
            '/' :(context)=> SplashScreen(),
            'home_layout':(context)=> const HomeLayout(),
            'login':(context)=> LoginScreen(),
            'register':(context)=>RegisterScreen(),
            'profile':(context)=> ProfileScreen(),
            'edit_profile':(context)=>EditProfileScreen(),
            'add_image':(context)=>AddNewImage(),
            'add_video':(context)=>AddNewVideo(),
            'add_text':(context)=>AddTextPost(),
            'fan_post':(context)=>FanFullPost(),
            'message':(context)=>ChatDetails(userModel: AppCubit.get(context).userModel!,),

          },
        ),);
  }
}


