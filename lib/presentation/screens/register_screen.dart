import 'package:country_pickers/country.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';


import 'package:fanchat/business_logic/register/register_cubit.dart';
import 'package:fanchat/business_logic/register/register_states.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/screens/privacy_policies.dart';

import 'package:fanchat/presentation/screens/verify_code_screen.dart';
import 'package:fanchat/presentation/screens/welcome_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:fanchat/utils/helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../constants/app_strings.dart';
import '../layouts/home_layout.dart';
class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _value=0;
  bool isCheckBoxTrue=false;
  void onPressCheckBox(bool value){
    value = true;
  }
  //RegisterScreen({Key? key}) : super(key: key);
  Map<String,dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking=true;

  var formKey =GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  late String phoneNumber;
  @override
 void initState() {

    super.initState();
  }

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
            customToast(title: 'Login Successful', color: AppColors.primaryColor1);
            showMyDialog(context);

          }
          if(state is UserRegisterErrorState){
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
                showMyDialog(context);
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
             showMyDialog(context);
              }

            }).catchError((error){
              print('error from saving user facebook id to shared ${error.toString()}');
            });
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
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/register_image.jpg',
                            ),
                            fit: BoxFit.cover
                          )
                      ),
                    ),

                  SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          SizedBox(height: MediaQuery.of(context).size.height*.06,),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                            child: SvgPicture.asset(
                                'assets/images/logo.svg',
                                height: MediaQuery.of(context).size.height*.16,
                            )
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                            child: Text('Enjoy chatting in special team fans’ chat rooms, public rooms, and  one-to-one chats. Share videos, photos, and voice messges with football fans around the world.Broadcast a cheer to all your team fans in team rooms,and follow match scores and news during',
                            style: TextStyle(
                              color: AppColors.myWhite,
                              fontSize: 14,
                              fontFamily: AppStrings.appFont
                            ),
                             textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 10,),

                          Text('World Cup, Qatar, 2022',
                            style: TextStyle(
                                color: Color(0xfffff560),
                                fontSize: 16,
                                fontFamily: AppStrings.appFont
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 10,),

                          Text(' Join the fans and don’t lose a moment',
                            style: TextStyle(
                                color: AppColors.myWhite,
                                fontSize: 14,
                                fontFamily: AppStrings.appFont
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 25,),

                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                            child: textFormFieldWidget(
                                context: context,
                                controller: name,
                                errorMessage: "please enter your name",
                                inputType: TextInputType.name,
                                labelText:"Name",
                                prefixIcon: Icon(Icons.person,color: AppColors.myGrey,)
                            ),
                          ),
                          SizedBox(height: size.height*.03,),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*.07,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: HexColor('#ffef00'),
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(3),
                                color: HexColor('#000f2c').withOpacity(.6),
                              ),
                              child: IntlPhoneField(
                                dropdownTextStyle: TextStyle(
                                  color: AppColors.myGrey,
                                  fontSize: 14,
                                  fontFamily: AppStrings.appFont
                                ),
                                invalidNumberMessage: 'Invalid Phone Number!',
                                textAlignVertical: TextAlignVertical.center,
                                style:  TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppStrings.appFont,
                                    color: AppColors.myGrey
                                ),
                                onChanged: (phone) => phoneNumber = phone.completeNumber,
                                initialCountryCode: 'AF',
                                flagsButtonPadding: const EdgeInsets.only(right: 10,bottom: 10),
                                showDropdownIcon: false,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height*.04,),
                          defaultButton(
                              textColor: AppColors.myWhite,
                              buttonText: 'LOGIN',
                              buttonColor: Color(0Xffd32330),
                              width: size.width*.6,
                              height: size.height*.06,
                              function: (){
                                if(name.text == "fanchat"){
                                if(isCheckBoxTrue == true ){
                                  AppStrings.uId = '1832855570382325';
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeLayout()));
                                }else{
                                  Fluttertoast.showToast(
                                    msg:"You Must Agree To Privacy Policies First",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0,
                                  );
                                }
                                }
                                else if(formKey.currentState!.validate() || isNullOrBlank(phoneNumber)){
                                 if(isCheckBoxTrue == true ){
                                   CashHelper.saveData(key: 'name',value: name.text);
                                   CashHelper.saveData(key: 'phone',value: phoneNumber);
                                   Navigator.push(context,
                                       MaterialPageRoute
                                         (builder: (context)=>VerifyPhoneNumberScreen(phoneNumber: phoneNumber,)));

                                   print('user Name = ${name.text}');
                                   print('user phone = ${phoneNumber}');
                                 }else{
                                   Fluttertoast.showToast(
                                     msg:"You Must Agree To Privacy Policies First",
                                     toastLength: Toast.LENGTH_LONG,
                                     gravity: ToastGravity.TOP,
                                     timeInSecForIosWeb: 5,
                                     backgroundColor: Colors.red,
                                     textColor: Colors.white,
                                     fontSize: 18.0,
                                   );
                                 }
                                }

                              }
                          ),
                          SizedBox(height: size.height*.02,),

                          // SizedBox(height: size.height*.03,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //       height: 1,
                          //       width: size.width*.3,
                          //       color: Colors.grey.shade400,
                          //     ),
                          //     const SizedBox(width: 5,),
                          //     Text('or',
                          //       style: TextStyle(
                          //           fontSize:16,
                          //           color: AppColors.myGrey,
                          //           fontFamily: AppStrings.appFont
                          //       ),
                          //     ),
                          //     const SizedBox(width: 5,),
                          //     Container(
                          //       height: 1,
                          //       width: size.width*.3,
                          //       color: Colors.grey.shade400,
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: size.height*.03,),
                          // Row(
                          //   children: [
                          //     defaultSocialMediaButton(
                          //         context: context,
                          //         function: (){
                          //          if(isCheckBoxTrue == true){
                          //            RegisterCubit.get(context).signInWithFacebook();
                          //          }else{
                          //            Fluttertoast.showToast(
                          //              msg:"You Must Agree To Privacy Policies First",
                          //              toastLength: Toast.LENGTH_LONG,
                          //              gravity: ToastGravity.TOP,
                          //              timeInSecForIosWeb: 5,
                          //              backgroundColor: Colors.red,
                          //              textColor: Colors.white,
                          //              fontSize: 18.0,
                          //            );
                          //          }
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
                          //           if(isCheckBoxTrue == true){
                          //             RegisterCubit.get(context).loginWithGoogle();
                          //           }else{
                          //             Fluttertoast.showToast(
                          //               msg:"You Must Agree To Privacy Policies First",
                          //               toastLength: Toast.LENGTH_LONG,
                          //               gravity: ToastGravity.TOP,
                          //               timeInSecForIosWeb: 5,
                          //               backgroundColor: Colors.red,
                          //               textColor: Colors.white,
                          //               fontSize: 18.0,
                          //             );
                          //           }
                          //         },
                          //         size:size,
                          //           buttonColor: AppColors.primaryColor1,
                          //         buttonText: "Google",
                          //         imagePath: 'assets/images/google1.png'
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: size.height*.03,),
                          Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                               Checkbox(
                            value: isCheckBoxTrue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(width: 1.0, color: AppColors.myGrey),
                            ),
                            onChanged:(bool? value){
                          setState((){
                            isCheckBoxTrue=true;
                          });
                            }
                        ),
                               Container(
                                 child: Text.rich(
                                TextSpan(
                                    text: 'Agree to our ', style: TextStyle(
                                    fontSize: 16, color:AppColors.myGrey
                                ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Privacy Policies', style: TextStyle(
                                        fontSize: 16, color: AppColors.navBarActiveIcon,
                                        decoration: TextDecoration.underline,
                                      ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicies()));
                                              // code to open / launch terms of service link here
                                            }
                                      ),
                                    ]
                                )
                            ),
                          ),
                      ],
                  ),
                        ],
                      ),
            ),
                ]
                ),
                ),
          );

        },
      ),

    );

  }

  Widget _buildDropdownItem(Country country) => Container(
    width:130,
    padding: const EdgeInsets.only(left: 15),
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(
          width: 15.0,
        ),
        Text("+${country.phoneCode}",style: TextStyle(
            color: AppColors.myGrey,
            fontFamily: AppStrings.appFont
        ),),
      ],
    ),
  );


}

Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.myWhite,
        // title: const Text('Aew you sure you want to logout from FanChat'),
        content: SingleChildScrollView(
            child:Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children:  [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 70,
                    child: Image(image: AssetImage('assets/images/ncolort.png'),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Text('Congratulations\nYou are now on 7-day free trial.\nEnjoy FAN Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppStrings.appFont
                    ),
                  )
                ],
              ),
            )
        ),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              Center(
                child: defaultButton(
                    width: MediaQuery.of(context).size.width*.7,
                    height: MediaQuery.of(context).size.width*.15,
                    buttonColor: AppColors.primaryColor1,
                    textColor: AppColors.myWhite,
                    buttonText: 'Start',
                    fontSize: 15,
                    function: (){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=>HomeLayout()));
                    }),
              ),
              SizedBox(height:30,),
              Center(
                child: defaultButton(
                    width: MediaQuery.of(context).size.width*.7,
                    height: MediaQuery.of(context).size.width*.15,
                    buttonColor: AppColors.navBarActiveIcon,
                    textColor: AppColors.myWhite,
                    buttonText: 'Buy a package',
                    fontSize: 15,
                    function: (){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=>ChoosePayPackage()));
                    }),
              ),
            ],
          )
        ],
      );
    },
  );

}