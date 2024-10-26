import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/home_provider.dart';
import 'package:cn_delivery/screens/view_order_details_screen.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/btn_widget.dart';
import 'package:cn_delivery/widget/dialog_box.dart';
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
      myProvider.upcomingOrderApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: appBar(
            title: getTranslated('dashboard', context)!, isNotification: true),
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
                        getTranslated('on_going', context)!,
                        myProvider.homeModel != null &&
                                myProvider.homeModel!.data != null
                            ? myProvider.homeModel!.data!.totalCurrentOrders
                                .toString()
                            : '0'),
                    ScreenSize.width(15),
                    onGoingCompletedWidget(
                        AppColor.lightPinkColor,
                        AppImages.completedIcon,
                        getTranslated('completed', context)!,
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
                    title: getTranslated('upcoming_orders', context)!,
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
                  title: getTranslated('total_orders', context)!,
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
    return provider.upcomingOrderModel != null &&
            provider.upcomingOrderModel!.data != null &&
            provider.upcomingOrderModel!.data!.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(20);
            },
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: provider.upcomingOrderModel!.data!.length,
            itemBuilder: (context, index) {
              return orderUi(index, provider);
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

  orderUi(int index, HomeProvider provider) {
    
    var model = provider.upcomingOrderModel!.data![index];
    return GestureDetector(
      onTap: (){
              AppRoutes.pushCupertinoNavigation(ViewOrderDetailsScreen(
          orderId: model.id.toString(),
        )).then((value) {});
      },
      child: Container(
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
            model.product!=null?
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child:model.product!=null&& model.product![0].image.isEmpty
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
                        text: '${getTranslated('qty', context)!}: ',
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
                        text: '${getTranslated('price', context)!}: ',
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
            ):Container(),
            ScreenSize.height(2),
            // Align(
          //     alignment: Alignment.centerRight,
          //     child: viewOrderDetailsButton(title: getTranslated('view_order_details', context)!,
          //     width: 143.0,
          //      onTap: (){
          //       AppRoutes.pushCupertinoNavigation(ViewOrderDetailsScreen(
          //   orderId: model.id.toString(),
          // )).then((value) {});
          //      }),
          //   ),
            ScreenSize.height(8),
            Row(
              children: [
                getText(
                    title: '${getTranslated('total_order_values', context)!}: ',
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
                    title: '${getTranslated('payment_method', context)!}: ',
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor.withOpacity(.5),
                    fontWeight: FontWeight.w400),
                Flexible(
                  child: Text(
                    model.paymentMethod.toString()=='cash_on_delivery'?"COD":model.paymentMethod.toString(),
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
            ScreenSize.height(12),
            Row(
              children: [
                Expanded(child: btn(title: getTranslated('reject', context)!,
                color: AppColor.rejectColor,
                onTap: (){
                  openDialogBox( title: getTranslated('reject', context)!,
                   subTitle: getTranslated('confirmation_reject_order', context)!, noTap: (){
                    Navigator.pop(context);
                   }, yesTap: (){
                    Navigator.pop(context);
                    provider.rejectOrderApiFunction(model.id.toString());
                   });
                }),),
                ScreenSize.width(15),
                Expanded(child: btn(title: getTranslated('accept', context)!,
                color: AppColor.appTheme,
                onTap: (){
                  openDialogBox( title: getTranslated('accept', context)!,
                   subTitle: getTranslated('confirmation_accept_order', context)!, noTap: (){
                    Navigator.pop(context);
                   }, yesTap: (){
                       Navigator.pop(context);
                    provider.acceptOrderApiFunction(model.id.toString());
                   });
                }),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
