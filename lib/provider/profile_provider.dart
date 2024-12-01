import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/profile_model.dart';
import 'package:cn_delivery/model/vehicle_info_model.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/time_format.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? profileModel;
  VehicleInfoModel? vehicleInfoModel;
  int tabBarIndex = 0;
  int selectedLangIndex = 0;
  int selectedGender = -1;
  int vehicleType=-1;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final stateIdController = TextEditingController();
  final genderController = TextEditingController();

    
  final vehicleNameController = TextEditingController();
  final vehicleTypeController  = TextEditingController();
  final vehicleBrandController = TextEditingController();
  final vehicleSizeController = TextEditingController();
  final vehicleColorController = TextEditingController();
  final modelNumberController = TextEditingController();
  final domController = TextEditingController();
  final dorController = TextEditingController();
  final fuelController = TextEditingController();
  final vehicleRegistrationController = TextEditingController();
  final vehicleLicenseController = TextEditingController();

 clearVehicleControllerOnChangeVehicleTye(){
  vehicleNameController.clear();
  vehicleBrandController.clear();
  vehicleSizeController.clear();
  vehicleColorController.clear();
  modelNumberController.clear();
  domController.clear();
  dorController.clear();
  fuelController.clear();
  vehicleRegistrationController.clear();
  vehicleLicenseController.clear();
  vehicleImage=null;
  vehicleImage2=null;
  licenceImage=null;
  insuranceCopyImage=null;
  inspectionImage=null;
  criminalRecordImage=null;
 }

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String profileImgUrl = '';
  bool isOnline = true;
  bool isLoading = false;
  bool profileLoading = false;
  File? imgFile;
  File? stateIdentityImage;
  File? licenceImage;
  File? insuranceCopyImage;
  File? vehicleImage;
  File? vehicleImage2;
  File?inspectionImage;
File?criminalRecordImage;

  DateTime selectedDOMDate = DateTime.now();
  DateTime selectedDORDate = DateTime.now();

  /// validation
  String? fNameErrorMsg = '';
  String? lNameErrorMsg = '';
  String? phonErrorMsg = '';
  String? emailErrorMsg = '';
  String? addressErrorMsg = '';
  String? cityErrorMsg = '';
  String? stateErrorMsg = '';
  String? countyErrorMsg = '';
  String? stateIdErrorMsg = '';
  String? genderErrorMsg = '';
  String? vehicleBrandErrorMsg = '';
  String? vehicleSizeErrorMsg = '';
  String? vehicleColorErrorMsg = '';
  String? vehicleNameErrorMsg = '';
  String? vehicleTypeErrorMsg = '';
  String? modelNumberErrorMsg = '';
  String? vehicleLicenseErrorMsg = '';
  String? domErrorMsg = '';
  String? dorErrorMsg = '';
  String? fuelErrorMsg = '';
  String? vehicleRegistrationErrorMsg ='';
  String? oldPasswordErrorMsg = '';
  String? newPasswordErrorMsg = '';
  String? confirmNewPasswordErrorMsg = '';

  clearValues() {
    tabBarIndex=0;
    imgFile = null;
    profileLoading = false;
    isLoading = false;
    fNameErrorMsg = '';
    lNameErrorMsg = '';
    phonErrorMsg = '';
    emailErrorMsg = '';
    addressErrorMsg = '';
    cityErrorMsg = '';
    stateErrorMsg = '';
    countyErrorMsg = '';
    stateIdErrorMsg = '';
    genderErrorMsg='';
    vehicleNameErrorMsg='';
    vehicleTypeErrorMsg='';
    modelNumberErrorMsg='';
    domErrorMsg='';
    dorErrorMsg='';
    fuelErrorMsg='';
    vehicleRegistrationErrorMsg='';
    oldPasswordErrorMsg = '';
    newPasswordErrorMsg = '';
    confirmNewPasswordErrorMsg = '';
    stateIdentityImage=null;
    vehicleImage2=null;
    licenceImage=null;
    vehicleImage=null;
    insuranceCopyImage=null;
    inspectionImage=null;
    criminalRecordImage=null;
  }

  updateLangIndex(val) {
    selectedLangIndex = val;
    notifyListeners();
  }

  updateTabBarIndex(value) {
    tabBarIndex = value;
    notifyListeners();
  }

  updateIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  updateProfileLoading(value) {
    profileLoading = value;
    notifyListeners();
  }

  updateInOnline(val) {
    switchOnlineApiFunction(val);
    notifyListeners();
  }

  checkUpdateProfileValidation() {
    if (AppValidation.firstNameValidator(firstNameController.text) == null &&
        AppValidation.lastNameValidator(lastNameController.text) == null &&
        AppValidation.addressValidator(addressController.text) == null &&
        AppValidation.cityValidator(cityController.text) == null &&
        AppValidation.countryValidator(countryController.text) == null) {
      updateProfileApiFunction();
    } else {
      fNameErrorMsg =
          AppValidation.firstNameValidator(firstNameController.text);
      lNameErrorMsg = AppValidation.lastNameValidator(lastNameController.text);
      addressErrorMsg = AppValidation.addressValidator(addressController.text);
      cityErrorMsg = AppValidation.cityValidator(cityController.text);
      countyErrorMsg = AppValidation.countryValidator(countryController.text);
    }
    notifyListeners();
  }

  checkPasswordValidation() {
    if (AppValidation.passwordValidator(oldPasswordController.text) == null &&
        AppValidation.reEnterpasswordValidator(
            newPasswordController.text, confirmPasswordController.text) == null &&
        AppValidation.reEnterpasswordValidator(
            confirmPasswordController.text, newPasswordController.text) == null) {
      updatePasswordApiFunction();
    } else {
      oldPasswordErrorMsg =
          AppValidation.passwordValidator(oldPasswordController.text);
      newPasswordErrorMsg = AppValidation.reEnterpasswordValidator(
          newPasswordController.text, confirmPasswordController.text);
      confirmNewPasswordErrorMsg = AppValidation.reEnterpasswordValidator(
          confirmPasswordController.text, newPasswordController.text);
    }
    notifyListeners();
  }
 
 checkBicycleValidation(){
  if(AppValidation.vehicleBrandValidator(vehicleBrandController.text) == null &&
    AppValidation.vehicleTypeValidator(vehicleTypeController.text) == null &&
    AppValidation.vehicleSizeValidator(vehicleSizeController.text)==null&&
    AppValidation.vehicleColorValidator(vehicleColorController.text)==null){
      bicycleVehicleApiFunction();
        }
        else{
           vehicleBrandErrorMsg =
          AppValidation.vehicleNameValidator(vehicleBrandController.text);
      vehicleTypeErrorMsg = AppValidation.vehicleTypeValidator(vehicleTypeController.text);
      vehicleSizeErrorMsg = AppValidation.modelNumberValidator(vehicleSizeController.text);
      vehicleColorErrorMsg = AppValidation.modelNumberValidator(vehicleColorController.text);
     
        }
 }

  checkCarAndBikeVehicleInfoValidation(){
    if (AppValidation.vehicleNameValidator(vehicleNameController.text) == null &&
        AppValidation.vehicleTypeValidator(vehicleTypeController.text) == null &&
        AppValidation.modelNumberValidator(modelNumberController.text) == null &&
        AppValidation.vehicleBrandValidator(vehicleBrandController.text) == null &&
        AppValidation.dateOfRegistrationValidator(dorController.text) == null &&
        AppValidation.vehicleLicenseValidator(vehicleLicenseController.text) == null &&
        AppValidation.vehicleRegistrationValidator(vehicleRegistrationController.text) == null) {
        bikeCarVehicleApiFunction(vehicleTypeController.text);
    } else {
      vehicleNameErrorMsg =
          AppValidation.vehicleNameValidator(vehicleNameController.text);
      vehicleTypeErrorMsg = AppValidation.vehicleTypeValidator(vehicleTypeController.text);
      modelNumberErrorMsg = AppValidation.modelNumberValidator(modelNumberController.text);
      vehicleBrandErrorMsg = AppValidation.dateOfManufactureValidator(vehicleBrandController.text);
      dorErrorMsg = AppValidation.dateOfRegistrationValidator(dorController.text);
      vehicleLicenseErrorMsg = AppValidation.fuelTypeValidator(vehicleLicenseController.text);
      vehicleRegistrationErrorMsg = AppValidation.vehicleRegistrationValidator(vehicleRegistrationController.text);
    }
    notifyListeners();

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

  getProfileApiFunction(bool isLoading) {
    isLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.getProfileUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      isLoading &&!Constants.is401Error ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        profileModel = ProfileModel.fromJson(value);
        setValuesInController();
        getVehicleInfoApiFunction(profileModel!.data!.vehicleType);
      }
    });
  }

  getVehicleInfoApiFunction(String type)async{
    var body = json.encode({});
    ApiService.apiMethod(
      url: "${ApiUrl.getVehicleInfoUrl}vehicle_type=$type",
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      if (value != null) {
        vehicleInfoModel = VehicleInfoModel.fromJson(value);
        setVehicleValuesInController();
      }
    });
  }

setVehicleValuesInController(){
vehicleTypeController.text = vehicleInfoModel!.data!.vehicleType??'';
vehicleBrandController.text = vehicleInfoModel!.data!.vehicleBrand??'';
vehicleSizeController.text = vehicleInfoModel!.data!.vehicleSize??'';
vehicleColorController.text = vehicleInfoModel!.data!.vehicleColor??'';
vehicleNameController.text = vehicleInfoModel!.data!.vehicleName??'';
modelNumberController.text = vehicleInfoModel!.data!.vehicleModelNumber??'';
dorController.text = vehicleInfoModel!.data!.vehicleDateOfRegistration??'';
vehicleRegistrationController.text = vehicleInfoModel!.data!.vehicleRegistrationNumber??'';
vehicleLicenseController.text = vehicleInfoModel!.data!.vehicleLicenseNumber??'';
notifyListeners();
}

  setValuesInController() {
    firstNameController.text = profileModel!.data!.fName ?? "";
    lastNameController.text = profileModel!.data!.lName ?? "";
    mobileController.text = profileModel!.data!.phone ?? "";
    emailController.text = profileModel!.data!.email ?? "";
    addressController.text = profileModel!.data!.address ?? "";
    genderController.text = profileModel!.data!.gender??"";
    cityController.text = profileModel!.data!.city ?? "";
    countryController.text = profileModel!.data!.country ?? "";
    profileImgUrl = profileModel!.data!.image ?? '';
    isOnline = profileModel!.data!.isOnline == 1 ? true : false;
    if(genderController.text.isNotEmpty){
      selectedGender = genderController.text.toLowerCase()== getTranslated('male', navigatorKey.currentContext!)!.toLowerCase() ?0:1;
    }
    // if(fuelController.text.isNotEmpty){
    //   fuelType = fuelController.text.toLowerCase()==getTranslated('petrol', navigatorKey.currentContext!)!.toLowerCase()?0:1;
    // }
    if(vehicleTypeController.text.isNotEmpty){
      for(int i=0;i<Constants.vehicleTypeList.length;i++){
        if(Constants.vehicleTypeList[i].toString().toLowerCase()==vehicleTypeController.text.toLowerCase()){
         vehicleType = i;
        }
      }
    }
    if(domController.text.isNotEmpty){
      selectedDOMDate = TimeFormat.convertDate1(domController.text);
    }
    if(dorController.text.isNotEmpty){
      selectedDORDate = TimeFormat.convertDate1(dorController.text);
    }
    notifyListeners();
  }

  updatePasswordApiFunction() {
    updateIsLoading(true);
    var body = json.encode({
      "current_password": oldPasswordController.text,
      "password": confirmPasswordController.text
    });
    ApiService.apiMethod(
      url: ApiUrl.updatePasswordUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      updateIsLoading(false);
      if (value != null) {
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      }
    });
  }

  updateProfileApiFunction() async {
    showCircleProgressDialog(navigatorKey.currentContext!);
    // updateProfileLoading(true);
    Map<String, String> headers = {"Authorization": SessionManager.token,
    'language':
    SessionManager.languageCode == 'es' ? 'es' : 'en'
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.updateProfileUrl));
    request.headers.addAll(headers);
    request.fields['f_name'] = firstNameController.text;
    request.fields['l_name'] = lastNameController.text;
    request.fields['address'] = addressController.text;
    request.fields['city'] = cityController.text;
    request.fields['country'] = countryController.text;
    request.fields['identity_number'] = stateIdController.text;
    request.fields['gender'] = genderController.text;
    if (imgFile != null) {
      final file = await http.MultipartFile.fromPath(
        'image', imgFile!.path,
        // contentType: mime.MediaType("image", "jpg")
      );
      request.files.add(file);
    }
    if (stateIdentityImage != null) {
      final file = await http.MultipartFile.fromPath(
        'identity_image', stateIdentityImage!.path,
        // contentType: mime.MediaType("image", "jpg")
      );
      request.files.add(file);
    }
    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    log(vb.body);
    Navigator.pop(navigatorKey.currentContext!);
    if (vb.statusCode == 200) {
      var dataAll = json.decode(vb.body);
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
      getProfileApiFunction(false);
    } else {
      updateIsLoading(false);
      var dataAll = json.decode(vb.body);
      Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
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
  print(vb.request);
  print(vb.statusCode);
  Navigator.pop(navigatorKey.currentContext!);
  if (vb.statusCode == 200) {
    // var dataAll = json.decode(vb.body);
    var dataAll = json.decode(vb.body);
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
      getProfileApiFunction(false);
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
  request.fields['vehicle_registration_number'] = vehicleRegistrationController.text;
  request.fields['vehicle_license_number'] = vehicleLicenseController .text;
  request.fields.forEach((key, value) {
    print('$key: $value');
  });


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
   print(type);
  var res = await request.send();
  var vb = await http.Response.fromStream(res);
  log(vb.body);
  print(vb.request);
  Navigator.pop(navigatorKey.currentContext!);
  if (vb.statusCode == 200) {
    var dataAll = json.decode(vb.body);
     if(dataAll['status']==true){
     var dataAll = json.decode(vb.body);
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
      getProfileApiFunction(false);
     }
  } else {
    var dataAll = json.decode(vb.body);
    Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
  }
}


  switchOnlineApiFunction(val) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({
      "is_online": val ? 1 : 0,
    });
    ApiService.apiMethod(
      url: ApiUrl.onlineUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        isOnline = val;
        getProfileApiFunction(false);
        notifyListeners();
      }
    });
  }

  imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: source, // alternatively, use ImageSource.gallery
    );
    if (img == null) return;

    imgFile = File(img.path); // convert it to a Dart:io file
    notifyListeners();
  }

  deleteAccountApiFunction()async{
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = json.encode({
    });
    ApiService.apiMethod(
        url: "${ApiUrl.deleteAccountUrl}/1",
        body: body,
        method: checkApiMethod(httpMethod.get),
        isErrorMessageShow: false
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if(value!=null){
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        Utils.logOut();
      }
    });

  }

}
