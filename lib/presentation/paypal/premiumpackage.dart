import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PremiumPackage extends StatefulWidget {
  const PremiumPackage({Key? key}) : super(key: key);

  @override
  State<PremiumPackage> createState() => _PremiumPackageState();
}

class _PremiumPackageState extends State<PremiumPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('paypal'),
        ),
        body: Center(
          child: TextButton(
              onPressed: () =>
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UsePaypal(
                            sandboxMode: false,
                            clientId:
                            "AR1MjIVVA1CS0X8hdaVPphbme4_oqEdLS2F4jyf173pasfShsoGdkXjvvMEHhkEcoVxA4bqoQ8Vump7R",
                            secretKey:
                            "ELiFdHo3vCj8zDLAXfKdizlfdkctPKlQXCWkz7OTFI183m_8SMW8NcOOVKHGmM7Lk5N25fz-t0maRfCZ",
                            returnURL: "https://samplesite.com/return",
                            cancelURL: "https://samplesite.com/cancel",
                            transactions: const [
                              {
                                "amount": {
                                  "total": '20',
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": '20',
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                "fanchat premium account",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "A demo product",
                                      "quantity": 1,
                                      "price": '20',
                                      "currency": "USD"
                                    }
                                  ],

                                  // shipping address is not required though
                                  "shipping_address": {
                                    "recipient_name": "fanchat App",
                                    "line1": "Travis County",
                                    "line2": "",
                                    "city": "Austin",
                                    "country_code": "US",
                                    "postal_code": "73301",
                                    "phone": "+00000000",
                                    "state": "Texas"
                                  },
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              print("onSuccess: $params");
                            },
                            onError: (error) {
                              print("onError: $error");
                            },
                            onCancel: (params) {
                              print('cancelled: $params');
                            }),
                  ),
                )
              },
              child: const Text("Make Payment")),
        ));
  }

}