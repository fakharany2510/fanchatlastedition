import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/register/register_states.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;




  // Future userRegisterPhone({
  //   required String uid,
  //   required String phone,
  //   required String name,
  //
  //
  // })async {
  //
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) {},
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   ).then((value) {
  //
  //     printMessage('Register Successful');
  //
  //     saveUserInfo(
  //         name: name,
  //         uId: uid,
  //         phone: phone,
  //     );
  //
  //     emit(UserRegisterSuccessState(uid));
  //
  //   }).catchError((error){
  //     printMessage('Error is user register is ${error.toString()}');
  //     emit(UserRegisterErrorState());
  //   });
  //
  //
  //
  // }

  Future saveUserInfo(
      {
        required String name,
        required String uId,
        required String phone,
        String ?bio,
        String ?image,
        String ?youtube,
        String ?twitter,
        String ?facebook,
        String ?instagram,
        String ?cover,
        bool ?advertise,
        bool ?premium,
        bool ?payed,
        int ?dayes,


      })
  async{
    UserModel userModel  =UserModel(
        username: name,
        phone: phone,
        uId: uId,
        bio: bio??'Enter your bio',
        youtubeLink: youtube??'Enter your youtube link',
        instagramLink: instagram??'Enter your instagram link',
        twitterLink: twitter??'Enter your twitter link',
        facebookLink: facebook??'Enter your facebook link',
        image: image??'https://firebasestorage.googleapis.com/v0/b/m2mapp-91014.appspot.com/o/user-svgrepo-com.png?alt=media&token=2a3faefa-613f-4d0e-a3b6-5b6556530ed7',
      cover: cover??'https://firebasestorage.googleapis.com/v0/b/m2mapp-91014.appspot.com/o/user-svgrepo-com.png?alt=media&token=2a3faefa-613f-4d0e-a3b6-5b6556530ed7',
      payed: false,
      days: 0,
      accountActive: false,
        advertise:advertise?? false,
      premium: premium??false,
      numberOfPosts: 0,
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

//   //send otp to mail
//   var emailAuth = EmailAuth(sessionName: 'Fan-Chat App');
// void sendOtp(String email)async{
//     var res = await emailAuth.sendOtp(recipientMail: email);
//     if(res){
//       emit(SendOtopSuccessState());
//     }else{
//       emit(SendOtopErrorState());
//     }
// }
// //verify otp
// void verifyOtp(String email, String otp){
//     var res =emailAuth.validateOtp(recipientMail: email,
//         userOtp: otp);
//     if(res){
//       emit(VerifyOtopSuccessState());
//     }else{
//       emit(VerifyOtopErrorState());
//     }
// }
  //////////////////////////////////////////////////////////////
  bool isLoggedIn =false;
  // Future<void> signInWithFacebook() async {
  //   emit(FacebookLoginLoadingState());
  //
  //   //final LoginResult result =
  //   await FacebookAuth.instance.login(permissions: ['public_profile' , 'email']).then((value){
  //     FacebookAuth.instance.getUserData().then((userData){
  //       isLoggedIn=true;
  //       var data=userData;
  //       print( data['name'].toString());
  //       print( data['email']);
  //       print( data['picture']);
  //       print( data['id']);
  //       print(data.entries);
  //       AppStrings.uId=data['id'].toString();
  //       saveUserInfo(
  //           name:  data['name'].toString(),
  //          // email: data['email'].toString(),
  //           uId: data['id'].toString(),
  //           phone: "",
  //           image: data["picture"]["data"]["url"].toString()
  //       );
  //       emit(FacebookLoginSuccessState(data['id'].toString()));
  //     }).catchError((error){
  //       emit(FacebookLoginErrorState());
  //       print(error.toString());
  //     });
  //   }).catchError((error){
  //     emit(FacebookLoginErrorState());
  //     print(error.toString());
  //   });
  //   await FacebookAuth.instance.logOut();
  // }
  // //////////////////////////////////////////////////////////////
  // Future<UserCredential> signInWithFacebook2() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  //////////////////////////////////////////////////////////////////////////
  // GoogleSignIn googleSignIn = GoogleSignIn();
  // Future<void> loginWithGoogle()async{
  //   emit(GoogleLoginLoadingState());
  //   //account
  //   GoogleSignInAccount? account =  await googleSignIn.signIn();
  //   //authentication
  //   GoogleSignInAuthentication authentication = await account!.authentication;
  //   //cradential
  //   AuthCredential credential = GoogleAuthProvider.credential(idToken: authentication.idToken,accessToken: authentication.accessToken);
  //   //user
  //   User? user =(await FirebaseAuth.instance.signInWithCredential(credential)).user;
  //   AppStrings.uId=user!.uid;
  //   saveUserInfo(
  //       name: user.displayName!,
  //       //email: user.email!,
  //       uId: user.uid,
  //       phone: "",
  //       image: user.photoURL
  //   );
  //   emit(GoogleLoginSuccessState(user.uid));
  //   if(user !=null){
  //     print('user account from google ------> ${user.email}');
  //     AppStrings.uId=user.uid;
  //
  //     print('${AppStrings.uId}');
  //   }else{
  //     print('error');
  //     emit(GoogleLoginErrorState());
  //   }
  //
  // }

  
  
  
  
  
  
  
  
  
}