// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  Widget? widget;

  SplashScreen({super.key, this.widget});
  void selectScreen(context) {
    if (AppStrings.uId != null) {
      AppCubit.get(context).getUser(context);
      AppCubit.get(context).getAllUsers();
      AppCubit.get(context).getLastUsers();
      widget = const HomeLayout();
    } else {
      widget = const RegisterScreen();
    }
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController controller;
  @override
  void initState() {
    widget.selectScreen(context);
    controller = VideoPlayerController.asset("assets/images/fanVideo.mp4")
      ..initialize().then((value) {
        setState(() {
          controller.play();
        });
      });
    Future.delayed(const Duration(seconds: 3), () {
      widget.selectScreen(context);

      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return widget.widget!;
      }));
    });

    // AppCubit.get(context).getUser(context).then((value){
    //   print('llllljjjjjjjjjjjjjjjjjjjjjjjj${CashHelper.getData(key: 'business')}');
    //   print('llllljjjjjjjjjjjjjjjjjjjjjjjj${CashHelper.getData(key: 'advertise') }');
    //   Future.delayed(const Duration(seconds: 7),(){
    //     if( CashHelper.getData(key: 'business') == true || CashHelper.getData(key: 'advertise') == true){
    //       print('payed');
    //     }else{
    //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>ChoosePaymentMethod()), (route) => false);
    //       //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChoosePaymentMethod()));
    //
    //     }
    //   });
    // }).catchError((error){
    //   print('error');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0.0,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor1,
              statusBarIconBrightness: Brightness.light)),
      body: SizedBox(
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
