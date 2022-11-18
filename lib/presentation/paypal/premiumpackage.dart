// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fanchat/business_logic/cubit/app_cubit.dart';
// import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
// import 'package:fanchat/constants/app_colors.dart';
// import 'package:fanchat/constants/app_strings.dart';
// import 'package:fanchat/presentation/layouts/home_layout.dart';
// import 'package:fanchat/presentation/widgets/shared_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_paypal/flutter_paypal.dart';
// import 'package:lottie/lottie.dart';
//
// class PremiumPackage extends StatefulWidget {
//   const PremiumPackage({super.key}) ;
//
//   @override
//   State<PremiumPackage> createState() => _PremiumPackageState();
// }
//
// class _PremiumPackageState extends State<PremiumPackage> {
//   bool paymentSuccess=false;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppState>(
//       builder: (context,state){
//         return Scaffold(
//           backgroundColor: AppColors.primaryColor1,
//             body: Center(
//               child: paymentSuccess == true
//                   ?Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Lottie.asset('assets/images/paysuccess.json'),
//                   defaultButton(
//                       width: 200,
//                       height: 50,
//                       buttonColor: AppColors.myGrey,
//                       textColor: AppColors.primaryColor1,
//                       buttonText: 'Back To Home Screen',
//                       function: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
//                       })
//                 ],
//               )
//                   :UsePaypal(
//                   sandboxMode: false,
//                   clientId:
//                   "AR1MjIVVA1CS0X8hdaVPphbme4_oqEdLS2F4jyf173pasfShsoGdkXjvvMEHhkEcoVxA4bqoQ8Vump7R",
//                   secretKey:
//                   "ELiFdHo3vCj8zDLAXfKdizlfdkctPKlQXCWkz7OTFI183m_8SMW8NcOOVKHGmM7Lk5N25fz-t0maRfCZ",
//                   returnURL: "https://samplesite.com/return",
//                   cancelURL: "https://samplesite.com/cancel",
//                   transactions: const [
//                     {
//                       "amount": {
//                         "total": '20',
//                         "currency": "USD",
//                         "details": {
//                           "subtotal": '20',
//                           "shipping": '0',
//                           "shipping_discount": 0
//                         }
//                       },
//                       "description":
//                       "fanchat premium account",
//                       // "payment_options": {
//                       //   "allowed_payment_method":
//                       //       "INSTANT_FUNDING_SOURCE"
//                       // },
//                       "item_list": {
//                         "items": [
//                           {
//                             "name": "A demo product",
//                             "quantity": 1,
//                             "price": '20',
//                             "currency": "USD"
//                           }
//                         ],
//
//                         // shipping address is not required though
//                         "shipping_address": {
//                           "recipient_name": "Fanchat App",
//                           "line1": "Egypt",
//                           "line2": "",
//                           "city": "Banha",
//                           "country_code": "EG",
//                           "postal_code": "73301",
//                           "phone": "+201011755619",
//                           "state": "elramla"
//                         },
//                       }
//                     }
//                   ],
//                   note: "Contact us for any questions on your order.",
//                   onSuccess: (Map params) async {
//                     print("onSuccess: $params");
//                     CashHelper.saveData(key: 'business' , value: true);
//                     await FirebaseFirestore.instance.collection('users').doc(AppStrings.uId)
//                         .update({
//                       'business':true,
//                     }).then((value){
//                       setState((){
//                         paymentSuccess=true;
//                       });
//                       print('SUCCESS TO ACTIVE PAYMENT FIREBASE');
//                     }).catchError((error){
//                       print('ERROR TO ACTIVE PAYMENT FIREBASE ${error.toString()}');
//                     });
//                   },
//                   onError: (error) {
//                     print("onError: $error");
//                   },
//                   onCancel: (params) {
//                     print('cancelled: $params');
//                   }),
//             ));
//       },
//       listener: (BuildContext context, Object? state) {
//         if(state is PaySuccessState){
//          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
//          //  Navigator.push(
//          //    context,
//          //    MaterialPageRoute(
//          //        builder: (newcontext) =>
//          //        ChangeNotifierProvider<t extends BaseProvider>.value(
//          //          value: Provider.of<>(context),
//          //          child: HomeLayout(),
//          //        )
//          //    ),
//          //  );
//         }
//     },
//     );
//   }
//
// }
