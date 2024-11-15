import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/model/wallet_earn_model.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier{
  WalletEarnModel? model;
  walletEarnApiFunction() {
    if(model==null){
      showCircleProgressDialog(navigatorKey.currentContext!);
    }
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.walletEarnUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      model==null?  Navigator.pop(navigatorKey.currentContext!):null;
      if (value != null) {
        model = WalletEarnModel.fromJson(value);
        notifyListeners();
      }
    });
  }

  addAmountApiFunction(String amount,var data)async{
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({
      'amount':amount,
      "payment_request":data
    });
    ApiService.apiMethod(
      url: ApiUrl.addAmountUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Navigator.pop(navigatorKey.currentContext!);
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        walletEarnApiFunction();
        notifyListeners();
      }
    });
  }
}