import 'package:fanchat/presentation/screens/chat_screen.dart';
import 'package:fanchat/presentation/screens/fan_screen.dart';
import 'package:fanchat/presentation/screens/home_screen.dart';
import 'package:fanchat/presentation/screens/login_screen.dart';
import 'package:fanchat/presentation/screens/match_details.dart';
import 'package:fanchat/presentation/screens/more_screen.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=> BlocProvider.of(context);




  List screensTitles=[

    'Home Screen',
    'Match Details' ,
    'Fan Area' ,
    'Chat Screen',
    'More Screen',

  ];


  final List <String> groupsImages=[

    'https://img.freepik.com/premium-photo/flag-france_135932-1458.jpg?w=740',
    'https://img.freepik.com/free-vector/illustration-usa-flag_53876-18165.jpg?w=996&t=st=1658517048~exp=1658517648~hmac=cbe565f23062c2297398122d1ead56d1031b7e446121a0e059be5be3158769c1' ,
    'https://img.freepik.com/premium-photo/argentinian-flag-close-up-view_625455-806.jpg?w=740',
    'https://img.freepik.com/free-photo/flag-senegal_1401-216.jpg?w=740&t=st=1658517102~exp=1658517702~hmac=a88fc9ccc784e74dd5c943332ac630c1bc6f92a9b12b52508cadd9be633e91e5',
    'https://img.freepik.com/free-photo/flags-germany_1232-3061.jpg?w=740&t=st=1658517131~exp=1658517731~hmac=352aa05f783a371e423a860f42e468a9184cab9ceed0464b2057f9a87c918e83',
    'https://img.freepik.com/free-photo/spanish-flag-white_144627-24632.jpg?w=740&t=st=1658517149~exp=1658517749~hmac=732a5f5e8dd887cffca58dfff1f851995fe7aff724739594ae00244e8978d59d',
    'https://img.freepik.com/free-photo/beautiful-greek-flag_23-2149323079.jpg?w=740&t=st=1658517166~exp=1658517766~hmac=3810542fd47f4156cdf46be69b54ad40c0ce6b9e2e12d2ea8814e3911b40965d',
    'https://img.freepik.com/free-photo/closeup-shot-realistic-flag-cameroon-with-interesting-textures_181624-9536.jpg?w=900&t=st=1658516966~exp=1658517566~hmac=2c7791265b0bce21be9e81157202febf6b6a1fc85ac15774fc47fc8702e11144',

  ];

  List <String> nationalTitles=[

    'France',
    'USA' ,
    'Argentinian',
    'Senegal',
    'Germany',
    'Spanish',
    'Greek',
    'Cameroon',

  ];

  List carouselImage=[
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    'assets/images/slider4.png',
  ];

  List chatImages=[
    'https://img.freepik.com/free-photo/successful-professional-enjoying-work-break_1262-16980.jpg?w=740&t=st=1658702118~exp=1658702718~hmac=a87514a21d49f5fa06f774fbfbe0adad396f68a7c4b24912ddd70c9aeed5eddb',
    'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1658702156~exp=1658702756~hmac=e88a3db16b3bb740df629b5d80f3d6b0cb9cb693cee3663078665059aed3a6cc',
    'https://img.freepik.com/free-photo/young-handsome-man-listens-music-with-earphones_176420-15616.jpg?w=740&t=st=1658702204~exp=1658702804~hmac=4ad64670966fe210e2226e87405fadf3971f9db7eb7a5136b5e039053e2d365a',
    'https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?w=740&t=st=1658702142~exp=1658702742~hmac=26d3c0d7eaadc76fee6a337185a9b9288961ceb2513c8de238d3ad3b81e26ae0',
  ];
  int currentIndex=0;
  void navigateScreen(int index){

    currentIndex=index;
    emit(NavigateScreenState());
  }



  bool checkValue=false;
  void checkBox(value){

    checkValue=value;
    emit(CheckBoxState());
  }



}
