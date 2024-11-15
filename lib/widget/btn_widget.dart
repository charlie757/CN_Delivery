
  import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:flutter/material.dart';

btn({required String title,Function()?onTap,  double width = double.infinity, Color color = AppColor.lightBlueColor,
double? height
}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: getText(
            title: title,
            size: 13,
            textAlign: TextAlign.center,
            fontFamily: FontFamily.poppinsRegular,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w400),
      ),
    );
  }
