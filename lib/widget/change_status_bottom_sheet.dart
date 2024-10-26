import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/enum.dart';
import 'package:cn_delivery/widget/dialog_box.dart';
import 'package:flutter/material.dart';

openStatusBottomSheet(
    {required BuildContext context,
    required String orderStatus,
    Function()? ontap}) {
  showModalBottomSheet(
      backgroundColor: AppColor.whiteColor,
      isScrollControlled: true,
      shape: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.whiteColor),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                getText(
                    title: getTranslated('order_status', context)!,
                    size: 18,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(25),
                orderStatusWidget(
                  title: getTranslated('delivery_person_assigned', context)!,
                  subTitle: '',
                ),
                orderStatusWidget(
                    title: getTranslated('processing', context)!,
                    subTitle: '',
                    color: Constants.changeOrderStatusColor(
                            orderStatus.toString(), 1)
                        ? AppColor.blueColor
                        : AppColor.borderD9Color),
                orderStatusWidget(
                    title: getTranslated('order_ready_for_pickup', context)!,
                    subTitle: getTranslated('order_ready_for_pickup_subtitle', context)!,
                    color: Constants.changeOrderStatusColor(
                            orderStatus.toString(), 2)
                        ? AppColor.blueColor
                        : AppColor.borderD9Color),
                orderStatusWidget(
                    title: getTranslated('order_picked_up', context)!,
                    subTitle: getTranslated('order_picked_up_from_store', context)!,
                    color: Constants.changeOrderStatusColor(
                            orderStatus.toString(), 3)
                        ? AppColor.blueColor
                        : AppColor.borderD9Color),
                orderStatusWidget(
                    title: getTranslated('delivered', context)!,
                    subTitle: getTranslated('order_delivered_to_customer', context)!,
                    isShowVerticalDivider: false,
                    color: Constants.changeOrderStatusColor(
                            orderStatus.toString(), 4)
                        ? AppColor.blueColor
                        : AppColor.borderD9Color),
                ScreenSize.height(15),
                orderStatus.toString().toLowerCase() ==
                        OrderStatusTypes.delivered.name
                    ? Container()
                    : AppButton(
                        title: orderStatus.toString().toLowerCase() ==
                                OrderStatusTypes.order_ready_for_pickup.name
                            ? getTranslated('pickedUp', context)!
                            : orderStatus.toString().toLowerCase() ==
                                    OrderStatusTypes
                                        .order_picked_up_by_delivery_person.name
                                ? getTranslated('delivered', context)!
                                : '',
                        height: 45,
                        width: double.infinity,
                        buttonColor: AppColor.appTheme,
                        onTap: () {
                          openDialogBox(
                              title: getTranslated('confirmation', context)!,
                              subTitle:
                                  getTranslated('are_you_sure_change_status', context)!,
                              noTap: () {
                                Navigator.pop(context);
                              },
                              yesTap: ontap!);
                        })
              ],
            ),
          ),
        );
      });
}

Widget orderStatusWidget(
    {required String title,
    required String subTitle,
    Color color = AppColor.blueColor,
    bool isShowVerticalDivider = true}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      IntrinsicHeight(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 20,
              width: 20,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(
                Icons.check,
                color: AppColor.whiteColor,
                size: 17,
              ),
            ),
            isShowVerticalDivider
                ? Container(
                    height: 50,
                    width: 2,
                    color: color,
                  )
                : Container()
          ],
        ),
      ),
      ScreenSize.width(15),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: title,
              size: 15,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
          getText(
              title: subTitle,
              size: 14,
              fontFamily: FontFamily.nunitoRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w400)
        ],
      )
    ],
  );
}
