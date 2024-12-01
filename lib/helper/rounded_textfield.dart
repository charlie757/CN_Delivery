// ignore_for_file: must_be_immutable

import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatelessWidget {
  String hintText;
  final TextEditingController controller;
  final prefixIcon;
  final suffixIcon;
  final isObscureText;
  bool isReadOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final errorMsg;
  final ValueChanged<String>? onChanged;
  TextInputAction? textInputAction;
  Function()?onTap;
   RoundedTextField(
      {super.key,
      this.hintText='',
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.isObscureText = false,
      this.isReadOnly = false,
      this.inputFormatters,
      this.textInputType,
      this.errorMsg,
      this.textInputAction,
      this.onChanged,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: errorMsg == '' || errorMsg == null
                      ? AppColor.blackColor.withOpacity(.09)
                      : AppColor.redColor),
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
            onTap: onTap,
            textInputAction: textInputAction,
            readOnly: isReadOnly,
            cursorColor: AppColor.appTheme,
            obscureText: isObscureText,
            inputFormatters: inputFormatters,
            keyboardType: textInputType,
            style: TextStyle(
                fontSize: 14,
                color: AppColor.textBlackColor,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.poppinsMedium),
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 4,
          ),
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
            onChanged: onChanged,
          ),
        ),
        errorMsg == '' || errorMsg == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: getText(
                    title: errorMsg.toString(),
                    size: 12,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.redColor,
                    fontWeight: FontWeight.w500),
              )
      ],
    );
  }
}
