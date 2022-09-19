import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:fanchat/business_logic/register/register_states.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;




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
  //////////////////////////////////////////////////////////////
  bool isLoggedIn =false;
  Future<void> signInWithFacebook() async {
    emit(FacebookLoginLoadingState());

    //final LoginResult result =
    await FacebookAuth.instance.login(permissions: ['public_profile' , 'email']).then((value){
      FacebookAuth.instance.getUserData().then((userData){
        isLoggedIn=true;
        var data=userData;
        print( data['name'].toString());
        print( data['email']);
        print( data['picture']);
        print( data['id']);
        print(data.entries);
        AppStrings.uId=data['id'].toString();
        saveUserInfo(
            name:  data['name'].toString(),
           // email: data['email'].toString(),
            uId: data['id'].toString(),
            phone: "",
            image: data["picture"]["data"]["url"].toString()
        );
        emit(FacebookLoginSuccessState(data['id'].toString()));
      }).catchError((error){
        emit(FacebookLoginErrorState());
        print(error.toString());
      });
    }).catchError((error){
      emit(FacebookLoginErrorState());
      print(error.toString());
    });
    await FacebookAuth.instance.logOut();
  }
  //////////////////////////////////////////////////////////////
  Future<UserCredential> signInWithFacebook2() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  //////////////////////////////////////////////////////////////////////////
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> loginWithGoogle()async{
    emit(GoogleLoginLoadingState());
    //account
    GoogleSignInAccount? account =  await googleSignIn.signIn();
    //authentication
    GoogleSignInAuthentication authentication = await account!.authentication;
    //cradential
    AuthCredential credential = GoogleAuthProvider.credential(idToken: authentication.idToken,accessToken: authentication.accessToken);
    //user
    User? user =(await FirebaseAuth.instance.signInWithCredential(credential)).user;
    AppStrings.uId=user!.uid;
    saveUserInfo(
        name: user.displayName!,
        //email: user.email!,
        uId: user.uid,
        phone: "",
        image: user.photoURL
    );
    emit(GoogleLoginSuccessState(user.uid));
    if(user !=null){
      print('user account from google ------> ${user.email}');
      AppStrings.uId=user.uid;

      print('${AppStrings.uId}');
    }else{
      print('error');
      emit(GoogleLoginErrorState());
    }

  }
////////////////////////////////////////////////////////////////

}