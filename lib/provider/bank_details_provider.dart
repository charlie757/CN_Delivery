import 'dart:convert';

import 'package:cn_delivery/api/api_service.dart';
import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/bank_info_model.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/showcircleprogressdialog.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

class BankDetailsProvider extends ChangeNotifier{
  final holderNameController = TextEditingController();
  final branchController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  String?holderNameErrorMsg = '';
  String?bankNameErrorMsg = '';
  String? branchNameErrorMsg = '';
  String? accountNumberErrorMsg = '';
  bool isLoading = false;
  bankInfoModel?model;
 
 clearValues(){
  isLoading=false;
  holderNameErrorMsg = '';
  bankNameErrorMsg = '';
  branchNameErrorMsg = '';
  accountNumberErrorMsg ='';
  holderNameController.clear();
  branchController.clear();
  accountNumberController.clear();
  bankNameController.clear();
 }

updateLoading(value){
  isLoading=value;
  notifyListeners();
}

  checkValidation(BuildContext context){
   if (holderNameErrorMsg == null && bankNameErrorMsg == null&& branchNameErrorMsg == null&& accountNumberErrorMsg == null) {
    updateBankApiFunction();
      // callApiFunction();
    } else {
      holderNameErrorMsg =
          AppValidation.bankValidation(val:holderNameController.text,errorMsg: getTranslated('enter_holder_name', context)!);
      bankNameErrorMsg = AppValidation.bankValidation(val:bankNameController.text,errorMsg: getTranslated('enter_bank_name', context)!);
      branchNameErrorMsg = AppValidation.bankValidation(val:branchController.text,errorMsg: getTranslated('enter_branch_name', context)!);
      accountNumberErrorMsg = AppValidation.bankValidation(val:accountNumberController.text,errorMsg: getTranslated('enter_account_number', context)!);
    }

    notifyListeners();
  }
setControllersValues(){
  if(model!=null&&model!.data!=null){
    holderNameController.text = model!.data!.holderName;
    bankNameController.text = model!.data!.bankName;
    branchController.text = model!.data!.branch;
    accountNumberController.text = model!.data!.accountNo;
    notifyListeners();
  }
}
  
  bankInfoApiFunction()async{
    if(model==null){
      showCircleProgressDialog(navigatorKey.currentContext!);
    }
    var body = json.encode({
    });
    ApiService.apiMethod(
      url: ApiUrl.bankInfoUrl,
      body: body,
      method: checkApiMethod(httpMethod.get),
    ).then((value) {
      if (value != null) {
        if(model==null){
          Navigator.pop(navigatorKey.currentContext!);
        }
        model = bankInfoModel.fromJson(value);
        notifyListeners();
        setControllersValues();
      }
      else{
        model = null;
        notifyListeners();
      }
    });  
  }

  updateBankApiFunction()async{
    Utils.hideTextField();
  updateLoading(true);
    var body = json.encode({
    "bank_name": bankNameController.text,
    "branch": branchController.text,
    "account_no": accountNumberController.text,
    "holder_name": holderNameController.text
    });
    ApiService.apiMethod(
      url: ApiUrl.updateBankInfoUrl,
      body: body,
      method: checkApiMethod(httpMethod.put),
    ).then((value) {
      updateLoading(false);
      if (value != null) {
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
       bankInfoApiFunction();
        notifyListeners();
      }
    });
  }
}