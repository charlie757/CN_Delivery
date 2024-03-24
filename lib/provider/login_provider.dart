import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/model/login_model.dart';
import 'package:cn_delivery/screens/dashboard_screen.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isKeepSigned = false;
  bool isVisiblePassword = true;

  clearValues() {
    emailController.clear();
    passwordController.clear();
    isKeepSigned = false;
    isVisiblePassword = true;
  }

  /// to show the textfield error
  String? emailValidationMsg = '';
  String? passwordValidationMsg = '';

  updateIsVisiblePassword(value) {
    isVisiblePassword = value;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation() {
    if (emailValidationMsg == null && passwordValidationMsg == null) {
      callApiFunction();
    } else {
      passwordValidationMsg =
          AppValidation.passwordValidator(passwordController.text);
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
    }

    notifyListeners();
  }

  callApiFunction() {
    updateLoading(true);
    var body = json.encode({
      "email": emailController.text,
      "password": passwordController.text,
    });
    ApiService.apiMethod(
      url: ApiUrl.loginUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
    ).then((value) {
      updateLoading(false);
      if (value != null) {
        loginModel = LoginModel.fromJson(value);
        if (loginModel!.status == true) {
          Utils.successSnackBar(
              loginModel!.message.toString(), navigatorKey.currentContext!);
          SessionManager.setToken = loginModel!.data!.token;
          AppRoutes.pushReplacementNavigation(const DashboardScreen());
        }
      }
    });
  }
}
