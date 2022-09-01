import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:fanchat/business_logic/register/register_states.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/screens/verify_code_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:fanchat/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login/login_state.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  // Future userRegister({
  //   required String email,
  //   required String pass,
  //   required String name,
  //   required String phone,
  //
  //
  // })async {
  //
  //   FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: pass
  //   ).then((value) {
  //
  //     printMessage('Register Successful');
  //
  //     saveUserInfo(
  //         name: name,
  //         email: email,
  //         uId: value.user!.uid,
  //         phone: phone,
  //     );
  //     AppStrings.uId=value.user!.uid;
  //     emit(UserRegisterSuccessState(value.user!.uid));
  //
  //   }).catchError((error){
  //     printMessage('Error is user register is ${error.toString()}');
  //     emit(UserRegisterErrorState());
  //   });
  //
  //
  //
  // }



  Future userRegisterPhone({
    required String uid,
    required String phone,
    required String name,


  })async {

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    ).then((value) {

      printMessage('Register Successful');

      saveUserInfo(
          name: name,
          uId: uid,
          phone: phone,
      );

      emit(UserRegisterSuccessState(uid));

    }).catchError((error){
      printMessage('Error is user register is ${error.toString()}');
      emit(UserRegisterErrorState());
    });



  }

  Future saveUserInfo(
      {
        required String name,
        required String uId,
        required String phone,
        String ?bio,
        String ?image,
        String ?cover,


      })
  async{
    UserModel userModel  =UserModel(
        username: name,
        phone: phone,
        uId: uId,
        bio: bio??'Enter your bio',
        image: image??'https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1659098857~exp=1659099457~hmac=07d524c7d7ac8cc820597784d5b1733130b117a8945288ae40ad2aaf17018419',
        cover: cover??'https://img.freepik.com/free-vector/football-player-with-ball-stadium-with-france-flags-background-vector-illustration_1284-16438.jpg?w=740&t=st=1659099057~exp=1659099657~hmac=a0bb3dcd21329344cdeb6394401b201a4062c653f424a245c7d32e2358df63e4'
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap()).then((value) {

      printMessage('User Created');
      emit(UserDataSuccessState());

    }).catchError((error){
      printMessage('Error is Save Data is ${error.toString()}');
      emit(UserDataErrorState());
    });

  }

  //send otp to mail
  var emailAuth = EmailAuth(sessionName: 'Fan-Chat App');
void sendOtp(String email)async{
    var res = await emailAuth.sendOtp(recipientMail: email);
    if(res){
      emit(SendOtopSuccessState());
    }else{
      emit(SendOtopErrorState());
    }
}
//verify otp
void verifyOtp(String email, String otp){
    var res =emailAuth.validateOtp(recipientMail: email,
        userOtp: otp);
    if(res){
      emit(VerifyOtopSuccessState());
    }else{
      emit(VerifyOtopErrorState());
    }
}
  // late UserCredential userCredential;
  // late bool autoVerified;
  // FutureOr<void> onSuccess( ){
  //   log(
  //     VerifyPhoneNumberScreen.id,
  //     msg: autoVerified
  //         ? 'OTP was fetched automatically!'
  //         : 'OTP was verified manually!',
  //   );
  //
  //   showSnackBar('Phone number verified successfully!');
  //   log(
  //     VerifyPhoneNumberScreen.id,
  //     msg: 'Login Success UID: ${userCredential.user?.uid}',
  //   );
  // saveUserInfo(
  //     uId:userCredential.user!.uid ,
  //     email: userCredential.user!.email!,
  //     phone: userCredential.user!.phoneNumber!,
  //     name: userCredential.user!.displayName!,
  //   );
  // }

}