import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/screens/dashboard_screen.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class VehicleInfoProvider extends ChangeNotifier{

  final vehicleBrandController = TextEditingController();
  final vehicleSizeController = TextEditingController();
  final vehicleColorController = TextEditingController();
  final vehicleNameController = TextEditingController();
  final modelNumberController = TextEditingController();
  final domController = TextEditingController();
  final dorController = TextEditingController();
  final fuelController = TextEditingController();
  final licenceController = TextEditingController();
  final registrationController = TextEditingController();

DateTime selectedDOMDate = DateTime.now();
  DateTime selectedDORDate = DateTime.now();
DateTime now = DateTime.now();

File? vehicleImage;
File? vehicleImage2;
File? licenceImage;
File?insuranceCopyImage;
File?inspectionImage;
File?criminalRecordImage;


clearValues(){
   vehicleBrandController.clear();
  vehicleSizeController.clear();
   vehicleColorController.clear();
   vehicleNameController.clear();
   modelNumberController.clear();
   domController.clear();
   dorController.clear();
   fuelController.clear();
   licenceController.clear();
   registrationController.clear();
  vehicleImage =null;
  vehicleImage2=null;
  licenceImage=null;
  insuranceCopyImage=null;
  inspectionImage=null;
  criminalRecordImage=null;
  selectedDOMDate = DateTime.now();
  selectedDORDate = DateTime.now();
}


Future datePicker(selectedDate) async {
  DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(colorSchemeSeed: AppColor.blueColor),
          child: child!,
        );
      },
      helpText: getTranslated('select_date', navigatorKey.currentContext!)!,
      context: navigatorKey.currentContext!,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now()
  );
  if (picked != null && picked != DateTime.now()) {
    // picked.day
    // picked.month
    // picked.year
    // selectedDate = picked;
    return picked;
  }
}

bicycleVehicleApiFunction()async{
  Utils.hideTextField();
   showCircleProgressDialog(navigatorKey.currentContext!);
  Map<String, String> headers = {"Authorization": SessionManager.token,'language':
  SessionManager.languageCode == 'es' ? 'es' : 'en'};
 var request =
  http.MultipartRequest('POST', Uri.parse(ApiUrl.updateVehicleInfoUrl));
  request.headers.addAll(headers);
 request.headers.addAll(headers);
  request.fields['vehicle_type'] = 'bicycle';
  request.fields['vehicle_brand'] = vehicleBrandController.text;
  request.fields['vehicle_size'] = vehicleSizeController.text;
  request.fields['vehicle_color'] = vehicleColorController.text;
   if(vehicleImage!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_image', vehicleImage!.path,
    );
    request.files.add(file);
  }
   
  var res = await request.send();
  var vb = await http.Response.fromStream(res);
  log(vb.body);
  print(vb.statusCode);
  Navigator.pop(navigatorKey.currentContext!);
  if (vb.statusCode == 200) {
    var dataAll = json.decode(vb.body);
    AppRoutes.pushReplacementAndRemoveNavigation(const DashboardScreen());
  } else {
    var dataAll = json.decode(vb.body);
    Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
  }
}

bikeCarVehicleApiFunction(String type)async{
   showCircleProgressDialog(navigatorKey.currentContext!);
  Map<String, String> headers = {"Authorization": SessionManager.token,'language':
  SessionManager.languageCode == 'es' ? 'es' : 'en'};
 var request =
  http.MultipartRequest('POST', Uri.parse(ApiUrl.updateVehicleInfoUrl));
  request.headers.addAll(headers);
 request.headers.addAll(headers);
  request.fields['vehicle_type'] = type;  /// car
  request.fields['vehicle_name'] = vehicleNameController.text;
  request.fields['vehicle_brand'] = vehicleBrandController.text;
  request.fields['vehicle_model_number'] = modelNumberController.text;
  request.fields['vehicle_date_of_registration'] = dorController.text;
  request.fields['vehicle_registration_number'] = registrationController.text;
  request.fields['vehicle_license_number'] = licenceController.text;
   if(vehicleImage!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_image', vehicleImage!.path,
    );
    request.files.add(file);
  }
  if(vehicleImage2!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_image_two', vehicleImage2!.path,
    );
    request.files.add(file);
  }
  if(licenceImage!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_license_image', licenceImage!.path,
    );
    request.files.add(file);
  }
  if(insuranceCopyImage!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_insurance_image', insuranceCopyImage!.path,
    );
    request.files.add(file);
  }
  if(inspectionImage!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_inspection_image', inspectionImage!.path,
    );
    request.files.add(file);
  }
  if(criminalRecordImage!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_criminal_record_image', criminalRecordImage!.path,
    );
    request.files.add(file);
  }
   
  var res = await request.send();
  var vb = await http.Response.fromStream(res);
  log(vb.body);
  Navigator.pop(navigatorKey.currentContext!);
  if (vb.statusCode == 200) {
    var dataAll = json.decode(vb.body);
     if(dataAll['status']==true){
      AppRoutes.pushReplacementAndRemoveNavigation(const DashboardScreen());
     }
  } else {
    var dataAll = json.decode(vb.body);
    Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
  }
}


}