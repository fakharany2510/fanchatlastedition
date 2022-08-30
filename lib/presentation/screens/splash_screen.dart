import 'package:cached_video_player/cached_video_player.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/src/animation/tween.dart';
import 'package:video_player/video_player.dart';

import 'login_screen.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);
  Widget ?widget;
  void selectScreen(){
    if(AppStrings.uId !=null){
      widget = HomeLayout();
    }else{
      widget = LoginScreen();
    }
  }


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late VideoPlayerController controller;
  @override
  void initState() {
    widget.selectScreen();
    controller = VideoPlayerController.asset(
      "assets/images/fanVideo.mp4")
    ..initialize().then((value) {
       setState(() {
         controller.play();
       });
    });
    Future.delayed(const Duration(seconds: 3),(){
      widget.selectScreen();

      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){

        return widget.widget!;

      }));

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0.0,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor1,
              statusBarIconBrightness: Brightness.light
          )
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        )
            : Container(),
      ),

    );
  }
}
