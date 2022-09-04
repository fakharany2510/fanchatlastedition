
abstract class LoginState{}

class InitialState extends LoginState{}
class LoginLoadingState extends LoginState{}

class UserLoginSuccessState extends LoginState{
  String ?uId;
  UserLoginSuccessState(this.uId);
}
class UserLoginErrorState extends LoginState{}

// //sign in with gmail
// class GoogleLoginLoadingState extends LoginState{}
// class GoogleLoginSuccessState extends LoginState{
//   final String uId;
//   GoogleLoginSuccessState(this.uId);
// }
// class GoogleLoginErrorState extends LoginState{}
class LoginUserDataSuccessState extends LoginState{}
class LoginUserDataErrorState extends LoginState{}

// //facebook
// //sign in with
// class FacebookLoginLoadingState extends LoginState{}
// class FacebookLoginSuccessState extends LoginState{
//   final String uId;
//   FacebookLoginSuccessState(this.uId);
// }
// class FacebookLoginErrorState extends LoginState{}

