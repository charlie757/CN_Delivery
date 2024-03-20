import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: getText(
            title: 'Dashboard',
            size: 20,
            fontFamily: FontFamily.poppinsRegular,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 40, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  onGoingCompletedWidget(AppColor.blueColor,
                      AppImages.onGoingIcon, 'On Going', '987'),
                  ScreenSize.width(15),
                  onGoingCompletedWidget(AppColor.lightPinkColor,
                      AppImages.completedIcon, 'Completed', '123,987'),
                ],
              ),
              ScreenSize.height(23),
              totalOrdersWidget(),
              ScreenSize.height(23),
              getText(
                  title: 'Upcoming Orders',
                  size: 22,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w600),
              ScreenSize.height(22),
              Image.asset('assets/images/Group 7.png'),
              ScreenSize.height(20),
              Image.asset('assets/images/Group 12.png'),
              ScreenSize.height(20),
              Image.asset('assets/images/Group 13.png'),
            ],
          ),
        ),
      ),
    );
  }

  onGoingCompletedWidget(
      Color color, String img, String title, String subTitle) {
    return Flexible(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 11, top: 23, bottom: 25),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 10,
                  color: AppColor.blueColor.withOpacity(.2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  img,
                  height: 43,
                  width: 43,
                ),
                ScreenSize.width(15),
                Flexible(
                  child: getText(
                      title: title,
                      size: 16,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            ScreenSize.height(22),
            getText(
                title: subTitle,
                size: 30,
                fontFamily: FontFamily.poppinsSemiBold,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w700)
          ],
        ),
      ),
    );
  }

  totalOrdersWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xff5714AC)),
      padding: const EdgeInsets.only(top: 23, left: 23, bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(AppImages.totalOrderIcon),
              ),
              ScreenSize.width(16),
              getText(
                  title: 'Total Orders',
                  size: 16,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w600)
            ],
          ),
          ScreenSize.height(22),
          getText(
              title: '123,987',
              size: 30,
              fontFamily: FontFamily.poppinsSemiBold,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w700)
        ],
      ),
    );
  }
}
