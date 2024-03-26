import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/model/view_order_model.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewOrderDetailsProvider extends ChangeNotifier {
  GoogleMapController? myMapController;
  double lat = 45.521563;
  double lng = -122.677433;
  // LatLng? center;

  void onMapCreated(GoogleMapController controller) {
    myMapController = controller;
  }

  ViewOrderModel? model;
  callApiFunction(id) {
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
        // pickupLatLong(
        //     "${model!.pickUp!.address}, ${model!.pickUp!.city}, ${model!.pickUp!.country}");
        shippingLatLong("${model!.shippingAddress!.city}");
      }
      notifyListeners();
    });
  }

  // String lat = '';
  pickupLatLong(String address) async {
    List<Location> locations = await locationFromAddress(address);
    print("pickup${locations[0]}");
    Location location = locations[0]; // Assuming you want the first location
    // lat = location.latitude.toString();
  }

  shippingLatLong(String address) async {
    try {
      List<Location> locations = await locationFromAddress('jaipur');
      print("shipping${locations[0]}");
      Location location = locations[0]; // Assuming you want the first location
      // LatLng newCenter = LatLng(location.latitude, location.longitude);
      // center = newCenter;
      lat = location.latitude;
      lng = location.longitude;
      notifyListeners();
    } catch (e) {
      print("e..$e");
    }
  }

  updateStatusApiFunction(String orderId, String status) {
    //'delivered, out_for_delivery'
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({'order_id': orderId, 'status': status});
    ApiService.apiMethod(
      url: ApiUrl.updateOrderStatusUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        callApiFunction(orderId);
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
}
