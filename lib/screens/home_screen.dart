import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/provider/home_provider.dart';
import 'package:cn_delivery/screens/view_order_details_screen.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    callInitFunction();
    // TODO: implement initState
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<HomeProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      myProvider.callApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: appBar(title: 'Dashboard', isNotification: true),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 40, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    onGoingCompletedWidget(
                        AppColor.blueColor,
                        AppImages.onGoingIcon,
                        'On Going',
                        myProvider.homeModel != null &&
                                myProvider.homeModel!.data != null
                            ? myProvider.homeModel!.data!.totalCurrentOrders
                                .toString()
                            : '0'),
                    ScreenSize.width(15),
                    onGoingCompletedWidget(
                        AppColor.lightPinkColor,
                        AppImages.completedIcon,
                        'Completed',
                        myProvider.homeModel != null &&
                                myProvider.homeModel!.data != null
                            ? myProvider.homeModel!.data!.totalDeliveredOrders
                                .toString()
                            : '0'),
                  ],
                ),
                ScreenSize.height(23),
                totalOrdersWidget(myProvider),
                ScreenSize.height(23),
                getText(
                    title: 'Upcoming Orders',
                    size: 22,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
                ScreenSize.height(22),
                upcomingOrdersWidget(myProvider),
              ],
            ),
          ),
        ),
      );
    });
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

  totalOrdersWidget(HomeProvider provider) {
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
              title:
                  provider.homeModel != null && provider.homeModel!.data != null
                      ? provider.homeModel!.data!.totalOrders.toString()
                      : '0',
              size: 30,
              fontFamily: FontFamily.poppinsSemiBold,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w700)
        ],
      ),
    );
  }

  upcomingOrdersWidget(HomeProvider provider) {
    return provider.homeModel != null &&
            provider.homeModel!.data != null &&
            provider.homeModel!.data!.currentOrdersList!.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(20);
            },
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: provider.homeModel!.data!.currentOrdersList!.length,
            itemBuilder: (context, index) {
              var model = provider.homeModel!.data!.currentOrdersList![index];
              return orderUi(model, provider);
            })
        : Container();
    // Center(
    //     child: getText(
    //         title: 'No orders found',
    //         size: 16,
    //         fontFamily: FontFamily.poppinsRegular,
    //         color: AppColor.blackColor,
    //         fontWeight: FontWeight.w400),
    //   );
  }

  orderUi(model, HomeProvider provider) {
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
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: getText(
                title: model.orderDate.toString(),
                size: 12,
                fontFamily: FontFamily.poppinsRegular,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w400),
          ),
          ScreenSize.height(1),
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: model.product![0].image.isEmpty
                      ? Container()
                      : NetworkImagehelper(
                          img: model.product![0].image,
                          height: 60.0,
                          width: 66.0,
                        )),
              ScreenSize.width(12),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product![0].title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.poppinsMedium,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text.rich(TextSpan(
                      text: 'Qty: ',
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.poppinsRegular),
                      children: [
                        TextSpan(
                            text: model.product![0].qty.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blackColor,
                                fontFamily: FontFamily.poppinsRegular))
                      ])),
                  Text.rich(TextSpan(
                      text: 'Price: ',
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.poppinsRegular),
                      children: [
                        TextSpan(
                            text: model.product![0].price.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blackColor,
                                fontFamily: FontFamily.poppinsRegular))
                      ])),
                ],
              ))
            ],
          ),
          ScreenSize.height(2),
          Align(
            alignment: Alignment.centerRight,
            child: viewOrderDetailsButton(model.id.toString(), provider),
          ),
          ScreenSize.height(8),
          Row(
            children: [
              getText(
                  title: 'Total Order Value: ',
                  size: 13,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor.withOpacity(.5),
                  fontWeight: FontWeight.w400),
              getText(
                  title: '${model.orderAmount.toString()} COP',
                  size: 14,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400),
            ],
          ),
          ScreenSize.height(4),
          Row(
            children: [
              getText(
                  title: 'Payment Method: ',
                  size: 13,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor.withOpacity(.5),
                  fontWeight: FontWeight.w400),
              Flexible(
                child: Text(
                  model.paymentMethod.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  viewOrderDetailsButton(String id, HomeProvider provider) {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(ViewOrderDetailsScreen(
          orderId: id.toString(),
        )).then((value) {});
      },
      child: Container(
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
      ),
    );
  }
}
