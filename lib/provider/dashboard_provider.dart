import 'dart:convert';
import 'dart:io';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/utils/location_service.dart';
import 'package:cn_delivery/utils/notification_service.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 0;
  DateTime? currentBackPressTime;
  bool isPopScope = false;

  updateIndex(value) {
    currentIndex = value;
    updateLastLocationApiFunction();
    notifyListeners();
  }

  updateFcmTokenApiFunction() {
    String token = '';
    if (SessionManager.fcmToken.isEmpty) {
      final NotificationService notificationService = NotificationService();
      notificationService.getToken().then((value) {
        token = value.toString();
      });
    }
    var body = json.encode({
      "fcm_token":
          SessionManager.fcmToken.isEmpty ? token : SessionManager.fcmToken,
    });
    ApiService.apiMethod(
      url: ApiUrl.updateFcmTokenUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
      isErrorMessageShow: false
    ).then((value) {});
  }



  updateLastLocationApiFunction()async{
    LocationService.getCurrentLocation().then((val){
      Position position = val;
    });
    var body = json.encode({
      "longitude": SessionManager.lat,
      "latitude": SessionManager.lng,
      "location": SessionManager.address
    });
    print("bodyLocation.....$body");
    ApiService.apiMethod(
      url: ApiUrl.updateLastLocationUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
      isErrorMessageShow: false
    ).then((value) {});
  }


  Future<bool> onWillPop() async {
    // productController.clearProductsValues();
    DateTime now = DateTime.now();

    if (currentIndex == 0) {
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Utils.successSnackBar('Press again to exit app', navigatorKey.currentContext!);
        // successSnackBar('Exit', 'Press again to exit app');
        return Future.value(false);
      }
      exit(0);
    } else {
      currentIndex = 0;
      notifyListeners();
      return true;
    }
  }


}
