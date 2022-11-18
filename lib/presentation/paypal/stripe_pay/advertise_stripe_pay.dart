import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/paypal/stripe_pay/successadvertisepay.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class AdvertisePackage extends StatefulWidget {
  const AdvertisePackage({super.key});

  @override
  State<AdvertisePackage> createState() => _AdvertisePackageState();
}

class _AdvertisePackageState extends State<AdvertisePackage> {
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/public_chat_image.jpeg'),
                  fit: BoxFit.cover)),
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
                  fontFamily: AppStrings.appFont),
            ),
            const SizedBox(height: 10),
            Text(
              'Price : \$200 ',
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
              'Buy a advertise package and enjoy FanChat for one year and add your advertisement',
              style: TextStyle(
                color: Colors.red.shade900,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            defaultButton(
              function: () async {
                await makePayment();
              },
              textColor: AppColors.myWhite,
              buttonText: 'Buy Adverise Package',
              buttonColor: const Color(0Xffd32330),
              width: MediaQuery.of(context).size.width * .6,
              height: MediaQuery.of(context).size.height * .06,
            ),
            const SizedBox(height: 15)
          ],
        ),
      ]),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('200', 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Tolba',
            ),
          )
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      if (kDebugMode) {
        print('exception:$e$s');
      }
    }
  }

  ///success payed
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(AppStrings.uId)
            .update({'advertise': true, 'buyDate': DateTime.now()}).then(
                (value) {
          AppCubit.get(context).userModel!.advertise = true;
          AppCubit.get(context).userModel!.buyDate = DateTime.now();

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const SuccessPayAdvertise()),
              (route) => false);
          // print('success to update aaccountStates');
        }).catchError((error) {
          // print('success to update aaccountStates${error.toString()}');
        });
        paymentIntent = null;
      }).onError((error, stackTrace) {
        // print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Error is:---> $e');
      }
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      // print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${AppStrings.SECRET_KEY}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
