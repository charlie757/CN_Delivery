import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/rounded_textfield.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/login_provider.dart';
import 'package:cn_delivery/screens/auth/forgot_password_screen.dart';
import 'package:cn_delivery/screens/auth/singup_screen.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/location_service.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/top_logo.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    LocationService.getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Consumer<LoginProvider>(builder: (context, myProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15, right: 15,top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topLogo(alignment: Alignment.centerLeft),
                ScreenSize.height(40),
                Row(
                  children: [
                    getText(
                        title: getTranslated('welcome_back', context)!,
                        size: 23,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.width(6),
                    Image.asset(
                      AppImages.handEmoji,
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
                Row(
                  children: [
                    AutoSizeText(
                      "${getTranslated('to', context)!} ",
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                      minFontSize: 16,
                      maxLines: 1,
                    ),
                    Flexible(
                      child: AutoSizeText(
                        getTranslated('cnsumers_Networks', context)!,
                        style:const TextStyle(
                            fontSize: 23,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.blueColor,
                            fontWeight: FontWeight.w600),
                        minFontSize: 16,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                ScreenSize.height(20),
                RoundedTextField(
                  controller: myProvider.emailController,
                  hintText: getTranslated('enter_your_email', context)!,
                  isReadOnly: myProvider.isLoading,
                  errorMsg: myProvider.emailValidationMsg,
                   inputFormatters: [
                      FilteringTextInputFormatter.deny( RegExp(r'\s')),
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    myProvider.emailValidationMsg =
                        AppValidation.emailValidator(val);
                    setState(() {});
                  },
                  prefixIcon: const ImageIcon(
                     AssetImage(
                      AppImages.emailIcon,
                    ),
                    size: 24,
                    color: AppColor.blueColor,
                  ),
                ),
                ScreenSize.height(25),
                RoundedTextField(
                  controller: myProvider.passwordController,
                  hintText: getTranslated('enter_your_password', context)!,
                  isReadOnly: myProvider.isLoading,
                  isObscureText: myProvider.isVisiblePassword,
                   inputFormatters: [
                      FilteringTextInputFormatter.deny( RegExp(r'\s')),
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                  errorMsg: myProvider.passwordValidationMsg,
                  onChanged: (val) {
                    myProvider.passwordValidationMsg =
                        AppValidation.passwordValidator(val);
                    setState(() {});
                  },
                  prefixIcon: const ImageIcon(
                     AssetImage(
                      AppImages.passwordIcon,
                    ),
                    color: AppColor.blueColor,
                    size: 24,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      if(myProvider.isVisiblePassword){
                        myProvider.updateIsVisiblePassword(false);
                      }else{
                        myProvider.updateIsVisiblePassword(true);
                      }
                    },
                    child: Icon(
                     myProvider.isVisiblePassword?
                     Icons.visibility_outlined:Icons.visibility_off_outlined,color: AppColor.blueColor.withOpacity(.7),),
                  ),
                ),
                ScreenSize.height(15),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      AppRoutes.pushCupertinoNavigation(const ForgotPasswordScreen());
                    },
                    child: getText(
                        title: getTranslated('forgotPassword', context)!,
                        size: 14,
                        fontFamily: FontFamily.poppinsMedium,
                        color: AppColor.blueColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ScreenSize.height(40),
                AppButton(
                    title: getTranslated('sign_in', context)!,
                    height: 56,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                    isLoading: myProvider.isLoading,
                    onTap: () {
                      LocationService.getCurrentLocation();
                      myProvider.isLoading
                          ? null
                          : myProvider.checkValidation();
                    }),
                ScreenSize.height(20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   getText(title: "${getTranslated('donTHaveAnAccount', context)!} ", size: 14, fontFamily: FontFamily.nunitoRegular,
                       color: AppColor.blackColor, fontWeight: FontWeight.w400),
                   GestureDetector(
                     onTap: (){
                       AppRoutes.pushCupertinoNavigation(const SingUpScreen());
                     },
                     child: getText(title: getTranslated('register', context)!, size: 14, fontFamily: FontFamily.nunitoMedium,
                         color: AppColor.blueColor, fontWeight: FontWeight.w500),
                   ),
                 ],
               )
              ],
            ),
          );
        }),
      ),
    );
  }
}
