import 'package:fanchat/business_logic/register/register_cubit.dart';
import 'package:fanchat/business_logic/register/register_states.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              customToast(title: 'Register Successful', color: AppColors.primaryColor);
              Navigator.pushNamed(context, 'login');

            }
            if(state is UserRegisterErrorState){
              customToast(title: 'Invalid Data ', color: Colors.red);

            }
         },
        builder: (context,state){
           var cubit=RegisterCubit.get(context);
           return Scaffold(
             backgroundColor: AppColors.myWhite,
             body: Form(
               key: formKey,
               child: Padding(
                 padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children:  [
                       const Padding(
                         padding: EdgeInsets.symmetric(vertical: 30),
                         child: CircleAvatar(
                           radius: 100,
                           backgroundImage:AssetImage('assets/images/worldcup.jpg'),
                         ),
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
                           buttonText: 'REGISTER',
                           buttonColor: AppColors.primaryColor,
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
                             //fontFamily: AppStrings.appFont,
                               fontSize: 18,
                               color: AppColors.primaryColor
                           ),),
                           TextButton(
                             onPressed: () {
                               Navigator.pushNamed(context, 'login');


                             },
                             child:  Text("Login",style: TextStyle(
                                 color: AppColors.darkGreen,
                                 // fontFamily: AppStrings.appFont,
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
