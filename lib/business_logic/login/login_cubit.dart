import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/login/login_state.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/screens/verify_code_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  FirebaseAuth auth = FirebaseAuth.instance;

// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.

  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String phone,
  }) async {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    )
        .then((value) {
      printMessage('Login Successful');
      printMessage(VerifyPhoneNumberScreen.id);
      AppStrings.uId = VerifyPhoneNumberScreen.id;
      emit(UserLoginSuccessState(VerifyPhoneNumberScreen.id));
    }).catchError((error) {
      // print('error while login------------>   ${error.toString()}');
      emit(UserLoginErrorState());
    });
  }

  Future saveUserInfo({
    required String name,
    required String email,
    required String uId,
    required String phone,
    String? bio,
    String? image,
    String? cover,
    String? code,
  }) async {
    UserModel userModel = UserModel(
        username: name,
        email: email,
        phone: phone,
        uId: uId,
        countryCode: code,
        bio: bio ?? 'Enter your bio',
        image: image ??
            'https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1659098857~exp=1659099457~hmac=07d524c7d7ac8cc820597784d5b1733130b117a8945288ae40ad2aaf17018419',
        cover: cover ??
            'https://img.freepik.com/free-vector/football-player-with-ball-stadium-with-france-flags-background-vector-illustration_1284-16438.jpg?w=740&t=st=1659099057~exp=1659099657~hmac=a0bb3dcd21329344cdeb6394401b201a4062c653f424a245c7d32e2358df63e4');

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      printMessage('User Created');
      emit(LoginUserDataSuccessState());
    }).catchError((error) {
      printMessage('Error is Save Data is ${error.toString()}');
      emit(LoginUserDataErrorState());
    });
  }
//   //////////////////////////////////////////////////////////////////////////
//   GoogleSignIn googleSignIn = GoogleSignIn();
//   Future<void> loginWithGoogle()async{
//     emit(GoogleLoginLoadingState());
//     //account
//     GoogleSignInAccount? account =  await googleSignIn.signIn();
//     //authentication
//     GoogleSignInAuthentication authentication = await account!.authentication;
//     //cradential
//     AuthCredential credential = GoogleAuthProvider.credential(idToken: authentication.idToken,accessToken: authentication.accessToken);
//     //user
//     User? user =(await FirebaseAuth.instance.signInWithCredential(credential)).user;
//     AppStrings.uId=user!.uid;
//    saveUserInfo(
//         name: user.displayName!,
//         email: user.email!,
//         uId: user.uid,
//         phone: "",
//         image: user.photoURL
//     );
//     emit(GoogleLoginSuccessState(user.uid));
//     if(user !=null){
//       print('user account from google ------> ${user.email}');
//       AppStrings.uId=user.uid;
//
//       print('${AppStrings.uId}');
//     }else{
//       print('error');
//       emit(GoogleLoginErrorState());
//     }
//
//   }
// // //////////////////////////////////////////////////////////////
//   bool isLoggedIn =false;
//   Future<void> signInWithFacebook() async {
//     emit(FacebookLoginLoadingState());
//     await FacebookAuth.instance.logOut();
//     //final LoginResult result =
//     await FacebookAuth.instance.login(permissions: ['public_profile', 'email']).then((value){
//      FacebookAuth.instance.getUserData().then((userData){
//        isLoggedIn=true;
//        var data=userData;
//        print( data['name'].toString());
//        print( data['email']);
//        print( data['picture']);
//        print( data['id']);
//        print(data.entries);
//        AppStrings.uId=data['id'].toString();
//        saveUserInfo(
//            name:  data['name'].toString(),
//            email: data['email'].toString(),
//            uId: data['id'].toString(),
//            phone: "",
//            image: data["picture"]["data"]["url"].toString()
//        );
//        emit(FacebookLoginSuccessState(data['id'].toString()));
//      }).catchError((error){
//        emit(FacebookLoginErrorState());
//        print(error.toString());
//      });
//     }).catchError((error){
//       emit(FacebookLoginErrorState());
//       print(error.toString());
//     });
//   }
// //////////////////////////////////////////////////////////////

}
