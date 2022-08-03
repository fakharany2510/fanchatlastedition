import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/register/register_cubit.dart';
import 'package:fanchat/business_logic/register/register_states.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/screens/home_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';
import '../layouts/home_layout.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey =GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
         listener: (context,state){
            if(state is UserRegisterSuccessState){
                CashHelper.saveData(
                  key: 'uid',
                  value: state.uId,
                );

                customToast(title: 'Register Successful', color: AppColors.primaryColor1);
                //AppCubit.get(context).getPosts();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute
                        (builder: (context)=>HomeLayout()));

            }
            if(state is UserRegisterErrorState){
              customToast(title: 'Invalid Data ', color: Colors.red);

            }
         },
        builder: (context,state){
           var cubit=RegisterCubit.get(context);
           return Scaffold(
             backgroundColor: AppColors.primaryColor1,
             appBar: AppBar(
               backgroundColor: AppColors.myWhite,
               toolbarHeight: 0,
               elevation: 0,
               systemOverlayStyle:  SystemUiOverlayStyle(
                 statusBarIconBrightness: Brightness.light,
                 statusBarColor: AppColors.primaryColor1,
               ),
             ),
             body: Form(
               key: formKey,
               child: Padding(
                 padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children:  [
                       const Padding(
                         padding: EdgeInsets.symmetric(vertical: 30),
                         child:Image(image:AssetImage('assets/images/fanicon.png'),height: 190,width: 190,)
                       ),

                       SizedBox(height: size.height*.01,),
                       textFormFieldWidget(
                           context: context,
                           controller: name,
                           errorMessage: "please enter your name",
                           inputType: TextInputType.name,
                           labelText:"Name",
                           prefixIcon: Icons.person
                       ),
                       SizedBox(height: size.height*.03,),
                       textFormFieldWidget(
                           context: context,
                           controller: email,
                           errorMessage:"please enter your email",
                           inputType: TextInputType.emailAddress,
                           labelText:"Email",
                           prefixIcon: Icons.mail_sharp
                       ),

                       SizedBox(height: size.height*.03,),
                       textFormFieldWidget(
                           context: context,
                           controller: password,
                           errorMessage:"please enter your password",
                           inputType: TextInputType.visiblePassword,
                           labelText:"password",
                           prefixIcon: Icons.lock
                       ),

                       SizedBox(height: size.height*.03,),
                       textFormFieldWidget(
                           context: context,
                           controller: phone,
                           errorMessage:"please enter your phone",
                           inputType: TextInputType.phone,
                           labelText:"phone",
                           prefixIcon: Icons.phone
                       ),
                       SizedBox(height: size.height*.03,),
                       defaultButton(
                         textColor: AppColors.primaryColor1,
                           buttonText: 'REGISTER',
                           buttonColor: AppColors.myGrey,
                           width: size.width*.9,
                           height: size.height*.06,
                           function: (){
                              if(formKey.currentState!.validate()){
                                cubit.userRegister(email: email.text, pass: password.text,name: name.text,phone: phone.text).then((value) {
                                });
                              }

                           }
                       ),
                       SizedBox(height: size.height*.02,),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Have any account?",style: TextStyle(
                               fontFamily: AppStrings.appFont,
                               fontSize: 18,
                               color: AppColors.myGrey
                           ),),
                           TextButton(
                             onPressed: () {
                               Navigator.pushNamed(context, 'login');


                             },
                             child:  Text("Login",style: TextStyle(
                                 color: AppColors.primaryColor2,
                                 fontFamily: AppStrings.appFont,
                                 fontSize: 18
                             ),
                             ),
                           )
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           );
        },
      ),
    );
  }
}
