import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanchat/business_logic/login/login_state.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/data/modles/user_model.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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


}
