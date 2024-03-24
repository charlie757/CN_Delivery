import 'dart:convert';

import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';

class CurrentOrderProvider extends ChangeNotifier {
  List currentOrderList = [];

  callApiFunction() {
    currentOrderList.isEmpty
        ? showCircleProgressDialog(navigatorKey.currentContext!)
        : null;
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.currentOrderUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      currentOrderList.isEmpty
          ? Navigator.pop(navigatorKey.currentContext!)
          : null;
      if (value != null) {
        currentOrderList = value['data'];
        notifyListeners();
      }
    });
  }
}
