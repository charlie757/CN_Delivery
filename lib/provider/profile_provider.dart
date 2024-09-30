import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/profile_model.dart';
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
  int tabBarIndex = 0;
  int selectedLangIndex = 0;
  int selectedGender = -1;
  int vehicleType=-1;
  int fuelType=-1;
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
  final modelNumberController = TextEditingController();
  final domController = TextEditingController();
  final dorController = TextEditingController();
  final fuelController = TextEditingController();
  final vehicleRegistrationController = TextEditingController();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String profileImgUrl = '';
  bool isOnline = true;
  bool isLoading = false;
  bool profileLoading = false;
  File? imgFile;
  File? passportImage;
  File? licenceImage;
  File? insuranceCopyImage;
  File?  touristPermitImage;
  File? vehicleImage;

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
  String? vehicleNameErrorMsg = '';
  String? vehicleTypeErrorMsg = '';
  String? modelNumberErrorMsg = '';
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
    licenceImage=null;
    passportImage=null;
    vehicleImage=null;
    touristPermitImage=null;
    insuranceCopyImage=null;
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
        AppValidation.stateIdValidator(stateIdController.text) == null) {
      print('sfdv');
      updateProfileApiFunction();
    } else {
      print('sfdvdfd');
      fNameErrorMsg =
          AppValidation.firstNameValidator(firstNameController.text);
      lNameErrorMsg = AppValidation.lastNameValidator(lastNameController.text);
      addressErrorMsg = AppValidation.addressValidator(addressController.text);
      stateIdErrorMsg = AppValidation.stateIdValidator(stateIdController.text);
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

  checkVehicleInfoValidation(){
    if (AppValidation.vehicleNameValidator(vehicleNameController.text) == null &&
        AppValidation.vehicleTypeValidator(vehicleTypeController.text) == null &&
        AppValidation.modelNumberValidator(modelNumberController.text) == null &&
        // AppValidation.dateOfManufactureValidator(domController.text) == null &&
        AppValidation.dateOfRegistrationValidator(dorController.text) == null &&
        AppValidation.fuelTypeValidator(fuelController.text) == null &&
        AppValidation.vehicleRegistrationValidator(vehicleRegistrationController.text) == null) {
      updateVehicleApiFunction();
    } else {
      vehicleNameErrorMsg =
          AppValidation.vehicleNameValidator(vehicleNameController.text);
      vehicleTypeErrorMsg = AppValidation.vehicleTypeValidator(vehicleTypeController.text);
      modelNumberErrorMsg = AppValidation.modelNumberValidator(modelNumberController.text);
      // domErrorMsg = AppValidation.dateOfManufactureValidator(domController.text);
      dorErrorMsg = AppValidation.dateOfRegistrationValidator(dorController.text);
      fuelErrorMsg = AppValidation.fuelTypeValidator(fuelController.text);
      vehicleRegistrationErrorMsg = AppValidation.vehicleRegistrationValidator(vehicleRegistrationController.text);
    }
    notifyListeners();

  }


  getProfileApiFunction(bool isLoading) {
    isLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    var body = json.encode({});
    ApiService.apiMethod(
      url: ApiUrl.getProfileUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      isLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        profileModel = ProfileModel.fromJson(value);
        setValuesInController();
      }
    });
  }

  setValuesInController() {
    firstNameController.text = profileModel!.data!.fName ?? "";
    lastNameController.text = profileModel!.data!.lName ?? "";
    mobileController.text = profileModel!.data!.phone ?? "";
    emailController.text = profileModel!.data!.email ?? "";
    addressController.text = profileModel!.data!.address ?? "";
    // cityController.text = profileModel!.data!.city ?? "";
    // stateController.text = profileModel!.data!.state ?? "";
    // countryController.text = profileModel!.data!.country ?? "";
    stateIdController.text = profileModel!.data!.identityNumber ?? "";
    genderController.text = profileModel!.data!.gender??"";
    vehicleNameController.text = profileModel!.data!.vehicleName??'';
    vehicleTypeController.text = profileModel!.data!.vehicleType??'';
    modelNumberController.text = profileModel!.data!.vehicleModelNumber??"";
    domController.text = profileModel!.data!.vehicleDateOfManufacture??"";
    dorController.text = profileModel!.data!.vehicleDateOfRegistration??"";
    fuelController.text = profileModel!.data!.vehicleFeuleType??"";
    vehicleRegistrationController.text = profileModel!.data!.vehicleRegistrationNumber??'';
    profileImgUrl = profileModel!.data!.image ?? '';
    isOnline = profileModel!.data!.isOnline == 1 ? true : false;
    if(genderController.text.isNotEmpty){
      selectedGender = genderController.text.toLowerCase()== getTranslated('male', navigatorKey.currentContext!)!.toLowerCase() ?0:1;
    }
    if(fuelController.text.isNotEmpty){
      fuelType = fuelController.text.toLowerCase()==getTranslated('petrol', navigatorKey.currentContext!)!.toLowerCase()?0:1;
    }
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
    // request.fields['email'] = emailController.text;
    // request.fields['phone'] = mobileController.text;
    request.fields['address'] = addressController.text;
    // request.fields['country_code']='1';
    // request.fields['city'] = cityController.text;
    // request.fields['state'] = stateController.text;
    // request.fields['country'] = countryController.text;
    request.fields['identity_number'] = stateIdController.text;
    request.fields['gender'] = genderController.text;
    if (imgFile != null) {
      final file = await http.MultipartFile.fromPath(
        'image', imgFile!.path,
        // contentType: mime.MediaType("image", "jpg")
      );
      request.files.add(file);
    }
    if (passportImage != null) {
      final file = await http.MultipartFile.fromPath(
        'passport_image', passportImage!.path,
        // contentType: mime.MediaType("image", "jpg")
      );
      request.files.add(file);
    }
    if (licenceImage != null) {
      final file = await http.MultipartFile.fromPath(
        'identity_image', licenceImage!.path,
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

  updateVehicleApiFunction() async {
    showCircleProgressDialog(navigatorKey.currentContext!);
    // updateProfileLoading(true);
    Map<String, String> headers = {"Authorization": SessionManager.token,
      'language':
      SessionManager.languageCode == 'es' ? 'es' : 'en'};

    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.updateVehicleInfoUrl));
    request.headers.addAll(headers);
    request.fields['vehicle_name'] = vehicleNameController.text;
    request.fields['vehicle_type'] = vehicleTypeController.text;
    request.fields['vehicle_model_number'] = vehicleTypeController.text;
    request.fields['vehicle_date_of_manufacture'] = domController.text;
    request.fields['vehicle_date_of_registration'] = dorController.text;
    request.fields['vehicle_registration_number'] = vehicleRegistrationController.text;
    request.fields['vehicle_feule_type'] = fuelController.text;
    if (insuranceCopyImage != null) {
      final file = await http.MultipartFile.fromPath(
        'vehicle_insurance_image', insuranceCopyImage!.path,
      );
      request.files.add(file);
    }
    if (touristPermitImage != null) {
      final file = await http.MultipartFile.fromPath(
        'vehicle_tourist_permit_image', touristPermitImage!.path,
      );
      request.files.add(file);
    }
    if (vehicleImage != null) {
      final file = await http.MultipartFile.fromPath(
        'vehicle_image', vehicleImage!.path,
      );
      request.files.add(file);
    }


    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    log(vb.body);
    Navigator.pop(navigatorKey.currentContext!);
    if (vb.statusCode == 200) {
      // updateProfileLoading(false);
      var dataAll = json.decode(vb.body);
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
      getProfileApiFunction(false);
    } else {
      updateIsLoading(false);
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
