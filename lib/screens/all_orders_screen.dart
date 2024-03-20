import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  List orderList = [
    {
      'img': 'assets/images/order1.png',
      'progress': 'In Progress',
    },
    {
      'img': 'assets/images/order2.png',
      'progress': 'Canceled',
    },
    {
      'img': 'assets/images/order3.png',
      'progress': 'Completed',
    },
    {
      'img': 'assets/images/order4.png',
      'progress': 'In Progress',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBar('All Orders', () {}),
      body: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(15);
          },
          itemCount: orderList.length,
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 40, top: 20),
          itemBuilder: (context, index) {
            return orderWidget(
                orderList[index]['img'], orderList[index]['progress']);
          }),
    );
  }

  orderWidget(img, status) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffF5F5F5)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                color: AppColor.blackColor.withOpacity(.2))
          ]),
      padding: const EdgeInsets.only(top: 15, left: 17, right: 15, bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: getText(
                title: '15-Mar-2020 - 13.48.15',
                size: 12,
                fontFamily: FontFamily.poppinsRegular,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w400),
          ),
          ScreenSize.height(1),
          Row(
            children: [
              Image.asset(
                img,
                height: 50,
                width: 56,
              ),
              ScreenSize.width(12),
              Expanded(
                  child: Text(
                'New Mini Mart',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
              )),
              ScreenSize.width(2),
              orderButton(
                  status,
                  status == 'Canceled'
                      ? const Color(0xff6E6E96)
                      : status == 'Completed'
                          ? const Color(0xffFE70D8)
                          : const Color(0xffFE70D8)),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: viewOrderDetailsButton(),
          ),
          ScreenSize.height(4),
          Text.rich(TextSpan(
              text: 'Total Order Value: ',
              style: TextStyle(
                  color: AppColor.blackColor.withOpacity(.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppinsRegular),
              children: [
                TextSpan(
                    text: '200 USD',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColor.blackColor,
                        fontFamily: FontFamily.poppinsSemiBold))
              ])),
          ScreenSize.height(2),
          Text.rich(TextSpan(
              text: 'Payment Method: ',
              style: TextStyle(
                  color: AppColor.blackColor.withOpacity(.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppinsRegular),
              children: [
                TextSpan(
                    text: 'COD',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColor.blackColor,
                        fontFamily: FontFamily.poppinsSemiBold))
              ]))
        ],
      ),
    );
  }

  orderButton(String title, Color color) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 16, right: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.5),
      ),
      child: getText(
          title: title,
          size: 13,
          fontFamily: FontFamily.poppinsRegular,
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w400),
    );
  }

  viewOrderDetailsButton() {
    return Container(
      height: 32,
      width: 143,
      // padding: const EdgeInsets.only(left: 16, right: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff5DBCF2),
        borderRadius: BorderRadius.circular(16.5),
      ),
      child: getText(
          title: 'View Order Details',
          size: 13,
          fontFamily: FontFamily.poppinsRegular,
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w400),
    );
  }
}
