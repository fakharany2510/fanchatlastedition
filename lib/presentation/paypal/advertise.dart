// import 'package:fanchat/presentation/layouts/home_layout.dart';
// import 'package:fanchat/presentation/screens/home_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
//
// class PaypalPayment extends StatelessWidget {
//   final double amount;
//   final String currency;
//   const PaypalPayment({Key? key, required this.amount, required this.currency})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
//           },
//           child: const Icon(Icons.arrow_back_ios),
//         ),
//       ),
//       body: WebView(
//         initialUrl:
//         'http://localhost:3000/createpaypalpayment?amount=$amount&currency=$currency',
//         javascriptMode: JavascriptMode.unrestricted,
//         gestureRecognizers: Set()
//           ..add(Factory<DragGestureRecognizer>(
//                   () => VerticalDragGestureRecognizer())),
//         onPageFinished: (value) {
//           print(value);
//         },
//         navigationDelegate: (NavigationRequest request) async {
//           if (request.url.contains('http://return_url/?status=success')) {
//             print('return url on success');
//             Navigator.pop(context);
//           }
//           if (request.url.contains('http://cancel_url')) {
//             Navigator.pop(context);
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:lottie/lottie.dart';

class Advertise extends StatefulWidget {
  const Advertise({Key? key}) : super(key: key);

  @override
  State<Advertise> createState() => _AdvertiseState();
}

class _AdvertiseState extends State<Advertise> {
  bool paymentSuccess =false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      builder: (context,state){
        return Scaffold(
            backgroundColor: AppColors.primaryColor1,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor1,
              elevation: 0,
              title: Text('paypal'),
            ),
            body: Center(
              child: paymentSuccess == true
                  ?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/paysuccess.json'),
                  defaultButton(
                      width: 200,
                      height: 50,
                      buttonColor: AppColors.myGrey,
                      textColor: AppColors.primaryColor1,
                      buttonText: 'Back To Home Screen',
                      function: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
                      })
                ],
              )
                  :TextButton(
                  onPressed: () =>
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            UsePaypal(
                                sandboxMode: true,
                                clientId:
                                "AS3dt0VLbEokfK--WcLTAEVxVLKmZ58aCnO7qaKvNUv8DavQb8KTwHfnNDvCGhSIIg4G7-aYrwMJeRuJ",
                                secretKey:
                                "EESDxvGtTqCBQRAhuCW4v6VFsHvB3GI3Nu8hhNEQdolHwqYpP_eyQgZ-dGIfwpFEZIV_1vXt_xsXMo--",
                                returnURL: "https://samplesite.com/return",
                                cancelURL: "https://samplesite.com/cancel",
                                transactions: const [
                                  {
                                    "amount": {
                                      "total": '200',
                                      "currency": "USD",
                                      "details": {
                                        "subtotal": '200',
                                        "shipping": '0',
                                        "shipping_discount": 0
                                      }
                                    },
                                    "description":
                                    "fanchat advertise account",
                                    // "payment_options": {
                                    //   "allowed_payment_method":
                                    //       "INSTANT_FUNDING_SOURCE"
                                    // },
                                    "item_list": {
                                      "items": [
                                        {
                                          "name": "A demo product",
                                          "quantity": 1,
                                          "price": '200',
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
                                  CashHelper.saveData(key: 'advertise' , value: true);
                                 await FirebaseFirestore.instance.collection('users').doc(AppStrings.uId)
                                      .update({
                                    'advertise':true,
                                  }).then((value){
                                    setState((){
                                      paymentSuccess=true;});
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChoosePayPackage()));
                                    print('success to update aaccountStates');
                                  }).catchError((error){
                                    print('success to update aaccountStates${error.toString()}');
                                  });
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
      },
      listener: (BuildContext context, Object? state) {
        if(state is PaySuccessState){
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
          //  Navigator.push(
          //    context,
          //    MaterialPageRoute(
          //        builder: (newcontext) =>
          //        ChangeNotifierProvider<t extends BaseProvider>.value(
          //          value: Provider.of<>(context),
          //          child: HomeLayout(),
          //        )
          //    ),
          //  );
        }
      },
    );
  }

  }
