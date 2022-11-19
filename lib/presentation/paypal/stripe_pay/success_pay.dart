import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessPay extends StatefulWidget {
  const SuccessPay({super.key});

  @override
  State<SuccessPay> createState() => _SuccessPayState();
}

class _SuccessPayState extends State<SuccessPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Opacity(
                opacity: 1,
                child: Image(
                  image: AssetImage('assets/images/public_chat_image.jpeg'),
                  fit: BoxFit.cover,
                ),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/success_pay.json',
                        height: MediaQuery.of(context).size.height * .1),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Congratualtions\nYou have purchased Premium package\nYou are now enjoying FAN Chat\n for one year',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.4,
                    fontFamily: AppStrings.appFont,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.myWhite),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              defaultButton(
                  textColor: AppColors.myWhite,
                  buttonText: 'Ok',
                  buttonColor: const Color(0Xffd32330),
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .06,
                  function: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeLayout()),
                        (Route<dynamic> route) => false);
                  })
            ],
          )
        ],
      ),
    );
  }
}
