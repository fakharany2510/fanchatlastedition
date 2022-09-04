import 'package:fanchat/business_logic/login/login_cubit.dart';
import 'package:fanchat/business_logic/login/login_state.dart';
import 'package:fanchat/business_logic/register/register_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../business_logic/register/register_states.dart';
import '../../constants/app_colors.dart';
import '../widgets/shared_widgets.dart';
class LoginScreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){
          if(state is UserLoginSuccessState){
            CashHelper.saveData(
              key: 'uid',
              value: state.uId,
            );
            customToast(title: 'Login Successful', color: AppColors.primaryColor1);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>HomeLayout())
            );

          }
          if(state is UserLoginErrorState){
            customToast(title: 'Email or Password isn\'t correct', color: Colors.red);
          }
          if(state is GoogleLoginSuccessState){
            CashHelper.saveData(key:'uid' , value: AppStrings.uId).then((value){
              Fluttertoast.showToast(
                msg:"Welcome",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 18.0,
              );
              if(AppStrings.uId == null){
                print('uid is null');
              }else{
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>HomeLayout()));
              }

            }).catchError((error){
              print('error from saving user google id to shared ${error.toString()}');
            });
          }
          //facebook check
          if(state is FacebookLoginSuccessState){
            CashHelper.saveData(key:'uid' , value: AppStrings.uId).then((value){
              Fluttertoast.showToast(
                msg:"Welcome",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 18.0,
              );
              if(AppStrings.uId == null){
                print('uid is null');
              }else{
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>HomeLayout()));
              }

            }).catchError((error){
              print('error from saving user facebook id to shared ${error.toString()}');
            });
          }

        },
        builder: (context,state){
          var cubit=LoginCubit.get(context);
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
                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      Image(image: AssetImage('assets/images/ncolort.png'),width: 250,height: 250,),

                      textFormFieldWidget(
                          context: context,
                          controller: email,
                          errorMessage: "please enter your email",
                          inputType: TextInputType.emailAddress,
                          labelText:"email",
                          prefixIcon: Icon(Icons.mail_sharp,color: AppColors.myGrey,)
                      ),
                      SizedBox(height: size.height*.03,),
                      textFormFieldWidget(
                          context: context,
                          controller: password,
                          errorMessage:"please enter your password",
                          inputType: TextInputType.visiblePassword,
                          labelText:"password",
                          prefixIcon: Icon(Icons.lock,color: AppColors.myGrey)
                      ),
                      SizedBox(height: size.height*.03,),
                      (state is LoginLoadingState)
                          ?Center(child: CircularProgressIndicator(
                        color: AppColors.primaryColor1,
                      ),)
                          :defaultButton(
                          textColor: AppColors.primaryColor1,
                          width: size.width*.9,
                          height: size.height*.06,
                          buttonText: 'LOGIN',
                          buttonColor: AppColors.myGrey,
                          function: (){
                            if(formKey.currentState!.validate()){
                              cubit.userLogin(
                                  phone: password.text
                              );

                            }
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
                          Text('or',
                            style: TextStyle(
                                fontSize:16,
                                color: AppColors.myGrey,
                                fontFamily: AppStrings.appFont
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
                      // Row(
                      //   children: [
                      //     defaultSocialMediaButton(
                      //         context: context,
                      //         function: (){
                      //           LoginCubit.get(context).signInWithFacebook();
                      //         },
                      //         size:size,
                      //         buttonColor: AppColors.primaryColor1,
                      //         buttonText: "Facebook",
                      //         imagePath: 'assets/images/face.png'
                      //     ),
                      //     SizedBox(width: MediaQuery.of(context).size.width*.03,),
                      //     defaultSocialMediaButton(
                      //         context: context,
                      //         function: (){
                      //           LoginCubit.get(context).loginWithGoogle();
                      //         },
                      //         size:size,
                      //         buttonColor: AppColors.primaryColor1,
                      //         buttonText: "Google",
                      //         imagePath: 'assets/images/google1.png'
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: size.height*.03,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don\'t Have Account ?",style: TextStyle(
                              fontFamily: AppStrings.appFont,
                              fontSize: 18,
                              color: AppColors.myGrey
                          ),),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child:  Text("register",style: TextStyle(
                                color: AppColors.navBarActiveIcon,
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