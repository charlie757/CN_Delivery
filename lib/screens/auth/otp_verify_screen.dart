import 'package:cn_delivery/api/api_url.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/getText.dart';
import 'package:cn_delivery/provider/otp_verify_provider.dart';
import 'package:cn_delivery/screens/auth/choose_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../helper/appImages.dart';
import '../../helper/appcolor.dart';
import '../../helper/screensize.dart';
import '../../localization/language_constrants.dart';
import 'package:provider/provider.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String email;
  final String phone;
  final String route;
  const OtpVerifyScreen({required this.email,required this.phone, required this.route});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final otpController = TextEditingController();
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<OtpVerifyProvider>(context, listen: false);
    provider.resetValues();
    provider.startTimer();
    provider.url = widget.route=='forgot'?ApiUrl.verifyForgotOtpUrl:ApiUrl.verifyOtpUrl;
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpVerifyProvider>(builder: (context,myProvider,child){
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.appIcon,
                      // height: 80,
                      width: 165,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ScreenSize.height(40),
                  getText(title: getTranslated('EnterThe4DigitOtp', context)!,
                      size: 20, fontFamily: FontFamily.poppinsRegular, color: AppColor.blackColor, fontWeight: FontWeight.w400),
                  ScreenSize.height(5),
                  Text.rich(TextSpan(
                      text: getTranslated('sendTo', context)!,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                          fontFamily: FontFamily.poppinsRegular),
                      children: [
                        TextSpan(
                            text: ' ${widget.phone.isEmpty?widget.email:widget.phone}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.appTheme,
                                fontFamily: FontFamily.poppinsBold))
                      ])),
                  ScreenSize.height(12),
                  otpField(context, myProvider),
                  ScreenSize.height(4),
                  myProvider.resend
                      ? getText(
                      title: getTranslated('resendOtp', context)!,
                      size: 14,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w500)
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (myProvider.counter <= 0) {
                            myProvider.resendApiFunction(
                                widget.email);
                          }
                        },
                        child: getText(
                            title:
                            "${getTranslated('resendOtp', context)!} ${myProvider.counter <= 0 ? '' : getTranslated('in', context)!}",
                            size: 14,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w500),
                      ),
                      myProvider.counter <= 0
                          ? Container()
                          : getText(
                          title: "  ${myProvider.counter}",
                          size: 14,
                          fontFamily: FontFamily.poppinsBold,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w500)
                    ],
                  ),
                  ScreenSize.height(20),
                  AppButton(
                      title: getTranslated('continue', context)!,
                      isLoading: myProvider.isLoading,
                    height: 56,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseVehicleScreen()));
                        // if(formKey.currentState!.validate()){
                        //  myProvider.isLoading?null: myProvider.verifyApiFunction(widget.email, otpController.text);
                        // }
                      },)

                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  otpField(BuildContext context, OtpVerifyProvider provider) {
    return SizedBox(
      width: 220,
      // height: 48,
      child: PinCodeTextField(
        readOnly: provider.isLoading,
        controller: otpController,
        cursorColor: AppColor.blueColor,
        autovalidateMode: AutovalidateMode.disabled,
        cursorHeight: 20,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(
            5,
          ),
          activeColor: AppColor.lightAppColor,
          disabledColor: AppColor.lightAppColor,
          selectedColor: AppColor.lightAppColor,
          inactiveColor: AppColor.lightAppColor,
          fieldHeight: 48,
          fieldWidth: 48,
          inactiveFillColor: AppColor.lightAppColor,
          selectedFillColor: Colors.white,
          activeFillColor: AppColor.lightAppColor,
        ),
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        length: 4,
        animationDuration: const Duration(milliseconds: 300),
        appContext: context,
        keyboardType: TextInputType.number,
        textStyle: TextStyle(
            color: AppColor.blackColor, fontFamily: FontFamily.poppinsRegular),
        enableActiveFill: true,
        onChanged: (val) {},
        onCompleted: (result) {},
        validator: (val) {
          if (val!.isEmpty) {
            return 'Enter otp';
          } else if (val.length < 4) {
            return 'Enter otp should be valid';
          }
          return null;
        },
      ),
    );
  }

}
