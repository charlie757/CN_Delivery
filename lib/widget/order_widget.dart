import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/order_model.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/enum.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/btn_widget.dart';
import 'package:cn_delivery/widget/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

orderWidget(
    {required OrderModel model,
    required BuildContext context,
    Function()? onTap,}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffF5F5F5)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                color: AppColor.blackColor.withOpacity(.2))
          ]),
      padding: const EdgeInsets.only(top: 15, left: 17, right: 15, bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: getText(
                title: model.orderDate.toString(),
                size: 12,
                fontFamily: FontFamily.poppinsRegular,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w400),
          ),
          ScreenSize.height(1),
          model.product != null
              ? Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: model.product![0].image.isEmpty
                            ? Container()
                            : NetworkImagehelper(
                                img: model.product![0].image,
                                height: 60.0,
                                width: 66.0,
                              )),
                    ScreenSize.width(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.product![0].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontFamily.poppinsMedium,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(TextSpan(
                                        text:
                                            '${getTranslated('qty', context)!}: ',
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily:
                                                FontFamily.poppinsRegular),
                                        children: [
                                          TextSpan(
                                              text: model.product![0].qty
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColor.blackColor,
                                                  fontFamily: FontFamily
                                                      .poppinsRegular))
                                        ])),
                                    Text.rich(TextSpan(
                                        text:
                                            '${getTranslated('price', context)!}: ',
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily:
                                                FontFamily.poppinsRegular),
                                        children: [
                                          TextSpan(
                                              text: model.product![0].price
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColor.blackColor,
                                                  fontFamily: FontFamily
                                                      .poppinsRegular))
                                        ])),
                                  ],
                                ),
                              ),
                              // ScreenSize.width(2),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
          ScreenSize.height(10),
          Row(
            children: [
              getText(
                  title: '${getTranslated('total_order_values', context)!}: ',
                  size: 13,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor.withOpacity(.5),
                  fontWeight: FontWeight.w400),
              getText(
                  title: '${model.orderAmount.toString()} COP',
                  size: 14,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400),
            ],
          ),
          ScreenSize.height(4),
          Row(
            children: [
              getText(
                  title: '${getTranslated('payment_method', context)!}: ',
                  size: 13,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor.withOpacity(.5),
                  fontWeight: FontWeight.w400),
              Flexible(
                child: Text(
                  model.paymentMethod.toString() == 'cash_on_delivery'
                      ? "COD"
                      : model.paymentMethod.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          ScreenSize.height(12),
          Constants.checkOrderStatus(model.orderStatus)
              ? orderButton(
                  model.orderStatus.toString().capitalize().replaceAll("_", ' '),
                  model.orderStatus.toString().toLowerCase() ==
                          OrderStatusTypes.delivered.name
                      ? AppColor.greenColor
                      : const Color(0xffFE70D8))
              : Container() ],
      ),
    ),
  );
}

orderButton(String title, Color color) {
  return Container(
    height: 35,
    // width: 120,
    padding: const EdgeInsets.only(left: 16, right: 16),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    child: getText(
        title: title,
        size: 13,
        fontFamily: FontFamily.poppinsRegular,
        color: AppColor.whiteColor,
        maxLies: 1,
        fontWeight: FontWeight.w400),
  );
}

viewOrderDetailsButton(Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      // height: 32,
      width: 143,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
      // padding: const EdgeInsets.only(left: 16, right: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff5DBCF2),
        borderRadius: BorderRadius.circular(16.5),
      ),
      child: getText(
          title: getTranslated(
              'view_order_details', navigatorKey.currentContext!)!,
          size: 13,
          textAlign: TextAlign.center,
          fontFamily: FontFamily.poppinsRegular,
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w400),
    ),
  );
}