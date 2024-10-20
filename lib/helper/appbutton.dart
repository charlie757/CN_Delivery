import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final double elevation;
  final Function() onTap;
  final isLoading;
  const AppButton(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.buttonColor,
      this.textColor = Colors.white,
      this.elevation = 7.0,
      required this.onTap,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          shadowColor: AppColor.appTheme,
          backgroundColor: buttonColor,
          // primary: widget.buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColor.whiteColor,
                ),
              )
            : getText(
                title: title,
                size: 18,
                fontFamily: FontFamily.poppinsMedium,
                color: textColor,
                fontWeight: FontWeight.w500),
      ),
    );
  }
}
