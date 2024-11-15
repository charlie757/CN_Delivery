

  import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/localization_provider.dart';
import 'package:cn_delivery/provider/profile_provider.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/customradio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

openLanguageBox(ProfileProvider profileProvider) {
    return showGeneralDialog(
      context: navigatorKey.currentContext!,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, state) {
          return Center(
            child: Container(
              // height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getText(
                          title: getTranslated('change_language', context)!,
                          size: 16,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                      // Icon(Icons.close)
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  ScreenSize.height(20),
                  GestureDetector(
                    onTap: () {
                      profileProvider.updateLangIndex(0);

                      state(() {});
                    },
                    child: Container(
                      height: 30,
                      color: AppColor.whiteColor,
                      child: Row(
                        children: [
                          customRadio(0, profileProvider.selectedLangIndex),
                          ScreenSize.width(15),
                          getText(
                              title: getTranslated('english', context)!,
                              size: 18,
                              fontFamily: FontFamily.nunitoMedium,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  ),
                  ScreenSize.height(15),
                  GestureDetector(
                    onTap: () {
                      profileProvider.updateLangIndex(1);
                      state(() {});
                    },
                    child: Container(
                      height: 30,
                      color: AppColor.whiteColor,
                      child: Row(
                        children: [
                          customRadio(1, profileProvider.selectedLangIndex),
                          ScreenSize.width(15),
                          getText(
                              title: getTranslated('spanish', context)!,
                              size: 18,
                              fontFamily: FontFamily.nunitoMedium,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  ),
                  ScreenSize.height(30),
                  AppButton(
                      title: getTranslated('okay', context)!,
                      height: 45,
                      width: 150,
                      buttonColor: AppColor.appTheme,
                      onTap: () {
                        Provider.of<LocalizationProvider>(context,
                                listen: false)
                            .setLanguage(Locale(
                          Constants.languages[profileProvider.selectedLangIndex]
                              .languageCode!,
                          Constants.languages[profileProvider.selectedLangIndex]
                              .countryCode,
                        ));

                        Provider.of<LocalizationProvider>(context,
                                listen: false)
                            .loadCurrentLanguage();
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

