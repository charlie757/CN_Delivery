import 'package:cn_delivery/utils/customcircle.dart';
import 'package:flutter/material.dart';

showCircleProgressDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CustomCircularProgressIndicator(),
        );
      });
}
