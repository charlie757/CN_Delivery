import 'package:cn_delivery/helper/appcolor.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
MediaQueryData mediaQuery = MediaQuery.of(navigatorKey.currentState!.context)
    .copyWith(textScaleFactor: 1.0);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Utils {
  static hideTextField() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static const emailPattern =
      r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  static successSnackBar(
    String title,
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.withOpacity(.9)),
            borderRadius: BorderRadius.circular(3)),
        // margin: EdgeInsets.only(left: 20, right: 20,),
        backgroundColor: Colors.green.withOpacity(.9),
        content: Text(
          title,
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static internetSnackBar(
    context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor.withOpacity(.8)),
            borderRadius: BorderRadius.circular(3)),
        //  margin: EdgeInsets.only(left: 20,right: 20,bottom: bottom),
        backgroundColor: AppColor.redColor.withOpacity(.8),
        content: Text(
          'No Internet',
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static errorSnackBar(
    String title,
    context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor.withOpacity(.8)),
            borderRadius: BorderRadius.circular(3)),
        //  margin: EdgeInsets.only(left: 20,right: 20,bottom: bottom),
        backgroundColor: AppColor.redColor.withOpacity(.8),
        content: Text(
          title,
          style: TextStyle(color: AppColor.whiteColor),
        )));
  }

  static logOut() {
    // SessionManager.setToken = '';
    // AppRoutes.pushReplacementNavigation(const LoginScreen());
  }
}
