
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

