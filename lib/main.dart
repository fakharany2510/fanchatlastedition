// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'package:fanchat/business_logic/advertising_cubit/advertising_cubit.dart';
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
import 'package:fanchat/presentation/screens/splash_screen.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:fanchat/strip__/blocs/bloc/payment_state.dart';
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
  Stripe.publishableKey = AppStrings.publishableKey;
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
  // print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');
    plant();
    if (message.notification != null) {
      // print('Message also contained a notification: ${message.notification}');
    }
  });
  await CashHelper.init();
  // AppStrings.uId = '1832855570382325';
  AppStrings.uId = CashHelper.getData(key: 'uid');
  printMessage('userId is: ${AppStrings.uId}');

  // print('dggggggggggggggggggggggg ${CashHelper.getData(key: 'days')}');

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
            lazy: false, create: (context) => AppCubit()..getUser(context)),
        BlocProvider(
            create: (context) => AdvertisingCubit()..getAdvertisingPosts()),
      ],
      child: FirebasePhoneAuthProvider(
        child: OverlaySupport(
          child: MaterialApp(
            title: 'Fanchat',
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
                ),
              ),
            ),
            // initialRoute: 'register',
            routes: {
              '/': (context) => (AppStrings.uId != null)
                  ? const HomeLayout()
                  : SplashScreen(),
              'home_layout': (context) => const HomeLayout(),
              'register': (context) => const RegisterScreen(),
              'profile': (context) => const ProfileScreen(),
              'edit_profile': (context) => const EditProfileScreen(),
              'add_video': (context) => const AddNewVideo(),
              'add_image': (context) => const AddNewImage(),
              'add_text': (context) => const AddTextPost(),
              'fan_post': (context) => FanFullPost(),
            },
          ),
        ),
      ),
    );
  }
}
