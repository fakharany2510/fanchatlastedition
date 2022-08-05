import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/src/animation/tween.dart';

import 'login_screen.dart';
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  {
  @override
  Widget build(BuildContext context) {
    return  SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 200,
      imageSize: 170,
      imageSrc: "assets/images/loginlogocolored.png",
      backgroundColor:AppColors.primaryColor1,
    );
  }
}
