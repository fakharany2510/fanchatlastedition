// ignore_for_file: file_names

import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/stripe_pay/advertise_stripe_pay.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AdsNav extends StatefulWidget {
  const AdsNav({super.key});

  @override
  State<AdsNav> createState() => _AdsNavState();
}

class _AdsNavState extends State<AdsNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Opacity(
                  opacity: 1,
                  child: Image(
                    image: AssetImage('assets/images/imageback.jpg'),
                    fit: BoxFit.cover,
                  ),
                )),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/images/lockedfan.json',
                    ),
                  ),
                  Text(
                    'Only Advertisers Can Add Their Ads',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.5,
                        color: AppColors.primaryColor1,
                        fontFamily: AppStrings.appFont,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  defaultButton(
                    textColor: AppColors.myWhite,
                    buttonColor: const Color(0Xffd32330),
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .06,
                    buttonText: 'Buy Advertise Package',
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdvertisePackage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
