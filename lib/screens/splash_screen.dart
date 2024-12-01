import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/screens/dashboard/dashboard_screen.dart';
import 'package:cn_delivery/screens/auth/login_screen.dart';
import 'package:cn_delivery/screens/intro_screen.dart';
import 'package:cn_delivery/screens/select_language_screen.dart';
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
      print("fdsfd..${SessionManager.firstTimeLanguageScreen}");
      if(SessionManager.introScreen){
      if(SessionManager.firstTimeLanguageScreen==true){
        if (SessionManager.token.isNotEmpty) {
          AppRoutes.pushReplacementNavigation(const DashboardScreen());
        } else {
          AppRoutes.pushReplacementNavigation(const LoginScreen());
        }
      }
      else{
        AppRoutes.pushReplacementNavigation(const SelectLanguageScreen());
      }
      }
      else{
         AppRoutes.pushReplacementNavigation(const IntroScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Image.asset(AppImages.appIcon,width: 200,height: 200,)
      ),
    );
  }
}
