import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:flutter/material.dart';

AppBar appBar(String title, Function() onTap) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    backgroundColor: AppColor.whiteColor,
    leading: title == 'Track Order'
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 3),
              child: Image.asset(
                AppImages.arrowBackIcon,
                width: 30,
                height: 30,
              ),
            ),
          )
        : Container(),
    bottom: PreferredSize(
      preferredSize: const Size(double.infinity, 18),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: getText(
              title: title,
              size: 20,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
