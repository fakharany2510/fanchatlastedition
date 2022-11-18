// import 'package:fanchat/business_logic/register/register_cubit.dart';
// import 'package:fanchat/business_logic/register/register_states.dart';
// import 'package:fanchat/constants/app_colors.dart';
// import 'package:fanchat/constants/app_strings.dart';
// import 'package:fanchat/presentation/layouts/home_layout.dart';
// import 'package:fanchat/presentation/widgets/shared_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../business_logic/shared/local/cash_helper.dart';
//
// class VerfiyOtp extends StatefulWidget {
//    VerfiyOtp({super.key,this.email}) ;
//
//    String ?email;
//   TextEditingController otp = TextEditingController();
//    var formKey =GlobalKey<FormState>();
//
//   @override
//   State<VerfiyOtp> createState() => _VerfiyOtpState();
// }
//
// class _VerfiyOtpState extends State<VerfiyOtp> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => RegisterCubit(),
//       child: BlocConsumer<RegisterCubit,RegisterState>(
//         builder: (context , state){
//           return Scaffold(
//             backgroundColor: AppColors.primaryColor1,
//             body: SingleChildScrollView(
//               child: Form(
//                 key: widget.formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   //mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 50),
//                       child: Center(
//                         child: Container(
//                           child:  Lottie.asset('assets/images/verify.json'),
//                           width: MediaQuery.of(context).size.width*.7,
//                           height: MediaQuery.of(context).size.height*.4,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     Text('Check Your Mail',
//                       style: TextStyle(
//                           fontFamily: AppStrings.appFont,
//                           color: AppColors.myGrey,
//                           fontWeight:FontWeight.bold,
//                           fontSize: 25
//                       ),
//                     ),
//                     SizedBox(height: 25,),
//                     Container(
//                       width: MediaQuery.of(context).size.width*.9,
//                       child:  textFormFieldWidget(
//                           context: context,
//                           controller:widget.otp ,
//                           errorMessage: "please chech your mail & enter otp",
//                           inputType: TextInputType.name,
//                           labelText:"Enter OTP",
//                           prefixIcon: Icon(Icons.lock_clock_rounded,color: AppColors.myGrey,)
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                     defaultButton(
//                         textColor: AppColors.primaryColor1,
//                         buttonText: 'Verify',
//                         buttonColor: AppColors.myGrey,
//                         width: MediaQuery.of(context).size.width*.9,
//                         height: MediaQuery.of(context).size.height*.06,
//                         function: (){
//                           if(widget.formKey.currentState!.validate()){
//                             RegisterCubit.get(context).verifyOtp(
//                                 widget.email!,
//                                 widget.otp.text);
//                           }
//
//                         }
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         listener: (context,state){
//           if(state is VerifyOtopSuccessState){
//               // CashHelper.saveData(
//               //   key: 'uid',
//               //   value: state.uId,
//               // );
//
//               customToast(title: 'Register Successful', color: AppColors.primaryColor1);
//               //AppCubit.get(context).getPosts();
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute
//                     (builder: (context)=>HomeLayout()));
//           }else if(state is VerifyOtopErrorState){
//             customToast(title: 'Invalid OTP', color: AppColors.primaryColor1);
//           }
//         },
//       ),
//     );
//   }
// }
