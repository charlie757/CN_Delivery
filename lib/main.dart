import 'dart:async';
import 'dart:io';

import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/custom_delegate.dart';
import 'package:cn_delivery/localization/app_localization.dart';
import 'package:cn_delivery/provider/all_order_provider.dart';
import 'package:cn_delivery/provider/current_order_provider.dart';
import 'package:cn_delivery/provider/dashboard_provider.dart';
import 'package:cn_delivery/provider/earn_provider.dart';
import 'package:cn_delivery/provider/forgot_password_provider.dart';
import 'package:cn_delivery/provider/home_provider.dart';
import 'package:cn_delivery/provider/localization_provider.dart';
import 'package:cn_delivery/provider/login_provider.dart';
import 'package:cn_delivery/provider/notification_provider.dart';
import 'package:cn_delivery/provider/otp_verify_provider.dart';
import 'package:cn_delivery/provider/profile_provider.dart';
import 'package:cn_delivery/provider/signup_provider.dart';
import 'package:cn_delivery/provider/view_order_details_provider.dart';
import 'package:cn_delivery/screens/splash_screen.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/location_service.dart';
import 'package:cn_delivery/utils/notification_service.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await SessionManager().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  configLoading();
  getFCMToken();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => OtpVerifyProvider()),
    ChangeNotifierProvider(create: (_) => SignupProvider()),
    ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
    ChangeNotifierProvider(create: (_) => DashboardProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => EarnProvider()),
    ChangeNotifierProvider(create: (_) => AllOrderProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => CurrentOrderProvider()),
    ChangeNotifierProvider(create: (_) => ViewOrderDetailsProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ChangeNotifierProvider(create: (_) => LocalizationProvider()),
  ], child: const MyApp()));
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

getFCMToken() async {
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.getAPNSToken();
  FirebaseMessaging.instance.getToken().then((token) async {
    SessionManager.setFcmToken = token!;
    LocationService.getCurrentLocation();
  });
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final NotificationService notificationService = NotificationService();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Register the observer
    WidgetsBinding.instance.addObserver(this);
  }

  updateCurrentLocation()async{
    Timer.periodic(const Duration(seconds: 10), (val){
      print('every 10 sec');
      LocationService.getCurrentLocation();
    });
    Timer.periodic(const Duration(minutes: 2), (val){
      if(SessionManager.token.isNotEmpty){
        print('every 2 min');
        Provider.of<DashboardProvider>(context,listen: false).updateLastLocationApiFunction();
      }
    });
  }

  @override
  void dispose() {
    // Unregister the observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        updateCurrentLocation();
        break;
      case AppLifecycleState.paused:
        updateCurrentLocation();
        break;
      case AppLifecycleState.resumed:
        updateCurrentLocation();
        break;
      case AppLifecycleState.detached:
        updateCurrentLocation();
        break;
      case AppLifecycleState.hidden:
    }
  }


  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in Constants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    // Provider.of<LocalizationProvider>(context).loadCurrentLanguage();
    print("object${Provider.of<LocalizationProvider>(context).locale}");
    notificationService.initialize();
    return GetMaterialApp(
      title: 'CN Delivery',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      // translations: Languages(),
      locale: Provider.of<LocalizationProvider>(context).locale,

      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      supportedLocales: [
        Locale(Provider.of<LocalizationProvider>(context).locale.languageCode)
      ],
      // fallbackLocale: const Locale('en'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColor.whiteColor
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
