import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/dashboard_provider.dart';
import 'package:cn_delivery/provider/profile_provider.dart';
import 'package:cn_delivery/screens/all_orders_screen.dart';
import 'package:cn_delivery/screens/earning_screen.dart';
import 'package:cn_delivery/screens/home_screen.dart';
import 'package:cn_delivery/screens/profile_screen.dart';
import 'package:cn_delivery/utils/location_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() async{
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.currentIndex=0;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async{
      dashboardProvider.currentIndex = 0;
      profileProvider.getProfileApiFunction(true);
       dashboardProvider.updateLastLocationApiFunction();
      dashboardProvider.updateFcmTokenApiFunction();
    });
  }

  List screenList = [
    const HomeScreen(),
    // const CurrentOrderScreen(),
    const AllOrderScreen(),
    const EarningScreen(),
    const ProfileScreen()
  ];

updateLocation(){
  LocationService.getCurrentLocation();
  Provider.of<DashboardProvider>(context,listen: false).updateLastLocationApiFunction();
}

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, myProvider, child) {
      return PopScope(
        canPop: false,
        onPopInvoked: (val) {
          myProvider.onWillPop();
        },

        child: Scaffold(
          body: screenList[myProvider.currentIndex],
          bottomNavigationBar: Container(
            height: 65,
            decoration: BoxDecoration(
                color: AppColor.blueColor,
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
                    AppImages.homeIcon, getTranslated('home', context)!, 0, myProvider, () {
                      print('object');
                       updateLocation();
                  myProvider.updateIndex(0);
                }),
                // customBottomNavigationBar(
                //     AppImages.currentOrderIcon, getTranslated('current_orders', context)!, 1, myProvider,
                //     () {
                //   updateLocation();
                //   myProvider.updateIndex(1);
                // }),
                customBottomNavigationBar(
                    AppImages.allOrderIcon, getTranslated('all_orders', context)!, 1, myProvider, () {
                      updateLocation();
                  myProvider.updateIndex(1);
                }),
                customBottomNavigationBar(
                    AppImages.earningIcon, getTranslated('earning', context)!, 2, myProvider, () {
                      updateLocation();
                  myProvider.updateIndex(2);
                }),
                customBottomNavigationBar(
                    AppImages.profileIcon, getTranslated('profile', context)!, 3, myProvider, () {
                      updateLocation();
                  myProvider.updateIndex(3);
                }),
              ],
            ),
          ),
        ),
      );
    });
  }

  customBottomNavigationBar(String img, String title, int index,
      DashboardProvider provider, Function() onTap) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          color: AppColor.blueColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                height: 20,
                width: 20,
                color: provider.currentIndex == index
                    ? AppColor.whiteColor
                    : const Color(0xffB8B8B8),
              ),
              ScreenSize.height(6),
              Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                  fontSize: 11,
                  fontFamily: FontFamily.poppinsMedium,
                  color: provider.currentIndex == index
                      ? AppColor.whiteColor
                      : const Color(0xffB8B8B8),
                  fontWeight: FontWeight.w400))
            ],
          ),
        ),
      ),
    );
  }
}
