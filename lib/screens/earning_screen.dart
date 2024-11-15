import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/earn_provider.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<EarnProvider>(context, listen: false);
    myProvider.getEarnApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EarnProvider>(builder: (context, myProvider, child) {
      return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: appBar(title: getTranslated('earnings', context)!),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                      color: AppColor.blackColor.withOpacity(.1))
                ]),
            padding: const EdgeInsets.only(top: 23, left: 23, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppImages.totalEarningIcon,
                      width: 44.43,
                      height: 43,
                    ),
                    ScreenSize.width(16),
                    getText(
                        title: getTranslated('total_earnings', context)!,
                        size: 16,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w600)
                  ],
                ),
                ScreenSize.height(19),
                getText(
                    title:
                        '\$ ${myProvider.earnModel != null && myProvider.earnModel!.data != null ? myProvider.earnModel!.data!.totalEarn ?? '0' : '0'}',
                    size: 30,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w700)
              ],
            ),
          ));
    });
  }
}
