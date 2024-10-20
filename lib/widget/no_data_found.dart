import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:flutter/material.dart';
Widget noDataFound(String title) {
  return Align(
    alignment: Alignment.center,
    child: getText(
      title: title,
      size: 13,
      fontFamily: FontFamily.nunitoMedium,
      color: AppColor.redColor,
      fontWeight: FontWeight.w400,
    ),
  );
}
