import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'appcolor.dart';
import 'getText.dart';

class SignUpTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final validator;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  Color textColor;
  int maxLine;
  var suffix;
  bool isObscureText;
  FocusNode? focusNode;
  Function()?onTap;

  SignUpTextField({required this.hintText,  this.controller,this.textInputType=TextInputType.text,
    this.inputFormatters,
    this.isReadOnly=false,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.textColor = const Color(0xff0E0E0E),
    this.focusNode,
    this.maxLine=1,
    this.suffix,
    this.isObscureText=false,this.onTap
  });

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      readOnly: widget.isReadOnly,
      onTap: widget.onTap,
      keyboardType: widget.textInputType,
      textInputAction:widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      autofocus: false,
      maxLines: widget.maxLine,
      style: TextStyle(
          fontSize: 14,
          color: AppColor.textBlackColor,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.poppinsMedium),
      cursorColor: AppColor.blueColor,
      obscureText: widget.isObscureText,
      decoration: InputDecoration(
        suffixIcon: widget.suffix,
        border: OutlineInputBorder(
            borderSide:const BorderSide(
                color: AppColor.lightTextColor,
                width: 1
            ),
            borderRadius: BorderRadius.circular(5)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.lightTextColor.withOpacity(.6),
                width: 1
            ),
            borderRadius: BorderRadius.circular(5)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor,width: 1),
            borderRadius: BorderRadius.circular(5)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor,width: 1),
            borderRadius: BorderRadius.circular(5)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.lightTextColor.withOpacity(.6),
                width: 1
            ),
            borderRadius: BorderRadius.circular(5)
        ),
        hintText: widget.hintText,
        errorMaxLines: 3,
        errorStyle: TextStyle(
          color: AppColor.redColor,
        ),
        hintStyle: const TextStyle(
            fontSize: 14,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.nunitoMedium),

      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    ); }
}