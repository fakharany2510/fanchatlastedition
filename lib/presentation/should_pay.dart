import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';

class ShouldPay extends StatefulWidget {
  const ShouldPay({super.key});

  @override
  State<ShouldPay> createState() => _ShouldPayState();
}

class _ShouldPayState extends State<ShouldPay> {
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
                  image: AssetImage('assets/images/paypack.jpg'),
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
                  children: const [
                    Image(
                        image: AssetImage('assets/images/ncolort.png'),
                        width: 250,
                        height: 250),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'You should pay to continue using FanChat',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.4,
                    fontFamily: AppStrings.appFont,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor1),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              defaultButton(
                  textColor: AppColors.myWhite,
                  buttonText: 'Choose Package',
                  buttonColor: const Color(0Xffd32330),
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .06,
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChoosePayPackage()));
                  })
            ],
          )
        ],
      ),
    );
  }
}
