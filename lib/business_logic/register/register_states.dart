
abstract class RegisterState{}

class InitialState extends RegisterState{}

class UserRegisterSuccessState extends RegisterState{}
class UserRegisterErrorState extends RegisterState{}

class UserDataSuccessState extends RegisterState{}
class UserDataErrorState extends RegisterState{}