import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/model/profile_model.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? profileModel;
  int tabBarIndex = 0;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final stateIdController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String profileImgUrl = '';
  bool isOnline = true;
  bool isLoading = false;
  bool profileLoading = false;
  File? imgFile;

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
  String? oldPasswordErrorMsg = '';
  String? newPasswordErrorMsg = '';
  String? confirmNewPasswordErrorMsg = '';

  clearValues() {
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
    oldPasswordErrorMsg = '';
    newPasswordErrorMsg = '';
    confirmNewPasswordErrorMsg = '';
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
    if (fNameErrorMsg == null &&
        lNameErrorMsg == null &&
        phonErrorMsg == null &&
        emailErrorMsg == null &&
        addressErrorMsg == null &&
        cityErrorMsg == null &&
        countyErrorMsg == null &&
        stateErrorMsg == null &&
        stateIdErrorMsg == null) {
      updateProfileApiFunction();
    } else {
      fNameErrorMsg =
          AppValidation.firstNameValidator(firstNameController.text);
      lNameErrorMsg = AppValidation.lastNameValidator(lastNameController.text);
      phonErrorMsg = AppValidation.phoneNumberValidator(mobileController.text);
      emailErrorMsg = AppValidation.emailValidator(emailController.text);
      addressErrorMsg = AppValidation.addressValidator(addressController.text);
      cityErrorMsg = AppValidation.cityValidator(cityController.text);
      countyErrorMsg = AppValidation.countryValidator(countryController.text);
      stateErrorMsg = AppValidation.stateValidator(stateController.text);
      stateIdErrorMsg = AppValidation.stateIdValidator(stateIdController.text);
    }
    notifyListeners();
  }

  checkPasswordValidation() {
    if (oldPasswordErrorMsg == null &&
        newPasswordErrorMsg == null &&
        confirmNewPasswordErrorMsg == null) {
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
    cityController.text = profileModel!.data!.city ?? "";
    stateController.text = profileModel!.data!.state ?? "";
    countryController.text = profileModel!.data!.country ?? "";
    stateIdController.text = profileModel!.data!.identityNumber ?? "";
    profileImgUrl = profileModel!.data!.image ?? '';
    isOnline = profileModel!.data!.isOnline == 1 ? true : false;
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
    Map<String, String> headers = {"Authorization": SessionManager.token};

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.updateProfileUrl));
    request.headers.addAll(headers);
    request.fields['f_name'] = firstNameController.text;
    request.fields['l_name'] = lastNameController.text;
    request.fields['email'] = emailController.text;
    request.fields['country_code'] = '1';
    request.fields['phone'] = mobileController.text;
    request.fields['address'] = addressController.text;
    request.fields['city'] = cityController.text;
    request.fields['state'] = stateController.text;
    request.fields['country'] = countryController.text;
    request.fields['identity_number'] = stateIdController.text;
    if (imgFile != null) {
      final file = await http.MultipartFile.fromPath(
        'image', imgFile!.path,
        // contentType: mime.MediaType("image", "jpg")
      );
      request.files.add(file);
    }

    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    log(vb.body);
    if (vb.statusCode == 200) {
      Navigator.pop(navigatorKey.currentContext!);
      // updateProfileLoading(false);
      var dataAll = json.decode(vb.body);
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
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
}
