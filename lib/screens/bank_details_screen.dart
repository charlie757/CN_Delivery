import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/custom_button.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/rounded_textfield.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/bank_details_provider.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val){
     callInitFunction();
    });
    super.initState();
  }

callInitFunction(){
  final provider = Provider.of<BankDetailsProvider>(context,listen: false);
  provider.clearValues();
  provider.setControllersValues();
  provider.bankInfoApiFunction();
}

  @override
  Widget build(BuildContext context) {
    return Consumer<BankDetailsProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar(title: getTranslated('bank_details', context)!,isLeading: true,),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6,bottom: 6),
                  child: getText(title: getTranslated('holder_name', context)!,
                   size: 14, fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor, fontWeight: FontWeight.w500),
                ),
              RoundedTextField(controller: myProvider.holderNameController,
              errorMsg: myProvider.holderNameErrorMsg,
              textInputAction: TextInputAction.next,
              hintText: getTranslated('holder_name', context),
              isReadOnly: myProvider.isLoading,
              onChanged: (val){
                 myProvider.holderNameErrorMsg =
          AppValidation.bankValidation(val:myProvider.holderNameController.text,errorMsg: getTranslated('enter_holder_name', context)!);
          setState(() {});
              },
              ),
              ScreenSize.height(20),
                Padding(
                  padding: const EdgeInsets.only(left: 6,bottom: 6),
                  child: getText(title: getTranslated('bank_name', context)!,
                   size: 14, fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor, fontWeight: FontWeight.w500),
                ),
              RoundedTextField(controller: myProvider.bankNameController,
              errorMsg: myProvider.bankNameErrorMsg,
              textInputAction: TextInputAction.next,
              hintText: getTranslated('bank_name', context),
              isReadOnly: myProvider.isLoading,
              onChanged: (val){
                 myProvider.bankNameErrorMsg =
          AppValidation.bankValidation(val:myProvider.bankNameController.text,errorMsg: getTranslated('enter_bank_name', context)!);
          setState(() {});
              },),
              ScreenSize.height(20),
                Padding(
                  padding: const EdgeInsets.only(left: 6,bottom: 6),
                  child: getText(title: getTranslated('branch_name', context)!,
                   size: 14, fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor, fontWeight: FontWeight.w500),
                ),
              RoundedTextField(controller: myProvider.branchController,
              errorMsg: myProvider.branchNameErrorMsg,
              textInputAction: TextInputAction.next,
              hintText: getTranslated('branch_name', context),
              isReadOnly: myProvider.isLoading,
              onChanged: (val){
                myProvider.branchNameErrorMsg = AppValidation.bankValidation(val:myProvider.branchController.text,errorMsg: getTranslated('enter_branch_name', context)!);
                setState(() {});
              },),
              ScreenSize.height(20),
                Padding(
                  padding: const EdgeInsets.only(left: 6,bottom: 6),
                  child: getText(title: getTranslated('account_number', context)!,
                   size: 14, fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor, fontWeight: FontWeight.w500),
                ),
              RoundedTextField(controller: myProvider.accountNumberController,
              errorMsg: myProvider.accountNumberErrorMsg,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              textInputType: TextInputType.number,
              hintText: getTranslated('account_number', context),
              isReadOnly: myProvider.isLoading,
              onChanged: (val){
                myProvider.accountNumberErrorMsg = AppValidation.bankValidation(val:myProvider.accountNumberController.text,errorMsg: getTranslated('enter_account_number', context)!);
                setState(() {});
              },),
              const Spacer(),
              CustomButton(title: getTranslated('save', context)!,
               height: 50, width: double.infinity,
               isLoading: myProvider.isLoading,
                buttonColor: AppColor.appTheme, onTap: (){
                  if(!myProvider.isLoading){
                    myProvider.checkValidation(context);
                  }
                })
              ],
            ),
          ),
        );
      }
    );
  }
}