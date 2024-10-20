import 'dart:convert';
import 'dart:io';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/enum.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/model/view_order_model.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewOrderDetailsProvider extends ChangeNotifier {
  ViewOrderModel? model;

  // LatLng? sourceLocation;
  // LatLng? destination;
  LatLng? storeLocation;
  LatLng? deliveryLocation;
  LatLng? currentLocation;

  double pickupLat = 0.0;
  double pickupLng = 0.0;
  double shippingLat = 0.0;
  double shippingLng = 0.0;
  // LatLng? center;

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Platform.isAndroid?
      Constants.androidGoogleMapKey:Constants.iosGoogleMapKey, // Your Google Map Key
      // PointLatLng(double.parse(SessionManager.lat),  double.parse(SessionManager.lng)),
      PointLatLng(storeLocation!.latitude, storeLocation!.longitude),
        PointLatLng(deliveryLocation!.latitude, deliveryLocation!.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      notifyListeners();
    }
  }

  clearValues() {
    pickupLat = 0.0;
    pickupLng = 0.0;
    shippingLat = 0.0;
    shippingLng = 0.0;
    storeLocation = null;
    deliveryLocation=null;
    polylineCoordinates = [];
  }

  orderDetailsApiFunction(id) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({});
    ApiService.apiMethod(
      url: "${ApiUrl.orderDetailsUrl}order_id=$id",
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        model = ViewOrderModel.fromJson(value[0]);
        pickupLatLong(
            "${model!.pickUp!.address}, ${model!.pickUp!.city}, ${model!.pickUp!.country}");
        shippingLatLong(
            "${model!.shippingAddress!.address}, ${model!.shippingAddress!.city}, ${model!.shippingAddress!.country}");
      }
      notifyListeners();
    });
  }

  // String lat = ''
  pickupLatLong(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      print("pickup${locations[0]}");
      Location location = locations[0];
      pickupLat = location.latitude;
      pickupLng = location.longitude;
      storeLocation = LatLng(location.latitude, location.longitude);
      notifyListeners();
    } catch (e) {}
  }


  shippingLatLong(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      Location location = locations[0]; // Assuming you want the first location
      shippingLat = location.latitude;
      shippingLng = location.longitude;
      deliveryLocation = LatLng(location.latitude, location.longitude);
      if(storeLocation!=null&&deliveryLocation!=null){
          print('sfdvfdvdf');
          // getPolyPoints();
        }
      notifyListeners();
    } catch (e) {
      print("e..$e");
    }
  }

  updateStatusApiFunction(String orderId, String status) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({'order_id': orderId, 'status': status});
    print(body);
    ApiService.apiMethod(
      url: ApiUrl.updateOrderStatusUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        // Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        orderDetailsApiFunction(orderId);
      }
      notifyListeners();
    });
  }

  callNumber(String number) async {
    // const number = '08592119XXXX'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  openMail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: '', //add subject and body here
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String statusTitle(String state){
    if(state.toLowerCase()=='accepted') {
      return getTranslated('goingForPickup', navigatorKey.currentContext!)!;
    }
    else if(state.toLowerCase()=='out_for_pickup'){
      return getTranslated('pickedUp', navigatorKey.currentContext!)!;
    }
    else if(state.toLowerCase()=='picked'){
      return getTranslated('outForDelivery', navigatorKey.currentContext!)!;
    }
    else if(state.toLowerCase()=='out_for_delivery'){
      return getTranslated('delivered', navigatorKey.currentContext!)!;
    }
    else if(state.toLowerCase()=='delivered'){
      return getTranslated('deliveryCompleted', navigatorKey.currentContext!)!;
    }
    return '';
  }

  changeStatus(String status){
    if(status.toLowerCase()=='accepted') {
      return OrderStatusTypes.out_for_pickup.name;
    }
    else if(status.toLowerCase()=='out_for_pickup'){
      return OrderStatusTypes.picked.name;
    }
    else if(status.toLowerCase()=='picked'){
      return OrderStatusTypes.out_for_delivery.name;
    }
    else if(status.toLowerCase()=='out_for_delivery'){
      return OrderStatusTypes.delivered.name;
    }
    return '';
  }
}
