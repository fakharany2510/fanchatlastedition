
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/login/login_state.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
   void userLogin({
    required String email,
    required String password
   })async{
     emit(LoginLoadingState());
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
            printMessage('Login Successful');
            printMessage(value.user!.uid);
            AppStrings.uId=value.user!.uid;
            emit(UserLoginSuccessState(value.user!.uid));
         }).catchError((error){
            print('error while login------------>   ${error}');
            emit(UserLoginErrorState());
         });

   }
  Future saveUserInfo(
      {
        required String name,
        required String email,
        required String uId,
        required String phone,
        String ?bio,
        String ?image,
        String ?cover,
        String ?code,


      })
  async{
    UserModel userModel  =UserModel(
        username: name,
        email: email,
        phone: phone,
        uId: uId,
        countryCode: code,
        bio: bio??'Enter your bio',
        image: image??'https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1659098857~exp=1659099457~hmac=07d524c7d7ac8cc820597784d5b1733130b117a8945288ae40ad2aaf17018419',
        cover: cover??'https://img.freepik.com/free-vector/football-player-with-ball-stadium-with-france-flags-background-vector-illustration_1284-16438.jpg?w=740&t=st=1659099057~exp=1659099657~hmac=a0bb3dcd21329344cdeb6394401b201a4062c653f424a245c7d32e2358df63e4'
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap()).then((value) {

      printMessage('User Created');
      emit(LoginUserDataSuccessState());

    }).catchError((error){
      printMessage('Error is Save Data is ${error.toString()}');
      emit(LoginUserDataErrorState());
    });

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
        email: user.email!,
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
//////////////////////////////////////////////////////////////
  bool isLoggedIn =false;
  Future<void> signInWithFacebook() async {
    // emit(FacebookLoginLoadingState());
    // // Trigger the sign-in flow
    // final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);
    //
    // // Create a credential from the access token
    // final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.userId);
    //
    // // Once signed in, return the UserCredential
    // //return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    // User? user =(await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user;
    // saveUserInfo(
    //     name: user!.displayName!,
    //     email: user.email!,
    //     uId:user.uid,
    //     phone: user.phoneNumber!,
    //     image: user.photoURL
    // );
    // emit(FacebookLoginSuccessState(user.uid));
    // if(user !=null){
    //   print('user account from Facebook ------> ${user.email}');
    //   AppStrings.uId=user.uid;
    //
    //   print('${AppStrings.uId}');
    // }else{
    //   print('error');
    //   emit(FacebookLoginErrorState());
    // }
    emit(FacebookLoginLoadingState());
    await FacebookAuth.instance.logOut();
    //final LoginResult result =
    await FacebookAuth.instance.login(permissions: ['public_profile', 'email']).then((value){
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
           email: data['email'].toString(),
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
  }
//////////////////////////////////////////////////////////////

}
