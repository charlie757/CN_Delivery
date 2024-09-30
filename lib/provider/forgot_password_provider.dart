import 'dart:convert';

import 'package:cn_delivery/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../api/api_url.dart';
import '../config/approutes.dart';
import '../screens/auth/otp_verify_screen.dart';
import '../utils/app_validation.dart';
import '../utils/utils.dart';

class ForgotPasswordProvider extends ChangeNotifier{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading =false;
  String?emailValidationMsg='';
  String? passwordErrorMsg = '';
  String? confirmNewPasswordErrorMsg = '';

  clearValues(){
    passwordController.clear();
    confirmPasswordController.clear();
    isLoading=false;
    passwordErrorMsg='';
    confirmNewPasswordErrorMsg='';
    emailValidationMsg='';
  }

  updateLoading(val){
    isLoading=val;
    notifyListeners();
  }

  checkEmailValidation(){
    if (emailValidationMsg == null) {
      forgotPasswordApiFunction();
    } else {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
    }

    notifyListeners();
  }

  checkPasswordValidation() {
    if (AppValidation.reEnterpasswordValidator(
            passwordController.text, confirmPasswordController.text) == null &&
        AppValidation.reEnterpasswordValidator(
            confirmPasswordController.text, passwordController.text) == null) {
      resetPasswordApiFunction();
      // updatePasswordApiFunction();
    } else {
      passwordErrorMsg = AppValidation.reEnterpasswordValidator(
          confirmPasswordController.text, confirmPasswordController.text);
      confirmNewPasswordErrorMsg = AppValidation.reEnterpasswordValidator(
          confirmPasswordController.text, passwordController.text);
    }
    notifyListeners();
  }

  resetPasswordApiFunction()async{
    Utils.hideTextField();
    updateLoading(true);
    var body = json.encode({
      "email": emailController.text,
      "password":passwordController.text,
      "confirm_password":confirmPasswordController.text
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.resetPasswordUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    updateLoading(false);
    if (response != null) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      AppRoutes.pushReplacementAndRemoveNavigation(LoginScreen());
    } else {}

  }

  forgotPasswordApiFunction()async{
    Utils.hideTextField();
    updateLoading(true);
    var body = json.encode({
      "email": emailController.text,
    });
    print(body);
    final response = await ApiService.apiMethod(
        url: ApiUrl.forgotPasswordUrl,
        body: body,
        method: checkApiMethod(httpMethod.post));
    updateLoading(false);
    if (response != null) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      AppRoutes.pushCupertinoNavigation( OtpVerifyScreen(email: emailController.text,phone:response['data']!=null? response['data']['mobile_number']??'':"",
      route: 'forgot',
      ));
    } else {}

  }

}