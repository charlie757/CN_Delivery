import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/model/earn_model.dart';
import 'package:flutter/material.dart';

class EarnProvider extends ChangeNotifier {
  EarnModel? earnModel;
  getEarnApiFunction() {
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.earnUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      if (value != null) {
        earnModel = EarnModel.fromJson(value);
        notifyListeners();
      }
    });
  }
}
