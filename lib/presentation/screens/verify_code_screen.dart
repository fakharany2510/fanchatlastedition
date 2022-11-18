// ignore_for_file: use_build_context_synchronously

import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/register/register_cubit.dart';
import 'package:fanchat/business_logic/register/register_states.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/paypal/choosepaypackage.dart';
import 'package:fanchat/presentation/screens/edit_profie_screen.dart';
import 'package:fanchat/presentation/widgets/custom_loader.dart';
import 'package:fanchat/presentation/widgets/pin_input_field.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:fanchat/utils/helpers.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  static const id = 'VerifyPhoneNumberScreen';

  final String phoneNumber;

  const VerifyPhoneNumberScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen>
    with WidgetsBindingObserver {
  bool isKeyboardVisible = false;

  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  // scroll to bottom of screen, when pin input field is in focus.
  Future<void> _scrollToBottomOnKeyboardOpen() async {
    while (!isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(milliseconds: 250));

    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is UserDataSuccessState) {
            if (CashHelper.getData(key: 'Advertise') == 1 ||
                CashHelper.getData(key: 'premium') == 1) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeLayout()),
                  (route) => false);
            } else {
              showMyDialog(context);
            }
          }
        },
        builder: (context, state) {
          return FirebasePhoneAuthHandler(
            phoneNumber: widget.phoneNumber,
            signOutOnSuccessfulVerification: false,
            linkWithExistingUser: false,
            autoRetrievalTimeOutDuration: const Duration(seconds: 60),
            otpExpirationDuration: const Duration(seconds: 60),
            onCodeSent: () async {
              // print('iam hereeeeeeeeeeeeeeeeeeeeeeeeee 222222222222');
              log(VerifyPhoneNumberScreen.id, msg: 'OTP sent!');
            },
            onLoginSuccess: (
              userCredential,
              autoVerified,
            ) async {
              log(
                VerifyPhoneNumberScreen.id,
                msg: autoVerified
                    ? 'OTP was fetched automatically!'
                    : 'OTP was verified manually!',
              );

              showSnackBar('Phone number verified successfully!');
              log(
                VerifyPhoneNumberScreen.id,
                msg: 'Login Success UID: ${userCredential.user?.uid}',
              );

              AppStrings.uId = userCredential.user!.uid;
              CashHelper.saveData(key: 'uid', value: userCredential.user!.uid);
              // print('AppStrings.uId => ${AppStrings.uId}');
              // print('userCredential.user!.uid=> ${userCredential.user!.uid}');

              await AppCubit.get(context).getUserIds().then((value) async {
                if (AppCubit.get(context)
                    .userIds
                    .contains(userCredential.user!.uid)) {
                  setState(() async {
                    AppCubit.get(context).isFound = true;
                    await AppCubit.get(context)
                        .getUserWithId(context, userCredential.user!.uid);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeLayout()),
                        (route) => false);
                  });
                } else {
                  await RegisterCubit.get(context)
                      .saveUserInfo(
                    uId: CashHelper.getData(key: 'uid'),
                    phone: userCredential.user!.phoneNumber!,
                    name: '',
                  )
                      .then((value) {
                    AppCubit.get(context).getUser(context);
                  });
                }
              });

              // print('==================');
              // print('==================');

              // print(AppCubit.get(context)
              //     .userIds
              //     .contains(userCredential.user!.uid));
              // print('==================');
              // print('==================');
            },
            onLoginFailed: (authException, stackTrace) {
              log(
                VerifyPhoneNumberScreen.id,
                msg: authException.message,
                error: authException,
                stackTrace: stackTrace,
              );

              switch (authException.code) {
                case 'invalid-phone-number':
                  // invalid phone number
                  return showSnackBar('Invalid phone number!');
                case 'invalid-verification-code':
                  // invalid otp entered
                  return showSnackBar('The entered OTP is invalid!');
                // handle other error codes
                default:
                  showSnackBar('Something went wrong!');
                // handle error further if needed
              }
            },
            onError: (error, stackTrace) {
              log(
                VerifyPhoneNumberScreen.id,
                error: error,
                stackTrace: stackTrace,
              );

              showSnackBar('An error occurred!');
            },
            builder: (context, controller) {
              // print('hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
              return Scaffold(
                backgroundColor: AppColors.primaryColor1,
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor1,
                  leadingWidth: 0,
                  elevation: 0,
                  leading: const SizedBox.shrink(),
                  title: const Text('Verify Phone Number',
                      style: TextStyle(fontFamily: AppStrings.appFont)),
                  actions: [
                    if (controller.codeSent)
                      TextButton(
                        onPressed: controller.isOtpExpired
                            ? () async {
                                log(VerifyPhoneNumberScreen.id,
                                    msg: 'Resend OTP');
                                await controller.sendOTP();
                              }
                            : null,
                        child: Text(
                          controller.isOtpExpired
                              ? 'Resend'
                              : '${controller.otpExpirationTimeLeft.inSeconds}s',
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ),
                    const SizedBox(width: 5),
                  ],
                ),
                body: controller.isSendingCode
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomLoader(color: AppColors.navBarActiveIcon),
                          const SizedBox(height: 50),
                          const Center(
                            child: Text(
                              'Sending OTP',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: AppStrings.appFont),
                            ),
                          ),
                        ],
                      )
                    : ListView(
                        padding: const EdgeInsets.all(20),
                        controller: scrollController,
                        children: [
                          Text(
                            "We've sent an SMS with a verification code to ${widget.phoneNumber}",
                            style: const TextStyle(
                                fontSize: 25,
                                fontFamily: AppStrings.appFont,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          if (controller.isListeningForOtpAutoRetrieve)
                            Column(
                              children: const [
                                CustomLoader(),
                                SizedBox(height: 50),
                                Text(
                                  'Listening for OTP',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: AppStrings.appFont),
                                ),
                                SizedBox(height: 15),
                                Divider(),
                                Text(
                                  'OR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppStrings.appFont),
                                ),
                                Divider(),
                              ],
                            ),
                          const SizedBox(height: 15),
                          const Text(
                            'Enter OTP',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppStrings.appFont,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 15),
                          PinInputField(
                            length: 6,
                            onFocusChange: (hasFocus) async {
                              if (hasFocus) {
                                await _scrollToBottomOnKeyboardOpen();
                              }
                            },
                            onSubmit: (enteredOtp) async {
                              final verified =
                                  await controller.verifyOtp(enteredOtp);
                              if (verified) {
                                // number verify success
                                // will call onLoginSuccess handler
                              } else {
                                // phone verification failed
                                // will call onLoginFailed or onError callbacks with the error
                              }
                            },
                          ),
                        ],
                      ),
              );
            },
          );
        },
      ),
    ));
  }

  Future<void> showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          // title: const Text('Aew you sure you want to logout from FanChat'),
          content: Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.height * .8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('assets/images/paypack.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  child: Image(
                    image: AssetImage('assets/images/ncolort.png'),
                    height: 100,
                    width: 100,
                  ),
                ),
                Center(
                  child: Text(
                    'Congratulations\nYou are now on a 7-day\n free trial.\n Enjoy FAN Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryColor1,
                        fontFamily: AppStrings.appFont,
                        fontWeight: FontWeight.w600,
                        height: 1.4),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: defaultButton(
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .06,
                          buttonColor: const Color(0Xffd32330),
                          textColor: AppColors.myWhite,
                          buttonText: 'Start',
                          fontSize: 15,
                          function: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen()),
                                (Route<dynamic> route) => false);
                            // Navigator.of(context).pushNamedAndRemoveUntil('home_layout', (Route<dynamic>route) => false);
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: defaultButton(
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .06,
                          buttonColor: AppColors.primaryColor1,
                          textColor: AppColors.myWhite,
                          buttonText: 'Get a package ',
                          fontSize: 15,
                          function: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChoosePayPackage()),
                                (Route<dynamic> route) => false);
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
          actions: const <Widget>[],
        );
      },
    );
  }
}
