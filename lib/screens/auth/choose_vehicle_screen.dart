import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/screens/auth/vechile_info_screen.dart';
import 'package:cn_delivery/utils/enum.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ChooseVehicleScreen extends StatefulWidget {
  const ChooseVehicleScreen({super.key});

  @override
  State<ChooseVehicleScreen> createState() => _ChooseVehicleScreenState();
}

class _ChooseVehicleScreenState extends State<ChooseVehicleScreen> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.appIcon,
                  // height: 80,
                  width: 165,
                  fit: BoxFit.cover,
                ),
              ),
              ScreenSize.height(30),
              getText(
                  title: 'Choose your vehicle',
                  size: 23,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w600),
              ScreenSize.height(20),
              vehicleTypeWidget('Bicycle', 0),
              ScreenSize.height(20),
              vehicleTypeWidget('Motorcycle', 1),
              ScreenSize.height(20),
              vehicleTypeWidget('Car', 2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: AppButton(
            title: getTranslated('continue', context)!,
            height: 56,
            width: double.infinity,
            buttonColor: AppColor.appTheme,
            onTap: () {
              if (selectedIndex != -1) {
                AppRoutes.pushCupertinoNavigation(VechileInfoScreen(
                  route: selectedIndex == 0
                      ? VehicleType.bicycle.name
                      : selectedIndex == 1
                          ? VehicleType.bike.name
                          : VehicleType.car.name,
                ));
              } else {
                Utils.showToast('Select your vehicle');
              }
            }),
      ),
    );
  }

  vehicleTypeWidget(String title, index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        color: AppColor.lightPinkColor,
        child: Container(
          width: double.infinity,
          color: selectedIndex == index
              ? AppColor.lightPinkColor.withOpacity(.08)
              : AppColor.lightTextColor.withOpacity(.08),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
          child: getText(
              title: title,
              size: 20,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blueColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
