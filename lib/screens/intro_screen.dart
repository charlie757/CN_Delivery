import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/getText.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/screens/select_language_screen.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Image.asset(AppImages.introImage),
            const Spacer(),
          Padding(padding:const EdgeInsets.only(left: 20,right: 20,bottom: 30),
          child: Column(
            children: [
                getText(title: getTranslated('introDes', context)!,
               textAlign: TextAlign.center,
             size: 18, fontFamily: FontFamily.poppinsSemiBold, color: AppColor.blueColor, fontWeight: FontWeight.w500),
             ScreenSize.height(40),
             AppButton(title: getTranslated('getStarted', context)!,
              height: 50, width: double.infinity, buttonColor: AppColor.appTheme, onTap: (){
                SessionManager.setIntroScreen=true;
              AppRoutes.pushCupertinoNavigation(const SelectLanguageScreen());
              })
            ],
          ),
          )
          ],
        ),
    );
  }
}