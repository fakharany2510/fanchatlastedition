import 'package:fanchat/presentation/screens/chat_screen.dart';
import 'package:fanchat/presentation/screens/fan_screen.dart';
import 'package:fanchat/presentation/screens/home_screen.dart';
import 'package:fanchat/presentation/screens/login_screen.dart';
import 'package:fanchat/presentation/screens/more_screen.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());


  static AppCubit get(context)=> BlocProvider.of(context);

  List <Widget> screens=[

    const HomeScreen(),
    const FanScreen(),
    const ChatScreen(),
    const MoreScreen(),

  ];
  int currentIndex=0;
  void navigateScreen(int index){

    currentIndex=index;
    emit(NavigateScreenState());
  }

}
