import "package:flutter/material.dart";

import "../helper/appImages.dart";
import "../helper/appcolor.dart";
import "../helper/fontfamily.dart";
import "../helper/getText.dart";
import "../helper/screensize.dart";
imageBottomSheet(BuildContext context, {required Function()cameraTap, required Function()galleryTap}) {
  showModalBottomSheet(
      backgroundColor: AppColor.whiteColor,
      context: context,
      builder: (context) {
        return Padding(
          padding:
          const EdgeInsets.only(top: 26, left: 30, right: 28, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(
                      title: 'Profile Photo',
                      size: 16,
                      fontFamily: FontFamily.nunitoMedium,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:const Icon(Icons.close))
                ],
              ),
              ScreenSize.height(25),
              Row(
                children: [
                  profileImageTypes(AppImages.cameraIcon, 'Camera', cameraTap),
                  ScreenSize.width(24),
                  profileImageTypes(AppImages.galleryIcon, 'Gallery', galleryTap),
                ],
              )
            ],
          ),
        );
      });
}

profileImageTypes(String img, String title, Function() onTap) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Column(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration:
          BoxDecoration(color: AppColor.eeeColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Image.asset(
            img,
            height: 22,
          ),
        ),
        ScreenSize.height(8),
        getText(
            title: title,
            size: 10,
            fontFamily: FontFamily.nunitoRegular,
            color: AppColor.textBlackColor,
            fontWeight: FontWeight.w400)
      ],
    ),
  );
}
