
abstract class LoginState{}

class InitialState extends LoginState{}
class LoginLoadingState extends LoginState{}

class UserLoginSuccessState extends LoginState{
  String ?uId;
  UserLoginSuccessState(this.uId);
}
class UserLoginErrorState extends LoginState{}

