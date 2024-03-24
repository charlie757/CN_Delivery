import 'dart:io';

import 'package:cn_delivery/provider/all_order_provider.dart';
import 'package:cn_delivery/provider/current_order_provider.dart';
import 'package:cn_delivery/provider/dashboard_provider.dart';
import 'package:cn_delivery/provider/earn_provider.dart';
import 'package:cn_delivery/provider/home_provider.dart';
import 'package:cn_delivery/provider/login_provider.dart';
import 'package:cn_delivery/provider/notification_provider.dart';
import 'package:cn_delivery/provider/profile_provider.dart';
import 'package:cn_delivery/provider/view_order_details_provider.dart';
import 'package:cn_delivery/screens/splash_screen.dart';
import 'package:cn_delivery/utils/notification_service.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

  runApp(const MyApp());
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
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

class _MyAppState extends State<MyApp> {
  final NotificationService notificationService = NotificationService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    notificationService.initialize();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => EarnProvider()),
        ChangeNotifierProvider(create: (_) => AllOrderProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CurrentOrderProvider()),
        ChangeNotifierProvider(create: (_) => ViewOrderDetailsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Consumers Networks',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
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
