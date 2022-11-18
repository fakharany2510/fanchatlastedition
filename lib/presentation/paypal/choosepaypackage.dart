import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/stripe_pay/advertise_stripe_pay.dart';
import 'package:fanchat/presentation/paypal/stripe_pay/premium_stripe_pay.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';

class ChoosePayPackage extends StatefulWidget {
  const ChoosePayPackage({super.key});

  @override
  State<ChoosePayPackage> createState() => _ChoosePayPackageState();
}

class _ChoosePayPackageState extends State<ChoosePayPackage> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor1,
      appBar: customAppbar('payPackage', context),
      body: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 10, top: 25),
          child: CashHelper.getData(key: 'Advertise') == 1 &&
                  CashHelper.getData(key: 'premium') == 1
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No Packages to choose you are pay all packages',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.myWhite,
                        height: 2,
                        fontSize: 22,
                        fontFamily: AppStrings.appFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please select your package',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: AppStrings.appFont,
                                color: AppColors.myGrey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CashHelper.getData(key: 'premium') == 1
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Radio(
                                      value: 1,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = 1;
                                        });
                                      }),
                                ),
                              ),
                              const Image(
                                image: AssetImage('assets/images/premium.webp'),
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Premium Package',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: AppStrings.appFont,
                                        color: AppColors.myWhite),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '20 \$ for 1 year',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: AppStrings.appFont,
                                        color: AppColors.myGrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    CashHelper.getData(key: 'Advertise') == 1
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Radio(
                                      value: 2,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = 2;
                                        });
                                      }),
                                ),
                              ),
                              const Image(
                                image: AssetImage('assets/images/business.png'),
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Advertising Package',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: AppStrings.appFont,
                                        color: AppColors.myWhite),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '200 \$ forever',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: AppStrings.appFont,
                                        color: AppColors.myGrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    const Spacer(),
                    Center(
                      child: defaultButton(
                          width: MediaQuery.of(context).size.width * .7,
                          height: MediaQuery.of(context).size.height * .06,
                          buttonColor: const Color(0Xffd32330),
                          textColor: AppColors.myWhite,
                          buttonText: 'Pay',
                          function: () {
                            if (_value == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PremiumPackage()));
                            }
                            if (_value == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdvertisePackage()));
                            }
                          }),
                    )
                  ],
                )),
    );
  }
}
