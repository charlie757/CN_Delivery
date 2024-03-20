import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBar('Track Order',(){
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 23, left: 15, right: 15,bottom: 40),
          child:  Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [orderWidget(), trackWidget(),
            ScreenSize.height(50),
            AppButton(title: 'TRACK DRIVER', 
            height: 49, width: double.infinity, buttonColor: AppColor.appTheme, onTap: (){})
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
                  title: '135876',
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
    return Container(
      width: double.infinity,
      padding:const EdgeInsets.only(left: 100),
      alignment: Alignment.center,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 2,),
                    height: 40,
                    child: const VerticalDivider(
                      thickness: 4,
                      color: Color(0xffDADADA),
                    )),
                Container(
                  height: 25,
                  width: 25,
                  decoration:const BoxDecoration(shape: BoxShape.circle,
                  color: Color(0xff1455AC)
                  ),
                ),
                Container(
                    height: 80,
                    child: const VerticalDivider(
                      thickness: 4,
                      color: Color(0xffDADADA),
                    )),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                  // color: Color(0xff1455AC)
                  border: Border.all(color:const Color(0xffDADADA),width: 2)
                  ),
                ),
                Container(
                    height: 80,
                    child: const VerticalDivider(
                      thickness: 4,
                      color: Color(0xffDADADA),
                    )),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                  border: Border.all(color:const Color(0xffDADADA),width: 2)
                  ),
                ),
              ],
            ),
            ScreenSize.width(8),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(title: 'Going to Delivery',
                   size: 18, fontFamily: FontFamily.nunitoRegular, 
                   color: AppColor.blackColor, fontWeight: FontWeight.w300),
                const Padding(
                   padding:  EdgeInsets.only(top: 80),
                   child:  getText(title: 'Delivery',
                     size: 18, fontFamily: FontFamily.nunitoRegular, 
                     color: Color(0xff868686), fontWeight: FontWeight.w300),
                 ),
                 const Padding(
                   padding:  EdgeInsets.only(top: 75),
                   child:  getText(title: 'Completed\n& Payment Received',
                     size: 18, fontFamily: FontFamily.nunitoRegular, 
                     color: Color(0xff868686), fontWeight: FontWeight.w300),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
