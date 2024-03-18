import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:flutter/material.dart';

class CurrentOrderScreen extends StatefulWidget {
  const CurrentOrderScreen({super.key});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Image.asset(
              'assets/images/mapImg.png',
              height: MediaQuery.of(context).size.height / 2.5,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          pickAndDeliveryInfo()
        ],
      ),
    );
  }

  pickAndDeliveryInfo() {
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
      padding: const EdgeInsets.only(left: 15, right: 15, top: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              getText(
                  title: 'Pickup and Deliver Info',
                  size: 16,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w600),
              const Spacer(),
              const getText(
                  title: 'Order No. 15306',
                  size: 13,
                  fontFamily: FontFamily.poppinsRegular,
                  color: Color(0xffB8B8B8),
                  fontWeight: FontWeight.w400),
              ScreenSize.width(4),
              const Icon(
                Icons.more_vert,
                size: 19,
                color: Color(0xffB8B8B8),
              )
            ],
          ),
          ScreenSize.height(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customBtn('Processed'),
              customBtn('COD'),
            ],
          ),
          ScreenSize.height(16),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          ScreenSize.height(16),
          locationWidget()
        ],
      ),
    );
  }

  locationWidget() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD9D9D9), width: 2),
                    shape: BoxShape.circle),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  height: 3,
                  width: 3,
                  decoration: BoxDecoration(
                      color: AppColor.appTheme, shape: BoxShape.circle),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 2, bottom: 2),
                  height: 30,
                  child: VerticalDivider())
            ],
          )
        ],
      ),
    );
  }

  customBtn(String title) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xffFEF7EC)),
      alignment: Alignment.center,
      child: getText(
          title: title,
          size: 12,
          fontFamily: FontFamily.poppinsRegular,
          color: const Color(0xffF2AB58),
          fontWeight: FontWeight.w400),
    );
  }
}
