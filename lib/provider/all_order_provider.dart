import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

class AllOrderProvider extends ChangeNotifier {
  List allOrderList = [];

  getAllOrderProvider() {
    allOrderList.isNotEmpty
        ? null
        : showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.allOrderUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      allOrderList.isNotEmpty
          ? null
          : Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        allOrderList = value['data'];
        notifyListeners();
      }
    });
  }
}
