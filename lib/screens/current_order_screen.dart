import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/screens/track_order_screen.dart';
import 'package:flutter/cupertino.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const TrackOrderScreen()));
              },
              child: ClipRRect(
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
            ),
            pickAndDeliveryInfo(),
            ScreenSize.height(15),
            orderDetails(),
            ScreenSize.height(50),
          ],
        ),
      ),
    );
  }

  pickAndDeliveryInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
      padding: const EdgeInsets.only(left: 15, right: 15, top: 17, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: 'Pickup and Deliver Info',
              size: 16,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
          Row(
            children: [
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
          ScreenSize.height(10),
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
          locationWidget(),
          ScreenSize.height(16),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          ScreenSize.height(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/profileImg.png',
                height: 40,
                width: 40,
              ),
              ScreenSize.width(12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: 'Aleksandr V.',
                        size: 15,
                        fontFamily: FontFamily.poppinsMedium,
                        color: Color(0xff2F2E36),
                        fontWeight: FontWeight.w400),
                    getText(
                        title: '+1 - 987-654-3210',
                        size: 15,
                        fontFamily: FontFamily.poppinsMedium,
                        color: Color(0xff2F2E36),
                        fontWeight: FontWeight.w400),
                  ],
                ),
              ),
              Image.asset(
                'assets/icons/Phone.png',
                width: 40,
                height: 40,
              )
            ],
          )
        ],
      ),
    );
  }

  orderDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
      padding: const EdgeInsets.only(top: 17, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 15),
            child: Row(
              children: [
                const getText(
                    title: 'Order Details',
                    size: 16,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: Color(0xff2F2E36),
                    fontWeight: FontWeight.w600),
                const Spacer(),
                Text.rich(TextSpan(
                    text: 'Total Amount : ',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.lightTextColor),
                    children: [
                      TextSpan(
                        text: '\$375',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.blackColor),
                      )
                    ]))
              ],
            ),
          ),
          ScreenSize.height(12),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          ScreenSize.height(23),
          orderWidget(),
          ScreenSize.height(15),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          ScreenSize.height(15),
          orderWidget(),
          ScreenSize.height(15),
        ],
      ),
    );
  }

  orderWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 15),
      child: Row(
        children: [
          Image.asset(
            'assets/images/order1.png',
            height: 50,
            width: 56,
          ),
          ScreenSize.width(12),
          Column(
            children: [
              const getText(
                  title: 'New Mini Mart',
                  size: 16,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: Color(0xff2F2E36),
                  fontWeight: FontWeight.w600),
              ScreenSize.height(2),
              const Text.rich(TextSpan(
                  text: 'Value : ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.lightTextColor),
                  children: [
                    TextSpan(
                      text: '375 USD',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: Color(0xff0790FF)),
                    )
                  ]))
            ],
          )
        ],
      ),
    );
  }

  locationWidget() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 40,
                  child: const VerticalDivider()),
              Image.asset(
                'assets/icons/location.png',
                height: 16,
                width: 16,
              ),
            ],
          ),
          ScreenSize.width(7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const getText(
                  title: '88 Zurab Gorgiladze St',
                  size: 15,
                  fontFamily: FontFamily.poppinsMedium,
                  color: Color(0xff2F2E36),
                  fontWeight: FontWeight.w400),
              ScreenSize.height(0),
              const getText(
                  title: 'Georgia, Batumi',
                  size: 13,
                  fontFamily: FontFamily.poppinsMedium,
                  color: Color(0xffB8B8B8),
                  fontWeight: FontWeight.w400),
              ScreenSize.height(8),
              const getText(
                  title: '5 Noe Zhordania St',
                  size: 15,
                  fontFamily: FontFamily.poppinsMedium,
                  color: Color(0xff2F2E36),
                  fontWeight: FontWeight.w400),
              ScreenSize.height(0),
              const getText(
                  title: 'Georgia, Batumi',
                  size: 13,
                  fontFamily: FontFamily.poppinsMedium,
                  color: Color(0xffB8B8B8),
                  fontWeight: FontWeight.w400),
            ],
          ),
        ],
      ),
    );
  }

  customBtn(String title) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xffC4D9ED)),
      alignment: Alignment.center,
      child: getText(
          title: title,
          size: 12,
          fontFamily: FontFamily.poppinsRegular,
          color: const Color(0xff0790FF),
          fontWeight: FontWeight.w400),
    );
  }
}
