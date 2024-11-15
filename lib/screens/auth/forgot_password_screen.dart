import 'package:cn_delivery/provider/forgot_password_provider.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helper/appImages.dart';
import '../../helper/appbutton.dart';
import '../../helper/appcolor.dart';
import '../../helper/rounded_textfield.dart';
import '../../helper/fontfamily.dart';
import '../../helper/getText.dart';
import '../../helper/screensize.dart';
import '../../localization/language_constrants.dart';
import '../../utils/app_validation.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider  = Provider.of<ForgotPasswordProvider>(context,listen: false);
    provider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          appBar: appBar(title: '',isLeading: true),
          body: SingleChildScrollView(padding:const EdgeInsets.only(left: 20,right: 20,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  AppImages.appIcon,
                  // height: 80,
                  width: 165,
                  fit: BoxFit.cover,
                ),
              ),
              ScreenSize.height(40),
              getText(title: "${getTranslated('forgotPassword', context)!}?",
                  size: 22, fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor, fontWeight: FontWeight.w500),
              ScreenSize.height(10),
              getText(title: "${getTranslated('recoverYourPassword', context)!}?",
                  size: 15, fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor, fontWeight: FontWeight.w400),
              ScreenSize.height(50),
              RoundedTextField(
                controller: myProvider.emailController,
                hintText: getTranslated('enter_your_email', context)!,
                isReadOnly: myProvider.isLoading,
                errorMsg: myProvider.emailValidationMsg,
                onChanged: (val) {
                  myProvider.emailValidationMsg =
                      AppValidation.emailValidator(val);
                  setState(() {});
                },
                icon: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: ImageIcon(
                    const AssetImage(
                      AppImages.emailIcon,
                    ),
                    size: 24,
                    color: AppColor.blueColor,
                  ),
                ),
              ),
              ScreenSize.height(20),
              AppButton(
                  title: getTranslated('reset', context)!,
                  height: 49,
                  width: double.infinity,
                  buttonColor: AppColor.appTheme,
                  isLoading: myProvider.isLoading,
                  onTap: () {
                    myProvider.checkEmailValidation();
                    // AppRoutes.pushCupertinoNavigation(const OtpVerifyScreen(email: email, phone: phone))
                    // profileProvider.checkPasswordValidation();
                  })
            ],
          ),
          ),
        );
      }
    );
  }
}
