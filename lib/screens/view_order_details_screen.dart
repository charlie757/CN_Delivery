import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/model/view_order_model.dart';
import 'package:cn_delivery/provider/view_order_details_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/provider/current_order_provider.dart';
import 'package:cn_delivery/screens/track_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class ViewOrderDetailsScreen extends StatefulWidget {
  final String orderId;
  ViewOrderDetailsScreen({super.key, required this.orderId});

  @override
  State<ViewOrderDetailsScreen> createState() => _ViewOrderDetailsScreenState();
}

class _ViewOrderDetailsScreenState extends State<ViewOrderDetailsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider =
        Provider.of<ViewOrderDetailsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      provider.callApiFunction(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewOrderDetailsProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const TrackOrderScreen()));
                },
                child: Container(
                  height: 300,
                  child:
                      // GoogleMap(
                      //   onMapCreated: _onMapCreated,
                      //   initialCameraPosition: CameraPosition(
                      //     target: _center,
                      //     zoom: 11.0,
                      //   ),
                      // ),
                      Image.asset(
                    'assets/images/mapImg.png',
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              myProvider.model != null
                  ? pickAndDeliveryInfo(myProvider)
                  : Container(),
              ScreenSize.height(15),
              myProvider.model != null
                  ? orderDetailsWidget(myProvider)
                  : Container(),
              ScreenSize.height(50),
            ],
          ),
        ),
        bottomNavigationBar: myProvider.model != null &&
                (myProvider.model!.orderStatus == 'pending' ||
                    myProvider.model!.orderStatus == 'out_for_delivery')
            ? Container(
                height: 70,
                padding: const EdgeInsets.only(
                    left: 60, right: 60, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          10,
                        ),
                        topRight: Radius.circular(10)),
                    color: AppColor.whiteColor,
                    border: Border.all(color: const Color(0xffF5F5F5)),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 2),
                          color: AppColor.blackColor.withOpacity(.2),
                          blurRadius: 3)
                    ]),
                width: double.infinity,
                child: AppButton(
                    title: myProvider.model!.orderStatus == 'pending'
                        ? 'Out for delivery'
                        : myProvider.model!.orderStatus == 'out_for_delivery'
                            ? 'Delivered'
                            : '',
                    height: 50,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                    onTap: () {
                      myProvider.model!.orderStatus == 'pending'
                          ? myProvider.updateStatusApiFunction(
                              widget.orderId, 'out_for_delivery')
                          : myProvider.model!.orderStatus == 'out_for_delivery'
                              ? myProvider.updateStatusApiFunction(
                                  widget.orderId, 'delivered')
                              : null;
                    }),
              )
            : Container(
                height: 20,
              ),
      );
    });
  }

  pickAndDeliveryInfo(ViewOrderDetailsProvider provider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
      padding: const EdgeInsets.only(left: 15, right: 15, top: 17, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: 'Pickup and Deliver Info',
              size: 16,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
          Row(
            children: [
              const Spacer(),
              getText(
                  title: 'Order No. ${provider.model!.id.toString()}',
                  size: 13,
                  fontFamily: FontFamily.poppinsRegular,
                  color: const Color(0xffB8B8B8),
                  fontWeight: FontWeight.w400),
              ScreenSize.width(4),
              const Icon(
                Icons.more_vert,
                size: 19,
                color: Color(0xffB8B8B8),
              )
            ],
          ),
          ScreenSize.height(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customBtn(provider.model!.orderStatus.toString()),
              customBtn(provider.model!.paymentMethod.toString()),
            ],
          ),
          ScreenSize.height(16),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          ScreenSize.height(16),
          locationWidget(provider),
          ScreenSize.height(16),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          ScreenSize.height(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              provider.model!.customer!.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        provider.model!.customer!.image,
                        height: 40,
                        width: 40,
                        fit: BoxFit.fill,
                      ))
                  : Image.asset(
                      'assets/images/profileImg.png',
                      height: 40,
                      width: 40,
                    ),
              ScreenSize.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.model!.customer != null
                          ? "${provider.model!.customer!.fName ?? ""} ${provider.model!.customer!.lName ?? ""}"
                          : '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15,
                          fontFamily: FontFamily.poppinsRegular,
                          color: Color(0xff2F2E36),
                          fontWeight: FontWeight.w400),
                    ),
                    getText(
                        title:
                            '+1 - ${provider.model!.customer != null ? provider.model!.customer!.phone.toString() : ''}',
                        size: 15,
                        fontFamily: FontFamily.poppinsRegular,
                        color: const Color(0xff2F2E36),
                        fontWeight: FontWeight.w400),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.callNumber(
                      '+1${provider.model!.customer != null ? provider.model!.customer!.phone.toString() : ''}');
                },
                child: Image.asset(
                  'assets/icons/Phone.png',
                  width: 40,
                  height: 40,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  orderDetailsWidget(ViewOrderDetailsProvider provider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
      padding: const EdgeInsets.only(top: 17, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 15),
            child: Row(
              children: [
                const getText(
                    title: 'Order Details',
                    size: 16,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: Color(0xff2F2E36),
                    fontWeight: FontWeight.w600),
                const Spacer(),
                Text.rich(TextSpan(
                    text: 'Total Amount : ',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.lightTextColor),
                    children: [
                      TextSpan(
                        text: '\$${provider.model!.orderAmount.toString()}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.blackColor),
                      )
                    ]))
              ],
            ),
          ),
          ScreenSize.height(12),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9),
          ),
          Container(
            // color: Colors.red,
            alignment: Alignment.topCenter,
            child: ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, sp) {
                  return Container(
                    height: 1,
                    color: const Color(0xffD9D9D9),
                  );
                },
                itemCount: provider.model!.product!.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  var model = provider.model!.product![index];
                  return orderWidget(model);
                }),
          ),
        ],
      ),
    );
  }

  orderWidget(model) {
    return Container(
      margin: const EdgeInsets.only(top: 25, bottom: 24),
      padding: const EdgeInsets.only(left: 16, right: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: model.image.isEmpty
                ? Container()
                : Image.network(
                    model.image,
                    height: 60,
                    width: 66,
                    fit: BoxFit.fill,
                  ),
          ),
          ScreenSize.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: Color(0xff2F2E36),
                      fontWeight: FontWeight.w600),
                ),
                ScreenSize.height(2),
                Text.rich(TextSpan(
                    text: 'Value : ',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.lightTextColor),
                    children: [
                      TextSpan(
                        text: '${model.price} USD',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: Color(0xff0790FF)),
                      )
                    ]))
              ],
            ),
          )
        ],
      ),
    );
  }

  locationWidget(ViewOrderDetailsProvider provider) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffD9D9D9), width: 2),
                    shape: BoxShape.circle),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  height: 3,
                  width: 3,
                  decoration: BoxDecoration(
                      color: AppColor.blueColor, shape: BoxShape.circle),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 2, bottom: 2),
                  height: 60,
                  child: const VerticalDivider()),
              Image.asset(
                'assets/icons/location.png',
                height: 16,
                width: 16,
              ),
            ],
          ),
          ScreenSize.width(7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.model!.pickUp!.address.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: FontFamily.poppinsRegular,
                      color: Color(0xff2F2E36),
                      fontWeight: FontWeight.w400),
                ),
                ScreenSize.height(0),
                getText(
                    title:
                        "${provider.model!.pickUp!.city}, ${provider.model!.pickUp!.country}",
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: const Color(0xffB8B8B8),
                    fontWeight: FontWeight.w400),
                ScreenSize.height(30),
                Text(
                  provider.model!.shippingAddress!.address.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: FontFamily.poppinsRegular,
                      color: Color(0xff2F2E36),
                      fontWeight: FontWeight.w400),
                ),
                ScreenSize.height(0),
                getText(
                    title:
                        "${provider.model!.shippingAddress!.city}, ${provider.model!.shippingAddress!.country}",
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: const Color(0xffB8B8B8),
                    fontWeight: FontWeight.w400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  customBtn(
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xffC4D9ED)),
      alignment: Alignment.center,
      child: getText(
          title: title,
          size: 12,
          fontFamily: FontFamily.poppinsRegular,
          color: const Color(0xff0790FF),
          fontWeight: FontWeight.w400),
    );
  }
}
