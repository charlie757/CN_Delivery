
import 'dart:io';

import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../helper/appImages.dart';
import '../helper/appcolor.dart';
import '../helper/fontfamily.dart';
import '../helper/getText.dart';
import '../helper/network_image_helper.dart';

uploadImageWidget({required Function() onTap,required File? imgPath,String imgUrl=''}){
  return DottedBorder(
      borderType: BorderType.RRect,
      radius:const Radius.circular(12),
      padding: EdgeInsets.all( imgPath!=null?0:8),
      color: AppColor.lightTextColor,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: MediaQuery.of(navigatorKey.currentContext!).size.width/2,
          height: 130,
          child: imgPath!=null?
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(imgPath,fit: BoxFit.cover,width: double.infinity,height: double.infinity,)):
          imgUrl.isNotEmpty?
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: NetworkImagehelper(
                img: imgUrl,
              )):
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.uploadImage,color: AppColor.lightTextColor.withOpacity(.4),height: 80,),
               getText(title:getTranslated('upload_image', navigatorKey.currentContext!)! ,
                  size: 13, fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.lightTextColor, fontWeight: FontWeight.w400)
            ],
          ),
        ),
      ));
}
