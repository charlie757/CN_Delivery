import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/model/login_model.dart';
import 'package:cn_delivery/screens/auth/choose_vehicle_screen.dart';
import 'package:cn_delivery/screens/dashboard_screen.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

import '../screens/auth/otp_verify_screen.dart';

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
    Constants.is401Error=false;
    updateLoading(true);
    var body = json.encode({
      "email": emailController.text,
      "password": passwordController.text,
    });
    print(body);
    ApiService.apiMethod(
      url: ApiUrl.loginUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
    ).then((value) {
      updateLoading(false);
      if (value != null) {
        loginModel = LoginModel.fromJson(value);
        if (loginModel!.status == true) {
          SessionManager.setToken = loginModel!.data!.token;
          if(loginModel!.data!.isVehicleAdd==0){
            AppRoutes.pushCupertinoNavigation(const ChooseVehicleScreen());
          }
          else{
          // Utils.successSnackBar(
          //     loginModel!.message.toString(), navigatorKey.currentContext!);
          SessionManager.setToken = loginModel!.data!.token;
          AppRoutes.pushReplacementNavigation(const DashboardScreen());
          emailController.clear();
          passwordController.clear();  
          }
          
        }
        else{
          if(value['data']!=null&&value['data']['is_otp_verify']!=null&& value['data']['is_otp_verify']==false){
            AppRoutes.pushCupertinoNavigation( OtpVerifyScreen(email: emailController.text,phone:value['data']['mobile_number'],
            route: 'login',
            ));
          }
        }
      }
    });
  }
}
