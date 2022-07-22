import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FanScreen extends StatelessWidget {
  const FanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.myWhite,
      body: const Center(
        child: Text('Fan Screen',style: TextStyle(
            fontSize: 22,
            color: Colors.red
        ),),
      ),

    );
  }
}
