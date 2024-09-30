import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Future pushCupertinoNavigation(
    route,
  ) {
    return Navigator.push(navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => route));
  }

  static pushMaterialNavigation(
    route,
  ) {
    Navigator.push(navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => route));
  }
  static Future pushReplacementAndRemoveNavigation(route){
    return Navigator.pushAndRemoveUntil(navigatorKey.currentContext!, CupertinoPageRoute(builder: (context)=>route), (Route<dynamic> route) => false,);
  }

  static pushReplacementNavigation(
    route,
  ) {
    Navigator.pushReplacement(navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => route));
  }
}
