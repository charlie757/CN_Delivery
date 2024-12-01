import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/rounded_textfield.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/getText.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/forgot_password_provider.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/top_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../helper/appImages.dart';
import '../../helper/appbutton.dart';
import '../../utils/app_validation.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          appBar: appBar(title: '',isLeading: true),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               topLogo(alignment: Alignment.centerLeft),
                ScreenSize.height(40),
                getText(title: getTranslated('setNewPassword', context)!,
                    size: 22, fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor, fontWeight: FontWeight.w500),
                ScreenSize.height(20),
                RoundedTextField(
                  controller: myProvider.passwordController,
                  hintText: getTranslated('new_password', context)!,
                  errorMsg: myProvider.passwordErrorMsg,
                   inputFormatters: [
                      FilteringTextInputFormatter.deny( RegExp(r'\s')),
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                   
                  onChanged: (val) {
                    myProvider.passwordErrorMsg =
                        AppValidation.reEnterpasswordValidator(
                            val, myProvider.confirmPasswordController.text);
                    setState(() {});
                  },
                  prefixIcon: const ImageIcon(
                     AssetImage(
                      AppImages.passwordIcon,
                    ),
                    size: 24,
                    color: AppColor.blueColor,
                  ),
                ),
                ScreenSize.height(20),
                RoundedTextField(
                  controller: myProvider.confirmPasswordController,
                  hintText: getTranslated('confirm_password', context)!,
                  errorMsg: myProvider.confirmNewPasswordErrorMsg,
                   inputFormatters: [
                      FilteringTextInputFormatter.deny( RegExp(r'\s')),
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                   
                  onChanged: (val) {
                    myProvider.confirmNewPasswordErrorMsg =
                        AppValidation.reEnterpasswordValidator(
                            val, myProvider.passwordController.text);
                    setState(() {});
                  },
                  prefixIcon: const ImageIcon(
                     AssetImage(
                      AppImages.passwordIcon,
                    ),
                    size: 24,
                    color: AppColor.blueColor,
                  ),
                ),
                ScreenSize.height(50),
                AppButton(
                    title: getTranslated('reset_password', context)!,
                    height: 49,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                    isLoading: myProvider.isLoading,
                    onTap: () {
                      myProvider.checkPasswordValidation();
                    })

              ],
            ),
          ),
        );
      }
    );
  }
}
