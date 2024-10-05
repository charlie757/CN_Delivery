import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/picker.dart';
import '../api/api_url.dart';
import '../config/approutes.dart';
import '../helper/appcolor.dart';
import '../screens/auth/otp_verify_screen.dart';
import '../utils/session_manager.dart';
import '../utils/showcircleprogressdialog.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
class SignupProvider extends ChangeNotifier{
  Country? selectedCountry;
final fNameController = TextEditingController();
final lNameController = TextEditingController();
final mobileController = TextEditingController();
final emailController = TextEditingController();
final addressController =TextEditingController();
final cityController = TextEditingController();
final countryController =TextEditingController();
final genderController =TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

/// vehicle information
  final vehicleNameController = TextEditingController();
  final vehicleTypeController  = TextEditingController();
  final modelNumberController = TextEditingController();
  final domController = TextEditingController();
  final dorController = TextEditingController();
  final fuelController = TextEditingController();
  final licenceController = TextEditingController();
  final registrationController = TextEditingController();

File? profileImage;
File? passportImage;
File? stateIdentityImage;
File? licenceImage;
File? inspectionImage;
File? criminalRecordImage;
File? insuranceCopyImage;
File?  touristPermitImage;
File? vehicleImage;
DateTime selectedDOMDate = DateTime.now();
  DateTime selectedDORDate = DateTime.now();
DateTime now = DateTime.now();

  void initCountry() async {
    final country = await getCountryByCountryCode(navigatorKey.currentContext!, 'ES');
      selectedCountry = country;
    notifyListeners();
  }

  void showCountryPicker() async{
    final country = await showCountryPickerSheet(navigatorKey.currentContext!,);
    if (country != null) {
        selectedCountry = country;
        notifyListeners();
    }
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



driverRegisterApiFunction()async{
  showCircleProgressDialog(navigatorKey.currentContext!);
  Map<String, String> headers = {"Authorization": SessionManager.token,'language':
  SessionManager.languageCode == 'es' ? 'es' : 'en'};
 var request =
  http.MultipartRequest('POST', Uri.parse(ApiUrl.driverRegisterUrl));
  request.headers.addAll(headers);
 request.headers.addAll(headers);
  request.fields['f_name'] = fNameController.text;
  request.fields['l_name'] = lNameController.text;
  request.fields['email'] = emailController.text;
  // ignore: unnecessary_null_comparison
  request.fields['country_code'] = selectedCountry!.callingCode!=null? selectedCountry!.callingCode.split('+')[1].toString():'';
  request.fields['phone'] = mobileController.text;
  request.fields['password'] = passwordController.text;
  request.fields['con_password'] = confirmPasswordController.text;
  request.fields['address'] = addressController.text;
  request.fields['city'] = cityController.text;
  request.fields['country'] = countryController.text;
  request.fields['gender'] = genderController.text;
   if(profileImage!=null){
    final file = await http.MultipartFile.fromPath(
      'image', profileImage!.path,
    );
    request.files.add(file);
  }
   if(stateIdentityImage!=null){
    final file = await http.MultipartFile.fromPath(
      'identity_image', stateIdentityImage!.path,
    );
    request.files.add(file);
  }
  var res = await request.send();
  var vb = await http.Response.fromStream(res);
  log(vb.body);
  print(vb.request);
  Navigator.pop(navigatorKey.currentContext!);
  if (vb.statusCode == 200) {
    var dataAll = json.decode(vb.body);
    if(dataAll['data']!=null&& !dataAll['data']['is_otp_verify']){
      AppRoutes.pushReplacementAndRemoveNavigation( OtpVerifyScreen(email: emailController.text,phone: mobileController.text,
      route: 'signup',));
    }
    Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
  } else {
    var dataAll = json.decode(vb.body);
    Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
  }

}

callApiFunction()async{
  showCircleProgressDialog(navigatorKey.currentContext!);
  Map<String, String> headers = {"Authorization": SessionManager.token,'language':
  SessionManager.languageCode == 'es' ? 'es' : 'en'};
  var request =
  http.MultipartRequest('POST', Uri.parse(ApiUrl.driverRegisterUrl));
  request.headers.addAll(headers);
  request.fields['f_name'] = fNameController.text;
  request.fields['l_name'] = lNameController.text;
  request.fields['email'] = emailController.text;
  request.fields['country_code'] = selectedCountry!.callingCode!=null? selectedCountry!.callingCode.split('+')[1].toString():'';
  request.fields['phone'] = mobileController.text;
  request.fields['password'] = passwordController.text;
  request.fields['con_password'] = confirmPasswordController.text;
  request.fields['address'] = addressController.text;
  request.fields['gender'] = genderController.text;
  request.fields['identity_number'] =licenceController.text;
  request.fields['vehicle_name']= vehicleNameController.text;
  request.fields['vehicle_type'] = vehicleTypeController.text;
  request.fields['vehicle_model_number'] = modelNumberController.text;
  request.fields['vehicle_date_of_manufacture'] = modelNumberController.text;
  request.fields['vehicle_date_of_registration'] = dorController.text;
  request.fields['vehicle_feule_type'] = fuelController.text;
  request.fields['vehicle_registration_number'] =registrationController.text;
  if (insuranceCopyImage != null) {
    print('fdgdsdsf');
    final file = await http.MultipartFile.fromPath(
      'vehicle_insurance_image', insuranceCopyImage!.path,
      // contentType: mime.MediaType("image", "jpg")
    );
    request.files.add(file);
  }
  if(touristPermitImage!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_tourist_permit_image', touristPermitImage!.path,
    );
    request.files.add(file);
  }
  print(touristPermitImage!.path);
  if(licenceImage!=null){
    final file = await http.MultipartFile.fromPath(
      'identity_image', licenceImage!.path,
    );
    request.files.add(file);
  }
  if(vehicleImage!=null){
    final file = await http.MultipartFile.fromPath(
      'vehicle_image', vehicleImage!.path,
    );
    request.files.add(file);
  }
  if(passportImage!=null){
    final file = await http.MultipartFile.fromPath(
      'passport_image', passportImage!.path,
    );
    request.files.add(file);
  }
  if(profileImage!=null){
    final file = await http.MultipartFile.fromPath(
      'image', profileImage!.path,
    );
    request.files.add(file);
  }
  var res = await request.send();
  var vb = await http.Response.fromStream(res);
  log(vb.body);
  Navigator.pop(navigatorKey.currentContext!);
  if (vb.statusCode == 200) {
    var dataAll = json.decode(vb.body);
    if(dataAll['data']!=null&& !dataAll['data']['is_otp_verify']){
      AppRoutes.pushReplacementAndRemoveNavigation( OtpVerifyScreen(email: emailController.text,phone: mobileController.text,
      route: 'signup',));
    }
    Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
  } else {
    var dataAll = json.decode(vb.body);
    Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
  }

}

}