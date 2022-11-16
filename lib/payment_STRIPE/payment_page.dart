import 'dart:convert';

import 'package:fanchat/payment_STRIPE/payment_api.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  Map<String, dynamic>? paymentIntentData;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeServices.init();
  }
  final CreditCard testCard = CreditCard(
    number: '4242424242424242',
    expMonth: 12,
    expYear: 24,
    cvc: "123",
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
            onPressed: () async
            {
              var response = await StripeServices.payNowHandler(amount: '1000', currency: 'EGP', testCard: testCard);
              print('response message ${response.message}');

            },
            child: Text('pay 1000 \$'),
          )),
    );
  }



}