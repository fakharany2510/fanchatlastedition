import 'package:fanchat/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class PremiumGooglePay extends StatefulWidget {
  PremiumGooglePay({Key? key}) : super(key: key);

  @override
  _PremiumGooglePayState createState() => _PremiumGooglePayState();
}

class _PremiumGooglePayState extends State<PremiumGooglePay> {

  static const _paymentItems = [
    PaymentItem(
      label: 'Premium package',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children: [
         Container(
          height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/images/public_chat_image.jpeg'),
      fit: BoxFit.cover
    )
    ),
        ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Image(
                  image: AssetImage('assets/images/ncolors.png'),
                  height: 350,
                ),
              ),
              const Text(
                'Premium package for FanChat app',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.appFont
                ),
              ),
              const SizedBox(height: 10),
               Text(
                'Price : \$20 For one year',
                style: TextStyle(
                  color: Colors.red.shade900,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Details of premium package',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
               Text(
                'Buy a premium package and enjoy FanChat fro 1 year',
                style: TextStyle(
                  color: Colors.red.shade900,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              GooglePayButton(
                paymentConfigurationAsset:
                'json/default_payment_profile_google_pay.json',
                paymentItems: _paymentItems,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // ApplePayButton(
              //   paymentConfigurationAsset: 'default_payment_profile_apple_pay.json',
              //   paymentItems: _paymentItems,
              //   style: ApplePayButtonStyle.black,
              //   type: ApplePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15.0),
              //   onPaymentResult: onApplePayResult,
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
              // const SizedBox(height: 15)
            ],
          ),
    ]
      ),

    );
  }
}