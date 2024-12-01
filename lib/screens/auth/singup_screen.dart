import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/getText.dart';
import 'package:cn_delivery/helper/image_picker_service.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/helper/rectangle_textfield.dart';
import 'package:cn_delivery/provider/signup_provider.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/image_bottom_sheet.dart';
import 'package:cn_delivery/widget/upload_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../localization/language_constrants.dart';
import '../../utils/utils.dart';
import '../../widget/customradio.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  int selectedGender = -1;
  String mobileError = '';
  final fomKey = GlobalKey<FormState>();
  @override
  void initState() {
    clearValues();
    // TODO: implement initState
    super.initState();
  }

  clearValues() {
    final provider = Provider.of<SignupProvider>(context, listen: false);
    provider.fNameController.clear();
    provider.lNameController.clear();
    provider.mobileController.clear();
    provider.emailController.clear();
    provider.addressController.clear();
    provider.genderController.clear();
    provider.passwordController.clear();
    provider.confirmPasswordController.clear();
    provider.vehicleNameController.clear();
    provider.vehicleTypeController.clear();
    provider.modelNumberController.clear();
    provider.domController.clear();
    provider.dorController.clear();
    provider.fuelController.clear();
    provider.licenceController.clear();
    provider.registrationController.clear();
    provider.profileImage = null;
    provider.passportImage = null;
    provider.licenceImage = null;
    provider.insuranceCopyImage = null;
    provider.touristPermitImage = null;
    provider.vehicleImage = null;
    provider.initCountry();
  }

  checkValidation() {
    final provider = Provider.of<SignupProvider>(context, listen: false);
    if (provider.mobileController.text.isEmpty) {
      mobileError = getTranslated('enter_mobile_number', context)!;
    } else if (provider.mobileController.text.length < 9) {
      mobileError = getTranslated('valid_number', context)!;
    } else {
      mobileError = '';
    }
    if (provider.profileImage == null) {
      Utils.errorSnackBar(
          getTranslated('upload_profile_image', context)!, context);
    } else if (provider.stateIdentityImage == null) {
      Utils.errorSnackBar(
          getTranslated('uploadStateIdentityImage', context)!, context);
    }
    if (fomKey.currentState!.validate() &&
        provider.profileImage != null &&
        provider.stateIdentityImage != null) {
      Provider.of<SignupProvider>(context, listen: false)
          .driverRegisterApiFunction();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            title: getTranslated('completeProfile', context)!, isLeading: true),
        body: Consumer<SignupProvider>(builder: (context, myProvider, child) {
          return Form(
            key: fomKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 profileImageWidget(myProvider),
                  ScreenSize.height(25),
                  getText(
                      title: getTranslated('first_name', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('enter_fName', context)!,
                    controller: myProvider.fNameController,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return getTranslated('enter_fName', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('last_name', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('enter_lName', context)!,
                    textInputAction: TextInputAction.next,
                    controller: myProvider.lNameController,
                    inputFormatters: [
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return getTranslated('enter_lName', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('mobile_number', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          myProvider.showCountryPicker();
                        },
                        child: Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color:
                                      AppColor.lightTextColor.withOpacity(.6))),
                          alignment: Alignment.center,
                          child: Text(
                            myProvider.selectedCountry != null
                                ? myProvider.selectedCountry!.callingCode
                                : '',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColor.textBlackColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: FontFamily.poppinsMedium),
                          ),
                          // color: Colors.red,
                        ),
                      ),
                      ScreenSize.width(10),
                      Expanded(
                          child: mobileTextField(
                        controller: myProvider.mobileController,
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 75),
                    child: getText(
                        title: mobileError,
                        size: 13,
                        fontFamily: FontFamily.nunitoMedium,
                        color: AppColor.redColor,
                        fontWeight: FontWeight.w400),
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('email_address', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('email_address', context)!,
                    controller: myProvider.emailController,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return getTranslated('enter_email_address', context)!;
                      } else if (!Utils.isValidEmail(val)) {
                        return getTranslated('enter_valid_email', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('address', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('enter_address', context)!,
                    textInputAction: TextInputAction.next,
                    controller: myProvider.addressController,
                    inputFormatters: [
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return getTranslated('enter_your_address', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('departmentCity', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('enter_department_city', context)!,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                    controller: myProvider.cityController,
                    validator: (val) {
                      if (val.isEmpty) {
                        return getTranslated('enter_department_city', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('country', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('enter_your_country', context)!,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                    controller: myProvider.countryController,
                    validator: (val) {
                      if (val.isEmpty) {
                        return getTranslated('enter_your_country', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('gender', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('select_gender', context)!,
                    isReadOnly: true,
                    textInputAction: TextInputAction.next,
                    controller: myProvider.genderController,
                    onTap: () {
                      genderBottomSheet();
                    },
                    validator: (val) {
                      // if (val.isEmpty) {
                      //   return getTranslated('select_your_gender', context)!;
                      // }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('password', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('enterPassword', context)!,
                    controller: myProvider.passwordController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny( RegExp(r'\s')),
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val.isEmpty) {
                        return getTranslated('enter_password', context)!;
                      } else if (val.length<6) {
                       return getTranslated( 'passwordLenghtValidation', navigatorKey.currentContext!)!;
                        }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('confirm_password', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  RectangleTextfield(
                    hintText: getTranslated('enter_confirm_password', context)!,
                    textInputAction: TextInputAction.done,
                    controller: myProvider.confirmPasswordController,
                    inputFormatters: [
                       FilteringTextInputFormatter.deny( RegExp(r'\s')),
                       FilteringTextInputFormatter.deny(RegExp(Utils.regexToRemoveEmoji))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return getTranslated(
                            'enter_confirm_password', context)!;
                      }else if (val.length<6) {
                  return getTranslated( 'passwordLenghtValidation', navigatorKey.currentContext!)!;
                         }
                          else if (val != myProvider.passwordController.text) {
                        return getTranslated('password_not_match', context)!;
                      }
                    },
                  ),
                  ScreenSize.height(15),
                  getText(
                      title: getTranslated('stateIdentityImage', context)!,
                      size: 12,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(6),
                  uploadImageWidget(
                      onTap: () {
                        imageBottomSheet(context, cameraTap: () {
                          ImagePickerService
                              .imagePicker(context, ImageSource.camera)
                              .then((val) {
                            if (val != null) {
                              myProvider.stateIdentityImage = val;
                              setState(() {});
                              Navigator.pop(context);
                            }
                          });
                        }, galleryTap: () {
                          ImagePickerService
                              .imagePicker(context, ImageSource.gallery)
                              .then((val) {
                            if (val != null) {
                              myProvider.stateIdentityImage = val;
                              setState(() {});
                              Navigator.pop(context);
                            }
                          });
                        });
                      },
                      imgPath: myProvider.stateIdentityImage),
                  ScreenSize.height(25),
                  AppButton(
                      title: getTranslated('next', context)!,
                      height: 56,
                      width: double.infinity,
                      buttonColor: AppColor.appTheme,
                      onTap: () {
                        checkValidation();
                      })
                ],
              ),
            ),
          );
        }));
  }

profileImageWidget(SignupProvider myProvider){
  return      Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 100,
                      child: Stack(
                        children: [
                          Container(
                            height: 102,
                            width: 102,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4, color: AppColor.blueColor),
                            ),
                            child: myProvider.profileImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      myProvider.profileImage!,
                                      fit: BoxFit.cover,
                                    ))
                                : Icon(
                                    Icons.person_2,
                                    color: AppColor.borderD9Color,
                                    size: 50,
                                  ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                imageBottomSheet(context, cameraTap: () {
                                  ImagePickerService
                                      .imagePicker(context, ImageSource.camera)
                                      .then((val) {
                                    if (val != null) {
                                      myProvider.profileImage = val;
                                      setState(() {});
                                      Navigator.pop(context);
                                    }
                                  });
                                }, galleryTap: () {
                                  ImagePickerService
                                      .imagePicker(context, ImageSource.gallery)
                                      .then((val) {
                                    if (val != null) {
                                      myProvider.profileImage = val;
                                      setState(() {});
                                      Navigator.pop(context);
                                    }
                                  });
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.borderColor),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  AppImages.editIcon,
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
}

  genderBottomSheet() {
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getText(
                          title: getTranslated('select_gender', context)!,
                          size: 18,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w500),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
                      )
                    ],
                  ),
                  ScreenSize.height(20),
                  GestureDetector(
                    onTap: () {
                      selectedGender = 0;
                      Provider.of<SignupProvider>(context, listen: false)
                          .genderController
                          .text = 'Male';
                      Navigator.pop(context);
                      state(() {});
                    },
                    child: Container(
                      color: AppColor.whiteColor,
                      height: 30,
                      child: Row(
                        children: [
                          customRadio(0, selectedGender),
                          ScreenSize.width(15),
                          getText(
                              title: getTranslated('male', context)!,
                              size: 16,
                              fontFamily: FontFamily.nunitoMedium,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  ),
                  ScreenSize.height(10),
                  GestureDetector(
                    onTap: () {
                      selectedGender = 1;
                      Provider.of<SignupProvider>(context, listen: false)
                          .genderController
                          .text = 'Female';
                      state(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: AppColor.whiteColor,
                      height: 30,
                      child: Row(
                        children: [
                          customRadio(1, selectedGender),
                          ScreenSize.width(15),
                          getText(
                              title: getTranslated('female', context)!,
                              size: 16,
                              fontFamily: FontFamily.nunitoMedium,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  mobileTextField({FocusNode? focusNode, TextEditingController? controller}) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12)
      ],
      controller: controller,
      autofocus: false,
      style: TextStyle(
          fontSize: 14,
          color: AppColor.textBlackColor,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.poppinsMedium),
      cursorColor: AppColor.blackColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: mobileError.isNotEmpty
                    ? AppColor.redColor
                    : AppColor.lightTextColor,
                width: 1),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: mobileError.isNotEmpty
                    ? AppColor.redColor
                    : AppColor.lightTextColor.withOpacity(.6),
                width: 1),
            borderRadius: BorderRadius.circular(5)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: mobileError.isNotEmpty
                    ? AppColor.redColor
                    : AppColor.lightTextColor.withOpacity(.6),
                width: 1),
            borderRadius: BorderRadius.circular(5)),
        hintText: getTranslated('enter_mobile_number', context)!,
        hintStyle: const TextStyle(
            fontSize: 14,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.nunitoMedium),
      ),
    );
  }
}
