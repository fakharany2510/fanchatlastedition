
import 'package:bloc/bloc.dart';
import 'package:fanchat/business_logic/register/register_states.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState>{

  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);



  Future userRegister({

    required String email,
    required String pass,

   })async {

  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass
  ).then((value) {

    printMessage('Register Successful');
    emit(UserRegisterSuccessState());

  }).catchError((error){
    printMessage('Error is user register is ${error.toString()}');
    emit(UserRegisterErrorState());
  });



  }

}