import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor1,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/ncolort.png'),
              width: 150,
              height: 150,
            ),
            Center(
              child: Lottie.asset(
                'assets/images/congratulations.json',
              ),
            ),
            defaultButton(
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.width * .15,
                buttonColor: AppColors.secondaryLightGreen,
                textColor: AppColors.myWhite,
                buttonText: 'Enjoy a 7-day free trial of FAN Chat',
                fontSize: 15,
                function: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeLayout()));
                }),
            SizedBox(
              height: MediaQuery.of(context).size.width * .15,
            ),
            defaultButton(
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.width * .15,
                buttonColor: AppColors.navBarActiveIcon,
                textColor: AppColors.myWhite,
                buttonText: 'Buy a package ',
                fontSize: 15,
                function: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChoosePayPackage()));
                })
          ],
        )),
      ),
    );
  }
}
