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