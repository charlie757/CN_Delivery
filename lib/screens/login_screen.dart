import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/customtextfield.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/login_provider.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
      ),
      body: Consumer<LoginProvider>(builder: (context, myProvider, child) {
        return Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(AppImages.backgroundImg)),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.logo,
                    height: 80,
                    width: 165,
                    fit: BoxFit.cover,
                  ),
                  ScreenSize.height(40),
                  Row(
                    children: [
                      getText(
                          title: getTranslated('welcome_back', context)!,
                          size: 23,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                      ScreenSize.width(6),
                      Image.asset(
                        AppImages.handEmoji,
                        height: 30,
                        width: 30,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      AutoSizeText(
                        getTranslated('to', context)!,
                        style: TextStyle(
                            fontSize: 23,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600),
                        minFontSize: 16,
                        maxLines: 1,
                      ),
                      Flexible(
                        child: AutoSizeText(
                          getTranslated('cnsumers_Networks', context)!,
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: FontFamily.poppinsSemiBold,
                              color: AppColor.blueColor,
                              fontWeight: FontWeight.w600),
                          minFontSize: 16,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  ScreenSize.height(20),
                  CustomTextfield(
                    controller: myProvider.emailController,
                    hintText: getTranslated('enter_your_email', context)!,
                    isReadOnly: myProvider.isLoading,
                    errorMsg: myProvider.emailValidationMsg,
                    onChanged: (val) {
                      myProvider.emailValidationMsg =
                          AppValidation.emailValidator(val);
                      setState(() {});
                    },
                    icon: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      child: ImageIcon(
                        const AssetImage(
                          AppImages.callIcon,
                        ),
                        size: 24,
                        color: AppColor.blueColor,
                      ),
                    ),
                  ),
                  ScreenSize.height(25),
                  CustomTextfield(
                    controller: myProvider.passwordController,
                    hintText: getTranslated('enter_your_password', context)!,
                    isReadOnly: myProvider.isLoading,
                    errorMsg: myProvider.passwordValidationMsg,
                    onChanged: (val) {
                      myProvider.passwordValidationMsg =
                          AppValidation.passwordValidator(val);
                      setState(() {});
                    },
                    icon: Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      child: ImageIcon(
                        const AssetImage(
                          AppImages.passwordIcon,
                        ),
                        color: AppColor.blueColor,
                        size: 24,
                      ),
                    ),
                  ),
                  ScreenSize.height(40),
                  AppButton(
                      title: getTranslated('sign_in', context)!,
                      height: 56,
                      width: double.infinity,
                      buttonColor: AppColor.appTheme,
                      isLoading: myProvider.isLoading,
                      onTap: () {
                        myProvider.isLoading
                            ? null
                            : myProvider.checkValidation();
                        // AppRoutes.pushCupertinoNavigation(
                        //     const DashboardScreen());
                      })
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
