import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/getText.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/helper/custom_button.dart';
import 'package:cn_delivery/screens/auth/login_screen.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import '../localization/language_constrants.dart';
import '../provider/localization_provider.dart';
import '../utils/constants.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  int selectLanguage = 0;

  @override
  void initState() {
    selectLanguage = SessionManager.languageCode == 'es' ? 1 : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getText(
                title: getTranslated('choose', context)!,
                size: 35,
                fontFamily: FontFamily.poppinsMedium,
                color: AppColor.blueColor,
                fontWeight: FontWeight.w700),
            getText(
                title: getTranslated('your_language', context)!,
                size: 17,
                fontFamily: FontFamily.poppinsMedium,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w600),
            ScreenSize.height(25),
            chooseLanguageWidget('Hi', 'Are You Ok?', 'English', 0),
            ScreenSize.height(20),
            chooseLanguageWidget('Hola', '¿Estás bien?', 'Español', 1),
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: AppButton(
            title: getTranslated('continue', context)!,
            height: 50,
            width: double.infinity,
            buttonColor: AppColor.appTheme,
            onTap: () {
              SessionManager.setFirstTimeLanguageScreen=true;
              AppRoutes.pushCupertinoNavigation(const LoginScreen());
            }),
      ),
    );
  }

  chooseLanguageWidget(
      String title, String subTitle, String language, int index) {
    return GestureDetector(
      onTap: () {
        selectLanguage = index;
        Provider.of<LocalizationProvider>(context, listen: false)
            .setLanguage(Locale(
          Constants.languages[selectLanguage].languageCode!,
          Constants.languages[selectLanguage].countryCode,
        ));
        Provider.of<LocalizationProvider>(context, listen: false)
            .loadCurrentLanguage();
        setState(() {});
      },
      child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          color: AppColor.lightPinkColor,
          child: Container(
            width: double.infinity,
            color: selectLanguage == index
                ? AppColor.lightPinkColor.withOpacity(.08)
                : AppColor.lightTextColor.withOpacity(.08),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(
                    title: title,
                    size: 20,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blueColor,
                    fontWeight: FontWeight.w800),
                ScreenSize.height(15),
                getText(
                    title: subTitle,
                    size: 17,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
                ScreenSize.height(30),
                Align(
                  alignment: Alignment.centerRight,
                  child: getText(
                      title: language,
                      size: 18,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          )),
    );
  }
}
