import 'dart:ui' as ui;
import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/screens/auth/login_screen.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
MediaQueryData mediaQuery = MediaQuery.of(navigatorKey.currentState!.context)
    .copyWith(textScaleFactor: 1.0);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Utils {
  static bool isValidEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  static bool passwordValidateRegExp(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static hideTextField() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static const emailPattern =
      r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  static showToast(String title, {Color color = Colors.black}) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: AppColor.whiteColor);
  }

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
    SessionManager.setToken = '';
    Constants.is401Error = true;
    AppRoutes.pushReplacementAndRemoveNavigation(const LoginScreen());
    print('lodfgdfg');
  }


 static Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

}
