// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
import 'package:fanchat/presentation/screens/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/business_logic/shared/local/cash_helper.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/constants/app_strings.dart';
import 'package:fanchat/firebase_options.dart';
import 'package:fanchat/presentation/layouts/home_layout.dart';
import 'package:fanchat/presentation/screens/edit_profie_screen.dart';
import 'package:fanchat/presentation/screens/fan/fan_full_post.dart';
import 'package:fanchat/presentation/screens/posts/add_new_image.dart';
import 'package:fanchat/presentation/screens/posts/add_new_video.dart';
import 'package:fanchat/presentation/screens/posts/add_text_post.dart';
import 'package:fanchat/presentation/screens/profile_area/profile_screen.dart';
import 'package:fanchat/presentation/screens/register_screen.dart';
import 'package:fanchat/presentation/should_pay.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:media_cache_manager/core/download_cache_manager.dart';
import 'package:overlay_support/overlay_support.dart';
import 'business_logic/bloc/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// ============================================
    Stripe.publishableKey =  AppStrings.publishableKey;

  // await Stripe.instance.applySettings();

  /// ============================================
  await DownloadCacheManager.setExpireDate(daysToExpire: 1);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  await CashHelper.init();
  // AppStrings.uId = '1832855570382325';
  AppStrings.uId = CashHelper.getData(key: 'uid');

  printMessage('userId is: ${AppStrings.uId}');
  print(
      'dgggggggggggggggggggggggggggggggggggg ${CashHelper.getData(key: 'days')}');

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..getUser(context)
              ..getCountries()
              ..getHidePosts()
              ..getProfilePosts()
              ..getAllUsers()
              ..getFanPosts()
              ..getUserIds()
              ..periodic()
              ..getPosts()
              ..getSlider()
              ..getLastUsers()
              ..getUserIds()
              ..getAllMatches(doc: '20 Nov')
        ),
        BlocProvider(
            create: (context) => AdvertisingCubit()..getAdvertisingPosts()),
        // BlocProvider(create: (context) => PaymentBloc()),
      ],
      child: FirebasePhoneAuthProvider(
        child: OverlaySupport(
          child: MaterialApp(
            title: 'fanchat',
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('es', ''),
              Locale('de', ''),
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                navigationBarTheme: const NavigationBarThemeData(
                  elevation: 1000,
                ),
                primarySwatch: Colors.blue,
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                  statusBarColor: AppColors.primaryColor1,
                ))),
            // initialRoute: 'register',
            routes: {
              '/': (context) => (AppStrings.uId != null)
                  ? CashHelper.getData(key: 'days') == 7
                      ? const ShouldPay()
                      : const HomeLayout()
                  : SplashScreen(),
              'home_layout': (context) => const HomeLayout(),
              // 'login':(context)=> LoginScreen(),
              'register': (context) => const RegisterScreen(),
              'profile': (context) => const ProfileScreen(),
              'edit_profile': (context) => const EditProfileScreen(),
              'add_video': (context) => const AddNewVideo(),
              'add_image': (context) => const AddNewImage(),
              'add_text': (context) => AddTextPost(),
              'fan_post': (context) => FanFullPost(),
            },
          ),
        ),
      ),
    );
  }
}
