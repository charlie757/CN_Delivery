import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List notificationList = [];
  callApiFunction() {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.notificationUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        notificationList = value['data'];
        notifyListeners();
      }
    });
  }
}
