import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../widgets/shared_widgets.dart';
class LoginScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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

                textFormFieldWidget(
                    context: context,
                    controller: email,
                    errorMessage: "please enter your email",
                    inputType: TextInputType.emailAddress,
                    labelText:"email",
                    prefixIcon: Icons.mail_sharp
                ),
                SizedBox(height: size.height*.03,),
                textFormFieldWidget(
                    context: context,
                    controller: password,
                    errorMessage:"please enter your password",
                    inputType: TextInputType.visiblePassword,
                    labelText:"password",
                    prefixIcon: Icons.password
                ),
                SizedBox(height: size.height*.03,),
                defaultButton(
                    buttonText: 'LOGIN',
                    buttonColor: AppColors.primaryColor,
                    size: size,
                    function: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return const HomeLayout();
                      }));
                    }
                ),
                SizedBox(height: size.height*.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: size.width*.3,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 5,),
                    const Text('or',
                    style: TextStyle(
                      fontSize:16,
                      color: Colors.black
                    ),
                    ),
                    const SizedBox(width: 5,),
                    Container(
                      height: 1,
                      width: size.width*.3,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
                SizedBox(height: size.height*.03,),
                Row(
                  children: [
                    defaultSocialMediaButton(
                      context: context,
                        function: (){},
                        size:size,
                        buttonColor: AppColors.myWhite,
                        buttonText: "Facebook",
                        imagePath: 'assets/images/face.png'
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*.03,),
                    defaultSocialMediaButton(
                      context: context,
                        function: (){

                        },
                        size:size,
                        buttonColor: AppColors.myWhite,
                        buttonText: "Google",
                        imagePath: 'assets/images/google1.png'
                    ),
                  ],
                ),
                SizedBox(height: size.height*.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont Have Account ?",style: TextStyle(
                        //fontFamily: AppStrings.appFont,
                        fontSize: 18,
                        color: AppColors.primaryColor
                    ),),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child:  Text("register",style: TextStyle(
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
  }
}