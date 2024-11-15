// ignore_for_file: prefer_const_constructors

import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/view_order_details_provider.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/enum.dart';
import 'package:cn_delivery/utils/location_service.dart';
import 'package:cn_delivery/utils/map_utils.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/change_status_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ViewOrderDetailsScreen extends StatefulWidget {
  final String orderId;
  ViewOrderDetailsScreen({super.key, required this.orderId});

  @override
  State<ViewOrderDetailsScreen> createState() => _ViewOrderDetailsScreenState();
}

class _ViewOrderDetailsScreenState extends State<ViewOrderDetailsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    loadCustomMarker();
    callInitFunction();
    callLocation();
    super.initState();
  }

  Uint8List? customerMarker;
  Uint8List? storeMarker;
  Uint8List? deliveryMarker;

  void loadCustomMarker() async {
    customerMarker =
        await Utils.getBytesFromAsset(AppImages.customerMarkerIcon, 120);
    storeMarker = await Utils.getBytesFromAsset(AppImages.homeMarkerIcon, 120);
    deliveryMarker =
        await Utils.getBytesFromAsset(AppImages.bicycleMarkerIcon, 120);
  }

  callInitFunction() {
    final provider =
        Provider.of<ViewOrderDetailsProvider>(context, listen: false);
    provider.clearValues();
    Future.delayed(Duration.zero, () {
      provider.orderDetailsApiFunction(widget.orderId);
    });
  }

  Timer? timer;
  bool isForground = true;

  updateAppStatus(value) {
    isForground = value;
    print(isForground);
    setState(() {});
  }

  callLocation() {
    final provider =
        Provider.of<ViewOrderDetailsProvider>(context, listen: false);

    provider.currentLocation = LatLng(
        double.parse(SessionManager.lat), double.parse(SessionManager.lng));
    timer = Timer.periodic(const Duration(seconds: 3), (val) {
      print('every 3 sec');
      provider.updateDistancePickup(); //// calculate the distance
      provider.updateDistanceDrop(); //// calculate the distance
      if (provider.polylineCoordinates.isNotEmpty) {
        print('yes i am updated');
        provider.polylineCoordinates.clear();
        LocationService.getCurrentLocation();
        provider.currentLocation = LatLng(
            double.parse(SessionManager.lat), double.parse(SessionManager.lng));
        if (isForground) {
          print('yes i am created');
          provider.getPolyPoints();
        }
      }
    });
  }

  final Completer<GoogleMapController> controller = Completer();

  @override
  void dispose() {
    timer!.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.paused:
        print('pause');
        timer!.cancel();
        updateAppStatus(false);
        break;
      case AppLifecycleState.resumed:
        callLocation();
        updateAppStatus(true);
        // callLocation();
        break;
      case AppLifecycleState.detached:
        print('pause');
        break;
      case AppLifecycleState.hidden:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewOrderDetailsProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.4,
                  child: myProvider.storeLocation != null &&
                          myProvider.deliveryLocation != null
                      ? GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: myProvider.currentLocation!,
                            zoom: 15,
                          ),
                          scrollGesturesEnabled: true, // Enable scrolling
                          zoomGesturesEnabled: true, // Enable zooming
                          markers: {
                            myProvider.model!.orderStatus
                                            .toString()
                                            .toLowerCase() ==
                                        OrderStatusTypes
                                            .order_picked_up_by_delivery_person
                                            .name ||
                                    myProvider.model!.orderStatus
                                            .toString()
                                            .toLowerCase() ==
                                        OrderStatusTypes.delivered.name
                                ? Marker(
                                    markerId: MarkerId("Customer"),
                                    icon: customerMarker != null
                                        ? BitmapDescriptor.fromBytes(
                                            customerMarker!)
                                        : BitmapDescriptor.defaultMarker,
                                    infoWindow: InfoWindow(
                                      title: getTranslated(
                                          'delivery_location', context)!,
                                    ),
                                    position: myProvider.deliveryLocation!,
                                  )
                                : Marker(
                                    markerId: MarkerId("Store"),
                                    icon: storeMarker != null
                                        ? BitmapDescriptor.fromBytes(
                                            storeMarker!)
                                        : BitmapDescriptor.defaultMarker,
                                    infoWindow: InfoWindow(
                                      title: getTranslated(
                                          'pickup_location', context)!,
                                    ),
                                    position: myProvider.storeLocation!,
                                  ),
                            Marker(
                              markerId: MarkerId("You"),
                              icon: deliveryMarker != null
                                  ? BitmapDescriptor.fromBytes(deliveryMarker!)
                                  : BitmapDescriptor.defaultMarker,
                              infoWindow: InfoWindow(
                                title: getTranslated('your_location', context)!,
                              ),
                              position: myProvider.currentLocation!,
                            ),
                          },
                          onMapCreated: (mapController) {
                            myProvider.getPolyPoints();
                            controller.complete(mapController);
                          },
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId("route"),
                              points: myProvider.polylineCoordinates,
                              color: AppColor.greenColor,
                              width: 6,
                            ),
                          },
                        )
                      : Container(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        myProvider.model != null
                            ? orderDetailsWidget(myProvider)
                            : Container(),
                        ScreenSize.height(15),
                        myProvider.model != null
                            ? pickAndDeliveryInfo(myProvider)
                            : Container(),
                        ScreenSize.height(15),
                        myProvider.model != null
                            ? shopDetailsWidget(myProvider)
                            : Container(),
                        ScreenSize.height(15),
                        myProvider.model != null
                            ? orderSummaryWidget(myProvider)
                            : Container(),
                        ScreenSize.height(50),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 0 + 40,
              left: 0 + 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(navigatorKey.currentContext!);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 3),
                  child: Image.asset(
                    AppImages.arrowBackIcon,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: myProvider.model != null &&
                Constants.checkOrderStatus(myProvider.model!.orderStatus)
            ? Container(
                height: 70,
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
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
                child: changeStatusWidget(myProvider))
            : Container(
                height: 20,
              ),
      );
    });
  }

  changeStatusWidget(ViewOrderDetailsProvider myProvider) {
    return AppButton(
        title: Constants.orderStatusTitle(
            myProvider.model!.orderStatus.toString()),
        height: 50,
        elevation: 0,
        width: double.infinity,
        buttonColor: myProvider.model!.orderStatus.toString().toLowerCase() ==
                    OrderStatusTypes.delivery_person_assigned.name ||
                myProvider.model!.orderStatus.toString().toLowerCase() ==
                    OrderStatusTypes.processing.name
            ? AppColor.borderD9Color
            : AppColor.appTheme,
        onTap: () {
          if (myProvider.model!.orderStatus.toString().toLowerCase() ==
                  OrderStatusTypes.delivery_person_assigned.name ||
              myProvider.model!.orderStatus.toString().toLowerCase() ==
                  OrderStatusTypes.processing.name) {
          } else {
            openStatusBottomSheet(
                context: context,
                orderStatus: myProvider.model!.orderStatus.toString(),
                ontap: () {
                  Navigator.pop(context);
                  myProvider.updateStatusApiFunction(widget.orderId,
                      myProvider.changeStatus(myProvider.model!.orderStatus));
                });
          }
        }
        // delivered
        );
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
              title: getTranslated('pickup_delivery_info', context)!,
              size: 16,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
          Row(
            children: [
              const Spacer(),
              getText(
                  title:
                      '${getTranslated('order_no', context)!}. ${provider.model!.id.toString()}',
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
              customBtn(
                  provider.model!.orderStatus
                      .toString()
                      .capitalize()
                      .replaceAll('_', ' '),
                  () {}),
              ScreenSize.width(15),
              customBtn(
                  provider.model!.paymentMethod.toString() == 'cash_on_delivery'
                      ? "COD"
                      : provider.model!.paymentMethod.toString().replaceAll('_', ' '),
                  () {}),
            ],
          ),
          ScreenSize.height(16),
          customRowForPriceAndDistanceWidget(
              title: getTranslated('distancePickupAndDrop', context)!,
              subTitle: provider.model!.distance ?? ''),
          ScreenSize.height(10),
          customRowForPriceAndDistanceWidget(
              title: getTranslated('distance_pickup_and_you', context)!,
              subTitle: "${provider.totalDistanceCurrentAndPickup} KM"),
          ScreenSize.height(10),
          customRowForPriceAndDistanceWidget(
              title: getTranslated('distance_drop_and_you', context)!,
              subTitle: "${provider.totalDistanceCurrentAndDrop} KM"),
          ScreenSize.height(10),
          // customRowForPriceAndDistanceWidget(title:getTranslated('delivery_man_charges', context)!,
          //  subTitle:    provider.model!.deliverymanCharge ?? ''),
          //  ScreenSize.height(10),
          // customRowForPriceAndDistanceWidget(title:getTranslated('admin_commison', context)!,
          //  subTitle: '15%'),
          //  ScreenSize.height(10),
          // customRowForPriceAndDistanceWidget(title:getTranslated('total_delivery_man_amount', context)!,
          //  subTitle:provider.model!.deliverymanCharge!=null? (double.parse(provider.model!.deliverymanCharge.toString().split(' ')[0])*(15/100)).toString():'-'),
          // ScreenSize.height(16),
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
                      child: NetworkImagehelper(
                        img: provider.model!.customer!.image,
                        height: 40.0,
                        width: 40.0,
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

  customRowForPriceAndDistanceWidget(
      {required String title, required String subTitle}) {
    return Row(
      children: [
        Expanded(
          child: getText(
              title: "$title:",
              size: 13.5,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
        ),
        getText(
            title: subTitle,
            size: 13,
            fontFamily: FontFamily.poppinsRegular,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w400),
      ],
    );
  }

  shopDetailsWidget(ViewOrderDetailsProvider provider) {
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
      padding: const EdgeInsets.only(top: 17, bottom: 15, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: getTranslated('shop_details', context)!,
              size: 16,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
          ScreenSize.height(12),
          Row(
            children: [
              provider.model!.shop!.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: NetworkImagehelper(
                        img: provider.model!.shop!.image,
                        height: 60.0,
                        width: 60.0,
                      ))
                  : Image.asset(
                      'assets/images/profileImg.png',
                      height: 60,
                      width: 60,
                    ),
              ScreenSize.width(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: provider.model!.shop != null
                            ? "${provider.model!.shop!.name ?? ""}"
                            : '',
                        maxLies: 1,
                        size: 16,
                        fontFamily: FontFamily.poppinsMedium,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Image.asset(
                            AppImages.locationIcon,
                            height: 12,
                            width: 10,
                          ),
                        ),
                        ScreenSize.width(5),
                        Flexible(
                          child: getText(
                              title: provider.model!.shop != null
                                  ? "${provider.model!.shop!.address ?? ""}, ${provider.model!.shop!.city ?? ""}, ${provider.model!.shop!.country ?? ""}"
                                  : '',
                              maxLies: 2,
                              size: 13,
                              fontFamily: FontFamily.poppinsRegular,
                              color: Color(0xffB8B8B8),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          ScreenSize.height(12),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9).withOpacity(.4),
          ),
          ScreenSize.height(20),
          getText(
              title: getTranslated('mobile_number', context)!,
              size: 15,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          GestureDetector(
            onTap: () {
              provider.callNumber(
                  '+1${provider.model!.shop != null ? provider.model!.shop!.phone.toString() : ''}');
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/Phone.png',
                  width: 26,
                  height: 26,
                ),
                ScreenSize.width(10),
                getText(
                    title:
                        '+ - ${provider.model!.shop != null ? provider.model!.shop!.phone.toString() : ''}',
                    size: 14,
                    fontFamily: FontFamily.poppinsRegular,
                    color: Color(0xffB8B8B8),
                    fontWeight: FontWeight.w400)
              ],
            ),
          ),
          ScreenSize.height(20),
          getText(
              title: getTranslated('email_address', context)!,
              size: 15,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          GestureDetector(
            onTap: () {
              provider.model!.shop != null
                  ? provider.openMail(provider.model!.shop!.email.toString())
                  : null;
            },
            child: Row(
              children: [
                Image.asset(
                  AppImages.emailWithBackgroundIcon,
                  height: 26,
                  width: 26,
                ),
                ScreenSize.width(10),
                getText(
                    title: provider.model!.shop != null
                        ? provider.model!.shop!.email.toString()
                        : '',
                    size: 14,
                    fontFamily: FontFamily.poppinsRegular,
                    color: Color(0xffB8B8B8),
                    fontWeight: FontWeight.w400)
              ],
            ),
          )
        ],
      ),
    );
  }

  orderSummaryWidget(ViewOrderDetailsProvider provider) {
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: getTranslated('order_summary', context)!,
              size: 16,
              // maxLies: 1,
              fontFamily: FontFamily.poppinsSemiBold,
              color: Color(0xff2F2E36),
              fontWeight: FontWeight.w600),
          ScreenSize.height(15),
          customRowForPriceAndDistanceWidget(
              title: getTranslated('order_price', context)!,
              subTitle: '\$${provider.model!.orderAmount.toString()}'),
          ScreenSize.height(15),
          customRowForPriceAndDistanceWidget(
              title: getTranslated('delivery_fee', context)!,
              subTitle: provider.model!.deliverymanCharge != null &&
                      provider.model!.deliverymanCharge.toString().isNotEmpty
                  ? '\$${double.parse(provider.model!.deliverymanCharge.toString().split(' ')[0])}'
                  : '-'),
          ScreenSize.height(15),
          //  customRowForPriceAndDistanceWidget(title: 'Admin Comission', subTitle: systemFee.isEmpty?'-':"\$$systemFee"),
          //  ScreenSize.height(15),
          customRowForPriceAndDistanceWidget(
              title: getTranslated('grand_total', context)!,
              subTitle:
                  '\$${double.parse(provider.model!.orderAmount.toString()) + double.parse(provider.model!.deliverymanCharge.toString().split(' ')[0])}'),
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
      padding: const EdgeInsets.only(top: 1, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(
                //   child: getText(
                //       title: getTranslated('order_details', context)!,
                //       size: 16,
                //       // maxLies: 1,
                //       fontFamily: FontFamily.poppinsSemiBold,
                //       color: Color(0xff2F2E36),
                //       fontWeight: FontWeight.w600),
                // ),
                // ScreenSize.width(10),
                // Text.rich(TextSpan(
                //     text: '${getTranslated('total_amount', context)!} : ',
                //     style: const TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w400,
                //         fontFamily: FontFamily.poppinsRegular,
                //         color: AppColor.lightTextColor),
                //     children: [
                //       TextSpan(
                //         text: '\$${provider.model!.orderAmount.toString()}',
                //         style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.w400,
                //             fontFamily: FontFamily.poppinsSemiBold,
                //             color: AppColor.blackColor),
                //       )
                //     ]))
              ],
            ),
          ),
          // ScreenSize.height(12),
          // Container(
          //   height: 1,
          //   color: const Color(0xffD9D9D9),
          // ),
          provider.model!.product != null
              ? Container(
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
                )
              : Container(),
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
                  : NetworkImagehelper(
                      img: model.image,
                      height: 60.0,
                      width: 66.0,
                    )),
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
                    text: '${getTranslated('value', context)!} : ',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.lightTextColor),
                    children: [
                      TextSpan(
                        text: '${model.price} COP',
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
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "${provider.model!.pickUp!.city}, ${provider.model!.pickUp!.country}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: FontFamily.poppinsRegular,
                          color: const Color(0xffB8B8B8),
                          fontWeight: FontWeight.w400),
                    )),
                    provider.pickupLat != 0.0
                        ? customBtn(getTranslated('open_map', context)!, () {
                            MapUtils.openMap(
                                provider.pickupLat, provider.pickupLng);
                          })
                        : Container(),
                  ],
                ),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${provider.model!.shippingAddress!.city}, ${provider.model!.shippingAddress!.country}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: FontFamily.poppinsRegular,
                            color: const Color(0xffB8B8B8),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    provider.shippingLat != 0.0
                        ? customBtn(getTranslated('open_map', context)!, () {
                            MapUtils.openMap(
                                provider.shippingLat, provider.shippingLng);
                          })
                        : Container()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  customBtn(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: title.toUpperCase() ==
                        getTranslated('delivered', context)!.toUpperCase() ||
                    title == getTranslated('open_map', context)!
                ? AppColor.greenColor.withOpacity(.3)
                : const Color(0xffC4D9ED)),
        alignment: Alignment.center,
        child: getText(
            title: title,
            size: 12,
            fontFamily: FontFamily.poppinsRegular,
            color: title.toUpperCase() ==
                        getTranslated('delivered', context)!.toUpperCase() ||
                    title == getTranslated('open_map', context)!
                ? AppColor.greenColor
                : const Color(0xff0790FF),
            maxLies: 1,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
