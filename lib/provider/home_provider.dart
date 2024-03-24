import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/model/home_model.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeModel? homeModel;

  callApiFunction() {
    homeModel == null
        ? showCircleProgressDialog(navigatorKey.currentContext!)
        : false;
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.dashboardUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      homeModel == null ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        homeModel = HomeModel.fromJson(value);
        notifyListeners();
      }
    });
  }
}
