import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final Function() onTap;
  const AppButton({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.onTap,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 7,
          shadowColor: AppColor.appTheme,
          backgroundColor: widget.buttonColor,
          // primary: widget.buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      onPressed: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: getText(
            title: widget.title,
            size: 20,
            fontFamily: FontFamily.poppinsMedium,
            color: widget.textColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
