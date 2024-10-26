import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/model/home_model.dart';
import 'package:cn_delivery/model/upcoming_order_model.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeModel? homeModel;
  UpcomingOrderModel? upcomingOrderModel;
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

  upcomingOrderApiFunction()async{
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.upcomingOrderUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      if (value != null) {
        upcomingOrderModel = UpcomingOrderModel.fromJson(value);
        notifyListeners();
      }
      else{
         upcomingOrderModel = null;
         notifyListeners();
      }
    });
  }


  Future acceptOrderApiFunction(String orderId)async{
     showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({
    "order_id": orderId,
    "status": "accepted"
    });
    print(body);
    ApiService.apiMethod(
      url: ApiUrl.acceptOrderUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      upcomingOrderApiFunction();
      return value;
    });
  }

 Future rejectOrderApiFunction(String orderId)async{
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({
    "order_id": orderId,
    });
    ApiService.apiMethod(
      url: ApiUrl.rejectOrderUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      upcomingOrderApiFunction();
      return value;
    });
  }

}
