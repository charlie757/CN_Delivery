import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/customtextfield.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
      ),
      body: Stack(
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
                        title: 'Welcome Back',
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
                      'To',
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
                        ' Consumers Networks',
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
                  controller: phoneController,
                  hintText: 'Enter Your Phone Number',
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
                  controller: passwordController,
                  hintText: 'Enter Your Password',
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
                    title: 'SIGN IN',
                    height: 56,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                    onTap: () {
                      AppRoutes.pushCupertinoNavigation(
                          const DashboardScreen());
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
