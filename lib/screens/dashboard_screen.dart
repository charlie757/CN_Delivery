import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/provider/dashboard_provider.dart';
import 'package:cn_delivery/screens/all_orders_screen.dart';
import 'package:cn_delivery/screens/current_order_screen.dart';
import 'package:cn_delivery/screens/earning_screen.dart';
import 'package:cn_delivery/screens/home_screen.dart';
import 'package:cn_delivery/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List screenList = [
    const HomeScreen(),
    const CurrentOrderScreen(),
    const AllOrderScreen(),
    const EarningScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        body: screenList[myProvider.currentIndex],
        bottomNavigationBar: Container(
          height: 65,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, -1),
                    blurRadius: 2,
                    color: AppColor.blackColor.withOpacity(.1))
              ]),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customBottomNavigationBar(
                  AppImages.homeIcon, 'Home', 0, myProvider, () {
                myProvider.updateIndex(0);
              }),
              customBottomNavigationBar(
                  AppImages.currentOrderIcon, 'Current Orders', 1, myProvider,
                  () {
                myProvider.updateIndex(1);
              }),
              customBottomNavigationBar(
                  AppImages.allOrderIcon, 'All Orders', 2, myProvider, () {
                myProvider.updateIndex(2);
              }),
              customBottomNavigationBar(
                  AppImages.earningIcon, 'Earning', 3, myProvider, () {
                myProvider.updateIndex(3);
              }),
              customBottomNavigationBar(
                  AppImages.profileIcon, 'Profile', 4, myProvider, () {
                myProvider.updateIndex(4);
              }),
            ],
          ),
        ),
      );
    });
  }

  customBottomNavigationBar(String img, String title, int index,
      DashboardProvider provider, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColor.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              height: 20,
              width: 20,
              color: provider.currentIndex == index
                  ? AppColor.appTheme
                  : const Color(0xffB8B8B8),
            ),
            ScreenSize.height(6),
            getText(
                title: title,
                size: 11,
                fontFamily: FontFamily.poppinsMedium,
                color: provider.currentIndex == index
                    ? AppColor.appTheme
                    : const Color(0xffB8B8B8),
                fontWeight: FontWeight.w400)
          ],
        ),
      ),
    );
  }
}
