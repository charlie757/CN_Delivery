import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

void openDialogBox(
    {
    required String title,
    required String subTitle,
    required Function() noTap,
    required Function() yesTap}) {
  showGeneralDialog(
    context: navigatorKey.currentContext!,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Stack(
        children: [
          Center(
            child: Container(
              // height: 394,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 35, left: 20, right: 20, bottom: 33),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.textBlackColor,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    ScreenSize.height(20),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          subTitle,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              fontFamily: FontFamily.poppinsSemiBold,
                              color: AppColor.textBlackColor,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                    ScreenSize.height(47),
                    Row(
                      children: [
                        Flexible(
                          child: AppButton(
                            elevation: 1,
                              title: getTranslated(
                                  'no', navigatorKey.currentContext!)!,
                              height: 40,
                              width: double.infinity,
                              buttonColor: AppColor.whiteColor,
                              textColor: AppColor.textBlackColor,
                              onTap: noTap),
                        ),
                        ScreenSize.width(20),
                        Flexible(
                          child: AppButton(
                            elevation: 1,
                              title: getTranslated(
                                  'yes', navigatorKey.currentContext!)!,
                              height: 40,
                              width: double.infinity,
                              buttonColor: AppColor.appTheme,
                              onTap: yesTap),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
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
