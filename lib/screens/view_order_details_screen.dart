// ignore_for_file: prefer_const_constructors

import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/view_order_details_provider.dart';
import 'package:cn_delivery/utils/location_service.dart';
import 'package:cn_delivery/utils/map_utils.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/dialog_box.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class ViewOrderDetailsScreen extends StatefulWidget {
  final String orderId;
  ViewOrderDetailsScreen({super.key, required this.orderId});

  @override
  State<ViewOrderDetailsScreen> createState() => _ViewOrderDetailsScreenState();
}

class _ViewOrderDetailsScreenState extends State<ViewOrderDetailsScreen> {
  @override
  void initState() {
    loadCustomMarker();
    callInitFunction();
    callLocation();
    super.initState();
  }
  
  Uint8List? customerMarker;
  Uint8List? storeMarker;
  Uint8List? deliveryMarker;

 void loadCustomMarker() async {
    customerMarker = await Utils.getBytesFromAsset(AppImages.customerMarkerIcon, 120);
    storeMarker = await Utils.getBytesFromAsset(AppImages.homeMarkerIcon, 120);
    deliveryMarker = await Utils.getBytesFromAsset(AppImages.bicycleMarkerIcon, 120);
  }
  callInitFunction() {
    final provider =
        Provider.of<ViewOrderDetailsProvider>(context, listen: false);
    provider.clearValues();
    provider.model = null;
    Future.delayed(Duration.zero, () {
      provider.orderDetailsApiFunction(widget.orderId);
      // provider.getPolyPoints();
    });
  }
Timer? timer;
  callLocation(){
     final provider =
        Provider.of<ViewOrderDetailsProvider>(context, listen: false);
         provider.currentLocation = LatLng(double.parse(SessionManager.lat),  double.parse(SessionManager.lng));
        //  provider.storeLocation = LatLng( 26.959749661137145,  75.77617763736208);
      timer= Timer.periodic(const Duration(seconds: 3), (val){
        print('sfdsvdfdfvfd');
        if(provider.polylineCoordinates.isNotEmpty){
          print('yes i am updated');
          provider.polylineCoordinates.clear();
          LocationService.getCurrentLocation();
          provider.currentLocation = LatLng(double.parse(SessionManager.lat),  double.parse(SessionManager.lng));
         provider.getPolyPoints();     
        }
        // if(provider.storeLocation!=null&&provider.deliveryLocation!=null){
        //   provider.currentLocation = LatLng(double.parse(SessionManager.lat),  double.parse(SessionManager.lng));
        //  provider.getPolyPoints();
        
        // }
    });
   
}

  final Completer<GoogleMapController> controller = Completer();

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
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
                  child: myProvider.storeLocation != null&&myProvider.deliveryLocation!=null
                      ? GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: myProvider.storeLocation !,
                            zoom: 13.5,
                          ),
                          scrollGesturesEnabled: true, // Enable scrolling
                          zoomGesturesEnabled: true, // Enable zooming
                          markers: {
                             myProvider.model!.orderStatus.toString().toLowerCase()=='accepted'||
                             myProvider.model!.orderStatus.toString().toLowerCase()=='out_for_pickup'?
                            Marker(
                              markerId: MarkerId("Store"),
                              icon: storeMarker!=null? BitmapDescriptor.fromBytes(storeMarker!) : BitmapDescriptor.defaultMarker,
                              infoWindow: InfoWindow(
                                title: getTranslated('pickup_location', context)!,
                              ),
                              position: myProvider.storeLocation!,
                            )
                            : Marker(
                              markerId: MarkerId("Customer"),
                              icon: customerMarker!=null? BitmapDescriptor.fromBytes(customerMarker!) : BitmapDescriptor.defaultMarker,
                              infoWindow: InfoWindow(
                                title: getTranslated('delivery_location', context)!,
                              ),
                              position: myProvider.deliveryLocation!,
                            ),
                            Marker(
                              markerId: MarkerId("You"),
                              icon: deliveryMarker!=null? BitmapDescriptor.fromBytes(deliveryMarker!) : BitmapDescriptor.defaultMarker,
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
                    child: Column(
                      children: [
                        myProvider.model != null
                            ? pickAndDeliveryInfo(myProvider)
                            : Container(),
                        ScreenSize.height(15),
                        myProvider.model != null
                            ? shopDetailsWidget(myProvider)
                            : Container(),
                        ScreenSize.height(15),
                        myProvider.model != null
                            ? orderDetailsWidget(myProvider)
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
                myProvider.model!.orderStatus!='pending'
                // (myProvider.model!.orderStatus == getTranslated('pending', context)! ||
                //     myProvider.model!.orderStatus == getTranslated('out_for_delivery', context)! )
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
                    title:myProvider.statusTitle(myProvider.model!.orderStatus),
                    // myProvider.model!.orderStatus == getTranslated('pending', context)!
                    //     ? getTranslated('outForDelivery', context)!
                    //     : myProvider.model!.orderStatus == getTranslated('out_for_delivery', context)!
                    //     ? 'Delivered'
                    //         : '',
                    height: 50,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                    onTap: () {
                      if(myProvider.model!.orderStatus!='delivered'){
                      openDialogBox(title: myProvider.statusTitle(myProvider.model!.orderStatus), subTitle: getTranslated('are_you_sure_change_status', context)!,
                      noTap: (){
                        Navigator.pop(context);
                      }, yesTap: (){
                        Navigator.pop(context);
                         myProvider.updateStatusApiFunction(
                                  widget.orderId, myProvider.changeStatus(myProvider.model!.orderStatus));
                      });
                      }
                    }),
                    // delivered
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
              title: getTranslated('pickup_delivery_info', context)!,
              size: 16,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
          Row(
            children: [
              const Spacer(),
              getText(
                  title: '${getTranslated('order_no', context)!}. ${provider.model!.id.toString()}',
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
              customBtn(provider.model!.orderStatus.toString(), () {}),
              customBtn(provider.model!.paymentMethod.toString(), () {}),
            ],
          ),
          ScreenSize.height(16),
          customRowForPriceAndDistanceWidget(getTranslated('distancePickupAndDrop', context)!,
           provider.model!.distance??''),
           ScreenSize.height(10),
           customRowForPriceAndDistanceWidget(getTranslated('price', context)!,
           provider.model!.deliverymanCharge??''),
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

  customRowForPriceAndDistanceWidget(String title, String subTitle){
    return Row(
      children: [
        Expanded(
          child: getText(title: "$title:", size: 13.5, fontFamily: FontFamily.poppinsMedium,
           color: AppColor.blackColor, fontWeight: FontWeight.w500),
        ),
          getText(title: subTitle, size: 13, fontFamily: FontFamily.poppinsRegular,
         color: AppColor.blackColor, fontWeight: FontWeight.w400),
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
                    Text(
                      provider.model!.shop != null
                          ? "${provider.model!.shop!.name ?? ""}"
                          : '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          AppImages.locationIcon,
                          height: 12,
                          width: 9,
                        ),
                        ScreenSize.width(5),
                        Flexible(
                          child: Text(
                            provider.model!.shop != null
                                ? "${provider.model!.shop!.address ?? ""}, ${provider.model!.shop!.city ?? ""}, ${provider.model!.shop!.country ?? ""}"
                                : '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13,
                                fontFamily: FontFamily.poppinsRegular,
                                color: Color(0xffB8B8B8),
                                fontWeight: FontWeight.w400),
                          ),
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
                        '+1 - ${provider.model!.shop != null ? provider.model!.shop!.phone.toString() : ''}',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Expanded(
                   child: getText(
                      title: getTranslated('order_details', context)!,
                      size: 16,
                      // maxLies: 1,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: Color(0xff2F2E36),
                      fontWeight: FontWeight.w600),
                 ),
                ScreenSize.width(10),
                Text.rich(TextSpan(
                    text: '${getTranslated('total_amount', context)!} : ',
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
            color: title.toUpperCase() == getTranslated('delivered', context)!.toUpperCase() ||
                title == getTranslated('open_map', context)!
                ? AppColor.greenColor.withOpacity(.3)
                : const Color(0xffC4D9ED)),
        alignment: Alignment.center,
        child: getText(
            title: title,
            size: 12,
            fontFamily: FontFamily.poppinsRegular,
            color: title.toUpperCase() == getTranslated('delivered', context)!.toUpperCase()  || title == getTranslated('open_map', context)!
                ? AppColor.greenColor
                : const Color(0xff0790FF),
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
