import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/screens/login_screen.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
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
          request.headers['Authorization'] = SessionManager.token;
          final client = http.Client();
          final streamedResponse = await client.send(request);
          final response = await http.Response.fromStream(streamedResponse);
          print(response.request);
          log(response.body);
          print(response.statusCode);
          return _handleResponse(response, isErrorMessageShow);
        } on Exception catch (_) {
          rethrow;
        }
      } else {}
    } on SocketException catch (_) {
      Utils.internetSnackBar(navigatorKey.currentContext!);
      // print('not connected');
    }
  }

  // Helper method to handle API response
  static _handleResponse(http.Response response, isErrorMessageShow) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      var dataAll = json.decode(response.body);
      // SessionManager.unauthorizedUser(navigatorKey.currentState!.context);
      Utils.logOut();
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return null;
    } else {
      var dataAll = json.decode(response.body);
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return null;
    }
  }
}
