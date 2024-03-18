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
          padding: const EdgeInsets.only(top: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/dashboard1.png'),
              ScreenSize.height(23),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: getText(
                    title: 'Upcoming Orders',
                    size: 22,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
              ),
              ScreenSize.height(22),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Image.asset('assets/images/Group 7.png'),
              ),
              ScreenSize.height(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Image.asset('assets/images/Group 12.png'),
              ),
              ScreenSize.height(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Image.asset('assets/images/Group 13.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
