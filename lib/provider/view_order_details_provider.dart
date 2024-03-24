import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:flutter/material.dart';

class ViewOrderDetailsProvider extends ChangeNotifier {
  callApiFunction() {
    // homeModel == null
    // ? showCircleProgressDialog(navigatorKey.currentContext!)
    // : false;
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.currentOrderUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      // homeModel == null ? Navigator.pop(navigatorKey.currentContext!) : null;
      // if (value != null) {
      //   homeModel = HomeModel.fromJson(value);
      // }
    });
  }
}
