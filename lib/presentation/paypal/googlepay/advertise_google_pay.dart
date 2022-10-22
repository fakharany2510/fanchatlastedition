import 'package:fanchat/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class AdvertiseGooglePay extends StatefulWidget {
  AdvertiseGooglePay({Key? key}) : super(key: key);

  @override
  _AdvertiseGooglePayState createState() => _AdvertiseGooglePayState();
}

class _AdvertiseGooglePayState extends State<AdvertiseGooglePay> {

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
                  'Advertise package for FanChat app',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppStrings.appFont
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price : \$200 Forever',
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Details of Advertise package',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Buy a premium package and enjoy FanChat froever',
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