import 'package:bloc/bloc.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/firebase_options.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/screens/add_new_image.dart';
import 'package:fanchat/presentation/screens/add_new_video.dart';
import 'package:fanchat/presentation/screens/add_text_post.dart';
import 'package:fanchat/presentation/screens/edit_profie_screen.dart';
import 'package:fanchat/presentation/screens/login_screen.dart';
import 'package:fanchat/presentation/screens/profile_screen.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:fanchat/presentation/screens/select_national.dart';
import 'package:fanchat/presentation/screens/splash_screen.dart';
import 'package:fanchat/presentation/screens/test.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    String widget;
    if(AppStrings.uId !=null){
      widget = 'home_layout';
    }else{
      widget = '/';
    }
    return MultiBlocProvider(
        providers:[
          BlocProvider(create: (context)=>AppCubit()..getUser()..getPosts()..testLikes()..testComments()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: widget,
          routes: {
            '/' :(context)=>const SplashScreen(),
            'home_layout':(context)=> const HomeLayout(),
            'login':(context)=> LoginScreen(),
            'register':(context)=>RegisterScreen(),
            'profile':(context)=> ProfileScreen(),
            'edit_profile':(context)=>EditProfileScreen(),
            'select_national':(context)=>SelectNational(),
            'add_image':(context)=>AddNewImage(),
            'add_video':(context)=>AddNewVideo(),
            'add_text':(context)=>AddTextPost(),

          },
        ),);
  }
}


