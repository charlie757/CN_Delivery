import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final Function() onTap;
  final isLoading;
  const CustomButton(
      {super.key,
        required this.title,
        required this.height,
        required this.width,
        required this.buttonColor,
        this.textColor = Colors.white,
        required this.onTap,
        this.isLoading = false});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 7,
          shadowColor: AppColor.blueColor,
          backgroundColor: widget.buttonColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      onPressed: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: widget.isLoading
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColor.whiteColor,
          ),
        )
            : getText(
            title: widget.title,
            size: 20,
            fontFamily: FontFamily.poppinsMedium,
            color: widget.textColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
