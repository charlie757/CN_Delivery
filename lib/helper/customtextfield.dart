import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final hintText;
  final TextEditingController controller;
  final icon;
  final isObscureText;
  final isReadOnly;
  const CustomTextfield(
      {super.key,
      this.hintText,
      required this.controller,
      this.icon,
      this.isObscureText = false,
      this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColor.blackColor.withOpacity(.09)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 0),
                color: AppColor.blackColor.withOpacity(.1))
          ]),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        cursorColor: AppColor.appTheme,
        obscureText: isObscureText,
        style: TextStyle(
            fontSize: 14,
            color: AppColor.textBlackColor,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.poppinsMedium),
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 16,
                color: AppColor.lightTextColor,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.nunitoMedium),
            fillColor: AppColor.whiteColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColor.whiteColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColor.whiteColor))),
      ),
    );
  }
}
