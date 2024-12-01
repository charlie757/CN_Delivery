import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/screens/dashboard/notification_screen.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

AppBar appBar(
    {required String title,
    bool isNotification = false,
    bool isLeading = false,
    bool isWallet = false}) {
  return AppBar(
    backgroundColor: AppColor.whiteColor,
    scrolledUnderElevation: 0.0,
    automaticallyImplyLeading: isLeading,
    title: getText(
        title: title,
        size: 18,
        fontFamily: FontFamily.poppinsMedium,
        color: AppColor.blackColor,
        fontWeight: FontWeight.w600),
    actions: [
      isWallet ? walletWidget() : Container(),
      isNotification
          ? GestureDetector(
              onTap: () {
                AppRoutes.pushCupertinoNavigation(const NotificationScreen());
              },
              child: Container(
                  padding: const EdgeInsets.only(right: 15),
                  child:const Icon(
                    Icons.notifications,
                    color: AppColor.blueColor,
                  )),
            )
          : Container()
    ],
  );
}

walletWidget() {
  return Container(
    margin: const EdgeInsets.only(right: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColor.blueColor.withOpacity(.5))),
    padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
    child: Row(
      children: [
        Image.asset(
          height: 22,
          width: 22,
          AppImages.walletIcon,
          // color: Colors.black87,
        ),
        ScreenSize.width(5),
        getText(
            title: "0",
            size: 13,
            fontFamily: FontFamily.nunitoMedium,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600)
      ],
    ),
  );
}

AppBar appbarWithLeading(String title) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    backgroundColor: AppColor.whiteColor,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(navigatorKey.currentContext!);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 3),
        child: Image.asset(
          AppImages.arrowBackIcon,
          width: 30,
          height: 30,
        ),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: const Size(double.infinity, 5),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: getText(
              title: title,
              size: 20,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

AppBar profileAppBar(
    {required bool value,
    required Function(bool) onChanged,
    required Function() onTap}) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    backgroundColor: AppColor.whiteColor,
    automaticallyImplyLeading: false,
    title: getText(
        title: getTranslated('profile', navigatorKey.currentContext!)!,
        size: 20,
        fontFamily: FontFamily.poppinsRegular,
        color: AppColor.blackColor,
        fontWeight: FontWeight.w600),
    actions: [
      Container(
        padding: const EdgeInsets.only(right: 15),
        child: FlutterSwitch(
            width: 48.0,
            activeText: '',
            inactiveText: '',
            height: 28.0,
            inactiveColor: AppColor.lightTextColor.withOpacity(.4),
            // valueFontSize: 25.0,
            toggleSize: 20.0,
            value: value,
            borderRadius: 30.0,
            // padding: 8.0,
            showOnOff: true,
            onToggle: onChanged),
      ),
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          child: const Icon(Icons.more_vert),
        ),
      )
    ],
  );
}
