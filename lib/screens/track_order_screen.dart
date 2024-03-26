import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/model/view_order_model.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  final model;
  const TrackOrderScreen({super.key, this.model});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appbarWithLeading('Track Order'),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 23, left: 15, right: 15, bottom: 40),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              orderWidget(),
              trackWidget(),
              ScreenSize.height(50),
              AppButton(
                  title: 'TRACK DRIVER',
                  height: 49,
                  width: double.infinity,
                  buttonColor: AppColor.appTheme,
                  onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

  orderWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.whiteColor,
          border: Border.all(color: const Color(0xffF5F5F5)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 3)
          ]),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const getText(
                  title: 'Order number',
                  size: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppinsRegular,
                  color: Color(0xff868686)),
              getText(
                  title: widget.model.id.toString(),
                  size: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: AppColor.blackColor)
            ],
          ),
          ScreenSize.height(19),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const getText(
                  title: 'Estimate time of arrival',
                  size: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppinsRegular,
                  color: Color(0xff868686)),
              getText(
                  title: '8:15 AM',
                  size: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: AppColor.blackColor)
            ],
          ),
        ],
      ),
    );
  }

  trackWidget() {
    return Align(
      alignment: Alignment.center,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Row(
            children: [
              Column(
                children: [
                  const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        thickness: 4,
                        color: Color(0xff1455AC),
                      )),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff1455AC)),
                  ),
                  SizedBox(
                      height: 80,
                      child: VerticalDivider(
                        thickness: 4,
                        color: widget.model.orderStatus == 'out_for_delivery' ||
                                widget.model.orderStatus == 'delivered'
                            ? const Color(0xff1455AC)
                            : const Color(0xffDADADA),
                      )),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: widget.model.orderStatus == 'out_for_delivery' ||
                                widget.model.orderStatus == 'delivered'
                            ? const Color(0xff1455AC)
                            : AppColor.whiteColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: widget.model.orderStatus ==
                                        'out_for_delivery' ||
                                    widget.model.orderStatus == 'delivered'
                                ? const Color(0xff1455AC)
                                : const Color(0xffDADADA),
                            width: 3)),
                  ),
                  SizedBox(
                      height: 80,
                      child: VerticalDivider(
                        thickness: 4,
                        color: widget.model.orderStatus == 'delivered'
                            ? const Color(0xff1455AC)
                            : const Color(0xffDADADA),
                      )),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.model.orderStatus == 'delivered'
                            ? const Color(0xff1455AC)
                            : AppColor.whiteColor,
                        border: Border.all(
                            color: widget.model.orderStatus == 'delivered'
                                ? const Color(0xff1455AC)
                                : const Color(0xffDADADA),
                            width: 3)),
                  )
                ],
              ),
              ScreenSize.width(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: getText(
                        title: 'Going to delivery',
                        size: 18,
                        fontFamily: FontFamily.nunitoRegular,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: getText(
                        title: 'Delivery',
                        size: 18,
                        fontFamily: FontFamily.nunitoRegular,
                        color: widget.model.orderStatus == 'out_for_delivery' ||
                                widget.model.orderStatus == 'delivered'
                            ? AppColor.blackColor
                            : const Color(0xff868686),
                        fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 68),
                    child: getText(
                        title: 'Completed\n& Payment Received',
                        size: 18,
                        fontFamily: FontFamily.nunitoRegular,
                        color: widget.model.orderStatus == 'delivered'
                            ? AppColor.blackColor
                            : const Color(0xff868686),
                        fontWeight: FontWeight.w300),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
