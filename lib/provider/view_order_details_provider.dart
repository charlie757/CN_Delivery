import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/model/view_order_model.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ViewOrderDetailsProvider extends ChangeNotifier {
  ViewOrderModel? model;
  callApiFunction(id) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({});
    ApiService.apiMethod(
      url: "${ApiUrl.orderDetailsUrl}order_id=$id",
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        model = ViewOrderModel.fromJson(value[0]);
      }
      notifyListeners();
    });
  }

  updateStatusApiFunction(String orderId, String status) {
    //'delivered, out_for_delivery'
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({'order_id': orderId, 'status': status});
    ApiService.apiMethod(
      url: ApiUrl.updateOrderStatusUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        callApiFunction(orderId);
      }
      notifyListeners();
    });
  }

  callNumber(String number) async {
    // const number = '08592119XXXX'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
