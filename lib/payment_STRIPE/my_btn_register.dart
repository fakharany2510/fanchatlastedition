import 'package:fanchat/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBtnRegister extends StatelessWidget {
  final String title;
  final Function onTaped;

  MyBtnRegister({this.title = "Btn", required this.onTaped});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        onTaped();
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      child: Container(
        width:size.width* .7,
        height: size.height * .04,
        decoration: BoxDecoration(
          color: AppColors.primaryColor1,
          borderRadius: BorderRadius.circular(22.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 23
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

