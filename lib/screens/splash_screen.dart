import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/screens/dashboard_screen.dart';
import 'package:cn_delivery/screens/login_screen.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    Future.delayed(const Duration(seconds: 3), () {
      if (SessionManager.token.isNotEmpty) {
        AppRoutes.pushReplacementNavigation(const DashboardScreen());
      } else {
        AppRoutes.pushReplacementNavigation(const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(AppImages.splashImg),
    );
  }
}
