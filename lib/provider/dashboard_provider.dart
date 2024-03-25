import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/utils/notification_service.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 0;

  updateIndex(value) {
    currentIndex = value;
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
    ).then((value) {});
  }
}
