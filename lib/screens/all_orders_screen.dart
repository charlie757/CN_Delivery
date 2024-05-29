import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/all_order_model.dart';
import 'package:cn_delivery/provider/all_order_provider.dart';
import 'package:cn_delivery/screens/view_order_details_screen.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  List orderList = [
    {
      'img': 'assets/images/order1.png',
      'progress': getTranslated('in_progress', navigatorKey.currentContext!)!,
    },
    {
      'img': 'assets/images/order2.png',
      'progress': getTranslated('cancelled', navigatorKey.currentContext!)!,
    },
    {
      'img': 'assets/images/order3.png',
      'progress': getTranslated('completed', navigatorKey.currentContext!)!,
    },
    {
      'img': 'assets/images/order4.png',
      'progress': getTranslated('in_progress', navigatorKey.currentContext!)!,
    }
  ];

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<AllOrderProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      myProvider.getAllOrderApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(title: getTranslated('all_orders', context)!),
      body: Consumer<AllOrderProvider>(builder: (context, myProvider, child) {
        return myProvider.allOrderList.isEmpty
            ? Center(
                child: getText(
                    title: getTranslated('no_order_found', context)!,
                    size: 16,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w400),
              )
            : ListView.separated(
                separatorBuilder: (context, sp) {
                  return ScreenSize.height(15);
                },
                itemCount: myProvider.allOrderList.length,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 40, top: 20),
                itemBuilder: (context, index) {
                  var model =
                      AllOrderModel.fromJson(myProvider.allOrderList[index]);
                  return orderWidget(model, myProvider);
                });
      }),
    );
  }

  orderWidget(AllOrderModel model, AllOrderProvider provider) {
    return Container(
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
          Row(
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
                                  text: '${getTranslated('qty', context)!}: ',
                                  style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.poppinsRegular),
                                  children: [
                                    TextSpan(
                                        text: model.product![0].qty.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColor.blackColor,
                                            fontFamily:
                                                FontFamily.poppinsRegular))
                                  ])),
                              Text.rich(TextSpan(
                                  text: '${getTranslated('price', context)!}: ',
                                  style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.poppinsRegular),
                                  children: [
                                    TextSpan(
                                        text:
                                            model.product![0].price.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColor.blackColor,
                                            fontFamily:
                                                FontFamily.poppinsRegular))
                                  ])),
                            ],
                          ),
                        ),
                        ScreenSize.width(2),
                        orderButton(
                            model.orderStatus,
                            model.orderStatus.toString().toUpperCase() ==
                          getTranslated('cancelled', context)!.toUpperCase()
                                    // 'CANCELED'
                                ? const Color(0xff6E6E96)
                                : model.orderStatus.toString().toUpperCase() ==
                                getTranslated('delivered', context)!.toUpperCase()
                                        // 'DELIVERED'
                                    ? AppColor.greenColor
                                    : const Color(0xffFE70D8)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ScreenSize.height(5),
          Align(
            alignment: Alignment.centerRight,
            child: viewOrderDetailsButton(model.id.toString(), provider),
          ),
          ScreenSize.height(6),
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
                  model.paymentMethod.toString(),
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
        ],
      ),
    );
  }

  orderButton(String title, Color color) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 16, right: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.5),
      ),
      child: getText(
          title: title,
          size: 13,
          fontFamily: FontFamily.poppinsRegular,
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w400),
    );
  }

  viewOrderDetailsButton(String id, AllOrderProvider provider) {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(ViewOrderDetailsScreen(
          orderId: id.toString(),
        )).then((value) {
          provider.getAllOrderApiFunction();
        });
      },
      child: Container(
        height: 32,
        width: 143,
        // padding: const EdgeInsets.only(left: 16, right: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff5DBCF2),
          borderRadius: BorderRadius.circular(16.5),
        ),
        child: getText(
            title: getTranslated('view_order_details', context)!,
            size: 13,
            fontFamily: FontFamily.poppinsRegular,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
