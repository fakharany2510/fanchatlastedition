
abstract class RegisterState{}

class InitialState extends RegisterState{}

class UserRegisterSuccessState extends RegisterState{}
class UserRegisterErrorState extends RegisterState{}

class UserLoginSuccessState extends RegisterState{}
class UserLoginErrorState extends RegisterState{}