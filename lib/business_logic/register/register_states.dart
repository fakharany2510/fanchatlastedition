
abstract class RegisterState{}

class RegisterInitialState extends RegisterState{}

class UserRegisterSuccessState extends RegisterState{
  String ?uId;
  UserRegisterSuccessState(this.uId);
}
class UserRegisterErrorState extends RegisterState{}

class UserDataSuccessState extends RegisterState{}
class UserDataErrorState extends RegisterState{}
class SendOtopSuccessState extends RegisterState{}
class SendOtopErrorState extends RegisterState{}
class VerifyOtopSuccessState extends RegisterState{}
class VerifyOtopErrorState extends RegisterState{}


//facebook
//sign in with
class FacebookLoginLoadingState extends RegisterState{}
class FacebookLoginSuccessState extends RegisterState{
  final String uId;
  FacebookLoginSuccessState(this.uId);
}
class FacebookLoginErrorState extends RegisterState{}


//sign in with gmail
class GoogleLoginLoadingState extends RegisterState{}
class GoogleLoginSuccessState extends RegisterState{
  final String uId;
  GoogleLoginSuccessState(this.uId);
}
class GoogleLoginErrorState extends RegisterState{}

