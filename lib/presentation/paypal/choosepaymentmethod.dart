// import 'package:fanchat/constants/app_colors.dart';
// import 'package:fanchat/constants/app_strings.dart';
// import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
// import 'package:fanchat/presentation/widgets/shared_widgets.dart';
// import 'package:flutter/material.dart';
//
// class ChoosePaymentMethod extends StatefulWidget {
//   const ChoosePaymentMethod({super.key}) ;
//
//   @override
//   State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
// }
//
// class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
//   int _value=0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor1,
//       appBar: customAppbar('pay', context),
//       body: Padding(
//         padding: const EdgeInsets.only(bottom: 15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 20,left: 20),
//               child: Text('Please choose payment method',style: TextStyle(
//                 fontSize: 20,
//                 fontFamily: AppStrings.appFont,
//                 color: AppColors.myGrey
//               )),
//             ),
//             Row(
//               children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Container(
//                   height: 20,
//                   width:20,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(50)
//                   ),
//                   child:Radio(
//
//                       value: 1,
//                       groupValue: _value,
//                       onChanged: (value){
//                         setState((){
//                           _value=1;
//                         });
//                       }),
//                 ),
//               ),
//                 SizedBox(width:5,),
//                 Image(image: AssetImage('assets/images/chosepay1.png'),width: 100,height: 100,)
//               ],
//             ),
//             // Row(
//             //   children: [
//             //     Radio(
//             //         value: 2,
//             //         groupValue: _value,
//             //         onChanged: (value){
//             //           setState((){
//             //             _value=2;
//             //           });
//             //         }),
//             //     SizedBox(width:5,),
//             //     Image(image: AssetImage('assets/images/pay.png'),width: 100,height: 100,)
//             //   ],
//             // ),
//             // Row(
//             //   children: [
//             //     Radio(
//             //         value: 3,
//             //         groupValue: _value,
//             //         onChanged: (value){
//             //           setState((){
//             //             _value=3;
//             //           });
//             //         }),
//             //     SizedBox(width:5,),
//             //     Image(image: AssetImage('assets/images/premium.webp'),width: 100,height: 100,)
//             //   ],
//             // ),
//             Spacer(),
//             Center(
//
//               child: defaultButton(width: MediaQuery.of(context).size.width*.7,
//                   height: MediaQuery.of(context).size.height*.05,
//                   buttonColor: AppColors.myGrey,
//                   textColor:AppColors.primaryColor1,
//                   buttonText: 'Continue',
//                   function: (){
//                 if(_value==1){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChoosePayPackage()));
//                 }
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
