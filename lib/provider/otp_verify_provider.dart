import 'dart:async';
import 'dart:convert';

import 'package:cn_delivery/screens/auth/reset_password_screen.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../api/api_url.dart';
import '../config/approutes.dart';
import '../screens/dashboard_screen.dart';
import '../utils/session_manager.dart';
import '../utils/utils.dart';

class OtpVerifyProvider extends ChangeNotifier{

int counter = 30;
Timer? timer;
bool resend = false;
bool isLoading = false;
String url = '';
updateLoading(bool value) {
  isLoading = value;
  notifyListeners();
}

startTimer() {
  //shows timer
  counter = 30; //time counter
  timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    counter > 0 ? counter-- : timer.cancel();
    notifyListeners();
  });
}

resetValues() {
  resend = false;
}


resendApiFunction(String email) async {
  showCircleProgressDialog(navigatorKey.currentContext!);
  var body = json.encode({
    "email": email,
  });
  print(body);
  final response = await ApiService.apiMethod(
      url: ApiUrl.resendOtpUrl,
      body: body,
      method: checkApiMethod(httpMethod.post));
  Navigator.pop(navigatorKey.currentContext!);
  if (response != null) {
    Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
    startTimer();
  } else {}
}

verifyApiFunction(String email, String otp) async {
  showCircleProgressDialog(navigatorKey.currentContext!);
  var body = json.encode({
    "email": email,
    'otp':otp
  });
  print(body);
  final response = await ApiService.apiMethod(
      url: url,
      body: body,
      method: checkApiMethod(httpMethod.post));
  Navigator.pop(navigatorKey.currentContext!);
  if (response != null) {
    Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
    if(url==ApiUrl.verifyForgotOtpUrl){
      AppRoutes.pushReplacementAndRemoveNavigation( ResetPasswordScreen(email: email,));
    }
    else{
      SessionManager.setToken = response['data']['token'];
      AppRoutes.pushReplacementNavigation(const DashboardScreen());
    }
  } else {}
}

}