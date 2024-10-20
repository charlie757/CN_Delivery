import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/screens/auth/login_screen.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum httpMethod { post, get, delete, put }

checkApiMethod(type) {
  switch (type) {
    case httpMethod.post:
      return 'POST';
    case httpMethod.get:
      return 'GET';
    case httpMethod.delete:
      return 'DELETE';
    case httpMethod.put:
      return 'PUT';
    default:
      print('Unknown color');
  }
}

class ApiService {
  static Future apiMethod(
      {required String url,
      required var body,
      required String method,
      bool isErrorMessageShow = true,
      bool isBodyNotRequired = false}) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final request = http.Request(
            method,
            Uri.parse(url),
          );

          request.body = body;
          request.headers['Content-Type'] = 'application/json';
          request.headers['Authorization'] = "Bearer ${SessionManager.token}";
          request.headers['language'] =
              SessionManager.languageCode == 'es' ? 'es' : 'en';
          final client = http.Client();
          final streamedResponse = await client.send(request);
          final response = await http.Response.fromStream(streamedResponse);
          print(response.request);
          log(response.body);
          print(response.statusCode);
          return _handleResponse(response, isErrorMessageShow, url);
        } on Exception catch (_) {
          
        }
      } else {}
    } on SocketException catch (_) {
      Utils.internetSnackBar(navigatorKey.currentContext!);
      // print('not connected');
    }
  }

  // Helper method to handle API response
  static _handleResponse(http.Response response, isErrorMessageShow, String url) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      print(Constants.is401Error);
      if(Constants.is401Error==false){
        Future.delayed(const Duration(seconds: 1),(){
          Constants.is401Error=true;
          Utils.logOut();
        });
      }
      else{
        print('fgfdhfg');
      }
      return null;
    } else {
      var dataAll = json.decode(response.body);
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return url==ApiUrl.loginUrl? dataAll:null;
    }
  }
}
