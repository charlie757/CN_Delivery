import 'dart:io';

import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/rounded_textfield.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/image_picker_service.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/profile_provider.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/upper_case.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/dialog_box.dart';
import 'package:cn_delivery/widget/language_dialogbox.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/customradio.dart';
import '../../widget/image_bottom_sheet.dart';
import '../../widget/upload_image_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<ProfileProvider>(context, listen: false);
    myProvider.clearValues();
    Future.delayed(Duration.zero, () {
      myProvider.getProfileApiFunction(true);
      myProvider.setValuesInController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: profileAppBar(
            value: myProvider.isOnline,
            onChanged: (val) {
              myProvider.updateInOnline(val);
            },
            onTap: () {
              openBottomSheetOptions();
            }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tabBar(myProvider),
            Expanded(
                child: myProvider.tabBarIndex == 0
                    ? personalInfoWidget(myProvider)
                    : myProvider.tabBarIndex == 1
                        ? vehicleInfoWidget(myProvider)
                        : changePasswordWidget(myProvider))
          ],
        ),
      );
    });
  }

  tabBar(ProfileProvider profileProvider) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            tabBarItems(index: 0, title: getTranslated('personal_info', context)!,
             profileProvider: profileProvider),
            ScreenSize.width(10),
            tabBarItems(index: 1, title: getTranslated('vehicle_info', context)!,
             profileProvider: profileProvider),
            ScreenSize.width(10),
            tabBarItems(index: 2, title: getTranslated('change_password', context)!,
             profileProvider: profileProvider,width: 180),
          ],
        ),
      ),
    );
  }

  tabBarItems(
      {required int index,
      required String title,
      double width=120,
      required ProfileProvider profileProvider}) {
    return GestureDetector(
      onTap: () {
        profileProvider.updateTabBarIndex(index);
      },
      child: Container(
        color: Colors.white,
        height: 50,
        width: width,
        child: Column(
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: profileProvider.tabBarIndex == index
                      ? AppColor.blueColor
                      : AppColor.blackColor,
                  fontWeight: FontWeight.w600),
            ),
            ScreenSize.height(15),
            Container(
              height: profileProvider.tabBarIndex == index ? 4 : 1,
              color: profileProvider.tabBarIndex == index
                  ? AppColor.blueColor
                  : const Color(0xffD9D9D9),
            )
          ],
        ),
      ),
    );
  }

  personalInfoWidget(ProfileProvider profileProvider) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 102,
                  width: 102,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 4, color: AppColor.blueColor),
                  ),
                  child: profileProvider.imgFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(profileProvider.imgFile!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : profileProvider.profileImgUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: NetworkImagehelper(
                                img: profileProvider.profileImgUrl,
                              ))
                          : Image.asset(
                              'assets/images/profileImg.png',
                              fit: BoxFit.cover,
                            ),
                ),
                ScreenSize.width(30),
                GestureDetector(
                  onTap: () {
                    imageBottomSheet(context, cameraTap: () {
                      ImagePickerService.imagePicker(
                              context, ImageSource.camera)
                          .then((val) {
                        if (val != null) {
                          profileProvider.imgFile = val;
                          setState(() {});
                          Navigator.pop(context);
                        }
                      });
                    }, galleryTap: () {
                      ImagePickerService.imagePicker(
                              context, ImageSource.gallery)
                          .then((val) {
                        if (val != null) {
                          profileProvider.imgFile = val;
                          setState(() {});
                          Navigator.pop(context);
                        }
                      });
                    });
                    // imagePickerBottomSheet(profileProvider);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColor.blueColor),
                        borderRadius: BorderRadius.circular(40)),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 17, right: 17),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.editIcon,
                          height: 24,
                          width: 24,
                        ),
                        ScreenSize.width(12),
                        getText(
                            title: getTranslated('change_picture', context)!,
                            size: 12,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.blueColor,
                            fontWeight: FontWeight.w400)
                      ],
                    ),
                  ),
                )
              ],
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.firstNameController,
              hintText: getTranslated('first_name', context)!,
              errorMsg: profileProvider.fNameErrorMsg,
              isReadOnly: profileProvider.profileLoading,
              onChanged: (val) {
                profileProvider.fNameErrorMsg =
                    AppValidation.firstNameValidator(val);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: const ImageIcon(
                  AssetImage(
                    AppImages.profileIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.lastNameController,
              hintText: getTranslated('last_name', context)!,
              errorMsg: profileProvider.lNameErrorMsg,
              isReadOnly: profileProvider.profileLoading,
              onChanged: (val) {
                profileProvider.lNameErrorMsg =
                    AppValidation.lastNameValidator(val);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child:const ImageIcon(
                   AssetImage(
                    AppImages.profileIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.mobileController,
              hintText: getTranslated('mobile_number', context)!,
              isReadOnly: true,
              textInputType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ],
              errorMsg: profileProvider.phonErrorMsg,
              onChanged: (val) {
                profileProvider.phonErrorMsg =
                    AppValidation.phoneNumberValidator(val);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child:const ImageIcon(
                   AssetImage(
                    AppImages.callIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.emailController,
              hintText: getTranslated('email_address', context)!,
              errorMsg: profileProvider.emailErrorMsg,
              isReadOnly: true,
              onChanged: (val) {
                profileProvider.emailErrorMsg =
                    AppValidation.emailValidator(val);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child:const ImageIcon(
                   AssetImage(
                    AppImages.emailIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.addressController,
              hintText: getTranslated('address', context)!,
              isReadOnly: profileProvider.profileLoading,
              errorMsg: profileProvider.addressErrorMsg,
              onChanged: (val) {
                profileProvider.addressErrorMsg =
                    AppValidation.addressValidator(val);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child:const ImageIcon(
                   AssetImage(
                    AppImages.locationIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.cityController,
              hintText: getTranslated('enter_department_city', context)!,
              isReadOnly: profileProvider.profileLoading,
              errorMsg: profileProvider.cityErrorMsg,
              onChanged: (val) {
                profileProvider.cityErrorMsg = AppValidation.cityValidator(val);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child:const ImageIcon(
                   AssetImage(
                    AppImages.locationIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.countryController,
              hintText: getTranslated('enter_your_country', context)!,
              isReadOnly: profileProvider.profileLoading,
              errorMsg: profileProvider.countyErrorMsg,
              onChanged: (val) {
                profileProvider.countyErrorMsg =
                    AppValidation.countryValidator(val);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child:const ImageIcon(
                   AssetImage(
                    AppImages.locationIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.genderController,
              hintText: getTranslated('gender', context)!,
              isReadOnly: true,
              errorMsg: profileProvider.genderErrorMsg,
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child:const ImageIcon(
                   AssetImage(
                    AppImages.profileIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
              onTap: () {
                genderBottomSheet();
              },
            ),
            ScreenSize.height(20),
            getText(
                title: getTranslated('stateIdentityImage', context)!,
                size: 12,
                fontFamily: FontFamily.poppinsMedium,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w400),
            ScreenSize.height(6),
            uploadImageWidget(
                onTap: () {
                  imageBottomSheet(context, cameraTap: () {
                    ImagePickerService.imagePicker(context, ImageSource.camera)
                        .then((val) {
                      if (val != null) {
                        profileProvider.stateIdentityImage = val;
                        setState(() {});
                        Navigator.pop(context);
                      }
                    });
                  }, galleryTap: () {
                    ImagePickerService.imagePicker(context, ImageSource.gallery)
                        .then((val) {
                      if (val != null) {
                        profileProvider.stateIdentityImage = val;
                        setState(() {});
                        Navigator.pop(context);
                      }
                    });
                  });
                },
                imgPath: profileProvider.stateIdentityImage,
                imgUrl: profileProvider.profileModel != null &&
                        profileProvider.profileModel!.data != null
                    ? profileProvider.profileModel!.data!.identityImage ?? ""
                    : ""),
            ScreenSize.height(50),
            AppButton(
                title: getTranslated('update_profile', context)!,
                height: 49,
                width: double.infinity,
                buttonColor: AppColor.appTheme,
                isLoading: profileProvider.profileLoading,
                onTap: () {
                  profileProvider.checkUpdateProfileValidation();
                }),
            ScreenSize.height(20),
            chanegeLanguageButton(profileProvider)
          ],
        ),
      ),
    );
  }

  vehicleInfoWidget(ProfileProvider profileProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
      child: Column(
        children: [
          RoundedTextField(
            controller: profileProvider.vehicleTypeController,
            hintText: getTranslated('vehicle_type', context)!,
            isReadOnly: true,
            errorMsg: profileProvider.vehicleTypeErrorMsg,
            onTap: () {
              vehicleTypeBottomSheet();
            },
            onChanged: (val) {
              profileProvider.vehicleTypeErrorMsg =
                  AppValidation.vehicleTypeValidator(val);
              setState(() {});
            },
            prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(
                  Icons.card_travel,
                  color: AppColor.blueColor.withOpacity(.7),
                )),
          ),
          ScreenSize.height(20),
          profileProvider.vehicleTypeController.text.toLowerCase() == 'bicycle'
              ? bicycleInfoWidget(profileProvider)
              : carAndBikeVehicleInfoWidget(profileProvider),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: AppButton(
                title: getTranslated('update_vehicle_info', context)!,
                height: 49,
                width: double.infinity,
                buttonColor: AppColor.appTheme,
                isLoading: profileProvider.profileLoading,
                onTap: () {
                  if (profileProvider.vehicleTypeController.text
                          .toLowerCase() ==
                      'bicycle') {
                    profileProvider.checkBicycleValidation();
                  } else {
                    profileProvider.checkCarAndBikeVehicleInfoValidation();
                  }
                }),
          ),
        ],
      ),
    );
  }

  bicycleInfoWidget(ProfileProvider profileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundedTextField(
          controller: profileProvider.vehicleBrandController,
          hintText: getTranslated('enter_brand_name', context)!,
          isReadOnly: false,
          errorMsg: profileProvider.vehicleBrandErrorMsg,
          onChanged: (val) {
            profileProvider.vehicleBrandErrorMsg =
                AppValidation.vehicleBrandValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                Icons.card_travel,
                color: AppColor.blueColor.withOpacity(.7),
              )),
        ),
        ScreenSize.height(20),
        RoundedTextField(
          controller: profileProvider.vehicleSizeController,
          hintText: getTranslated('enter_vehicle_size', context)!,
          isReadOnly: false,
          errorMsg: profileProvider.vehicleSizeErrorMsg,
          onChanged: (val) {
            profileProvider.vehicleSizeErrorMsg =
                AppValidation.vehicleSizeValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                Icons.card_travel,
                color: AppColor.blueColor.withOpacity(.7),
              )),
        ),
        ScreenSize.height(20),
        RoundedTextField(
          controller: profileProvider.vehicleColorController,
          hintText: getTranslated('enter_vehicle_color', context)!,
          isReadOnly: false,
          errorMsg: profileProvider.vehicleColorErrorMsg,
          onChanged: (val) {
            profileProvider.vehicleColorErrorMsg =
                AppValidation.vehicleColorValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                Icons.card_travel,
                color: AppColor.blueColor.withOpacity(.7),
              )),
        ),
        ScreenSize.height(20),
        getText(
            title: getTranslated('vehicle_image', context)!,
            size: 12,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w400),
        ScreenSize.height(6),
        uploadImageWidget(
            onTap: () {
              imageBottomSheet(context, cameraTap: () {
                ImagePickerService.imagePicker(context, ImageSource.camera)
                    .then((val) {
                  if (val != null) {
                    profileProvider.vehicleImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              }, galleryTap: () {
                ImagePickerService.imagePicker(context, ImageSource.gallery)
                    .then((val) {
                  if (val != null) {
                    profileProvider.vehicleImage = val;
                    setState(() {});
                    Navigator.pop(context);
                  }
                });
              });
            },
            imgPath: profileProvider.vehicleImage,
            imgUrl: profileProvider.vehicleInfoModel != null &&
                    profileProvider.vehicleInfoModel!.data != null &&
                    profileProvider.vehicleInfoModel!.data!.vehicleType
                            .toString()
                            .toLowerCase() ==
                        'bicycle'
                ? profileProvider.vehicleInfoModel!.data!.vehicleImage ?? ""
                : ""),
      ],
    );
  }

  carAndBikeVehicleInfoWidget(ProfileProvider profileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundedTextField(
          controller: profileProvider.vehicleNameController,
          hintText: getTranslated('vehicle_name', context)!,
          isReadOnly: false,
          textInputAction: TextInputAction.next,
          errorMsg: profileProvider.vehicleNameErrorMsg,
          onChanged: (val) {
            profileProvider.vehicleNameErrorMsg =
                AppValidation.vehicleNameValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                Icons.card_travel,
                color: AppColor.blueColor.withOpacity(.7),
              )),
        ),
        ScreenSize.height(20),
        RoundedTextField(
          controller: profileProvider.vehicleBrandController,
          hintText: getTranslated('enter_brand_name', context)!,
          isReadOnly: false,
          textInputAction: TextInputAction.next,
          errorMsg: profileProvider.vehicleBrandErrorMsg,
          onChanged: (val) {
            profileProvider.vehicleBrandErrorMsg =
                AppValidation.vehicleBrandValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                Icons.card_travel,
                color: AppColor.blueColor.withOpacity(.7),
              )),
        ),
        ScreenSize.height(20),
        RoundedTextField(
          controller: profileProvider.modelNumberController,
          hintText: getTranslated('enter_model_number', context)!,
          isReadOnly: false,
          textInputAction: TextInputAction.next,
          errorMsg: profileProvider.modelNumberErrorMsg,
          onChanged: (val) {
            profileProvider.modelNumberErrorMsg =
                AppValidation.modelNumberValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                Icons.card_travel,
                color: AppColor.blueColor.withOpacity(.7),
              )),
        ),
        ScreenSize.height(20),
        RoundedTextField(
          controller: profileProvider.dorController,
          hintText: getTranslated('select_registration_date', context)!,
          isReadOnly: true,
          textInputAction: TextInputAction.next,
          errorMsg: profileProvider.dorErrorMsg,
          onTap: () {
            profileProvider
                .datePicker(profileProvider.selectedDORDate)
                .then((val) {
              if (val != null) {
                profileProvider.selectedDORDate = val;
                profileProvider.dorController.text =
                    "${val.day.toString().length == 1 ? "0${val.day}" : val.day}-${val.month.toString().length == 1 ? "0${val.month}" : val.month}-${val.year}";
              }
            });
          },
          onChanged: (val) {
            profileProvider.dorErrorMsg =
                AppValidation.dateOfRegistrationValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                Icons.date_range,
                color: AppColor.blueColor.withOpacity(.7),
              )),
        ),
        ScreenSize.height(20),
        RoundedTextField(
          controller: profileProvider.vehicleRegistrationController,
          hintText: getTranslated('registration_number', context)!,
          isReadOnly: false,
          textInputAction: TextInputAction.next,
          errorMsg: profileProvider.vehicleRegistrationErrorMsg,
          inputFormatters: [
            UpperCaseTextFormatter()
          ],
          onChanged: (val) {
            profileProvider.vehicleRegistrationErrorMsg =
                AppValidation.vehicleRegistrationValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: const Icon(
                Icons.card_travel,
                color: AppColor.blueColor,
              )),
        ),
        ScreenSize.height(20),
        RoundedTextField(
          controller: profileProvider.vehicleLicenseController,
          hintText: getTranslated('enter_licence_number', context)!,
          isReadOnly: false,
          textInputAction: TextInputAction.next,
          errorMsg: profileProvider.vehicleLicenseErrorMsg,
          onChanged: (val) {
            profileProvider.vehicleLicenseErrorMsg =
                AppValidation.vehicleLicenseValidator(val);
            setState(() {});
          },
          prefixIcon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: const Icon(
                Icons.card_travel,
                color: AppColor.blueColor,
              )),
        ),
        ScreenSize.height(20),
        profileProvider.vehicleTypeController.text.toLowerCase() == 'motorcycle'
            ? bikeImages(profileProvider)
            : carImages(profileProvider)
      ],
    );
  }

  bikeImages(ProfileProvider profileProvider) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: "${getTranslated('vehicle_image', context)!}-1",
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.vehicleImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.vehicleImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.vehicleImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'motorcycle'
                        ? profileProvider
                                .vehicleInfoModel!.data!.vehicleImage ??
                            ""
                        : ""),
              ],
            )),
            ScreenSize.width(15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: "${getTranslated('vehicle_image', context)!}-2",
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.vehicleImage2 = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.vehicleImage2 = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.vehicleImage2,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'motorcycle'
                        ? profileProvider
                                .vehicleInfoModel!.data!.vehicleImageTwo ??
                            ""
                        : ""),
              ],
            ))
          ],
        ),
        ScreenSize.height(20),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: getTranslated('licence_image', context)!,
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.licenceImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.licenceImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.licenceImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'motorcycle'
                        ? profileProvider
                                .vehicleInfoModel!.data!.vehicleLicenseImage ??
                            ""
                        : ""),
              ],
            )),
            ScreenSize.width(15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: getTranslated('insurance_copy', context)!,
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.insuranceCopyImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.insuranceCopyImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.insuranceCopyImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'motorcycle'
                        ? profileProvider.vehicleInfoModel!.data!
                                .vehicleInsuranceImage ??
                            ""
                        : ""),
              ],
            ))
          ],
        ),
        ScreenSize.height(20),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: getTranslated('inspection_certificate', context)!,
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.inspectionImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.inspectionImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.inspectionImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'motorcycle'
                        ? profileProvider.vehicleInfoModel!.data!
                                .vehicleInspectionImage ??
                            ""
                        : ""),
              ],
            )),
            ScreenSize.width(15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title:
                      getTranslated('ceriminal_record_certificate', context)!,
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.criminalRecordImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.criminalRecordImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.criminalRecordImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'motorcycle'
                        ? profileProvider.vehicleInfoModel!.data!
                                .vehicleCriminalRecordImage ??
                            ""
                        : ""),
              ],
            ))
          ],
        ),
      ],
    );
  }

  carImages(ProfileProvider profileProvider) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: "${getTranslated('vehicle_image', context)!}-1",
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.vehicleImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.vehicleImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.vehicleImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'car'
                        ? profileProvider
                                .vehicleInfoModel!.data!.vehicleImage ??
                            ""
                        : ""),
              ],
            )),
            ScreenSize.width(15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: "${getTranslated('vehicle_image', context)!}-2",
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.vehicleImage2 = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.vehicleImage2 = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.vehicleImage2,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'car'
                        ? profileProvider
                                .vehicleInfoModel!.data!.vehicleImageTwo ??
                            ""
                        : ""),
              ],
            ))
          ],
        ),
        ScreenSize.height(20),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: getTranslated('licence_image', context)!,
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.licenceImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.licenceImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.licenceImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'car'
                        ? profileProvider
                                .vehicleInfoModel!.data!.vehicleLicenseImage ??
                            ""
                        : ""),
              ],
            )),
            ScreenSize.width(15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: getTranslated('insurance_copy', context)!,
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.insuranceCopyImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.insuranceCopyImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.insuranceCopyImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'car'
                        ? profileProvider.vehicleInfoModel!.data!
                                .vehicleInsuranceImage ??
                            ""
                        : ""),
              ],
            ))
          ],
        ),
        ScreenSize.height(20),
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title: getTranslated('inspection_certificate', context)!,
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.inspectionImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.inspectionImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.inspectionImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'car'
                        ? profileProvider.vehicleInfoModel!.data!
                                .vehicleInspectionImage ??
                            ""
                        : ""),
              ],
            )),
            ScreenSize.width(15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenSize.height(20),
                getText(
                  title:
                      getTranslated('ceriminal_record_certificate', context)!,
                  size: 12,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                  maxLies: 1,
                ),
                ScreenSize.height(6),
                uploadImageWidget(
                    onTap: () {
                      imageBottomSheet(context, cameraTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.camera)
                            .then((val) {
                          if (val != null) {
                            profileProvider.criminalRecordImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      }, galleryTap: () {
                        ImagePickerService.imagePicker(
                                context, ImageSource.gallery)
                            .then((val) {
                          if (val != null) {
                            profileProvider.criminalRecordImage = val;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        });
                      });
                    },
                    imgPath: profileProvider.criminalRecordImage,
                    imgUrl: profileProvider.vehicleInfoModel != null &&
                            profileProvider.vehicleInfoModel!.data != null &&
                            profileProvider.vehicleInfoModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                'car'
                        ? profileProvider.vehicleInfoModel!.data!
                                .vehicleCriminalRecordImage ??
                            ""
                        : ""),
              ],
            ))
          ],
        ),
      ],
    );
  }

  chanegeLanguageButton(ProfileProvider profileProvider) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 7,
          shadowColor: AppColor.blueColor,
          backgroundColor: AppColor.blueColor,
          // primary: widget.buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      onPressed: () {
        SessionManager.languageCode == 'es'
            ? profileProvider.selectedLangIndex = 1
            : 0;
        openLanguageBox(profileProvider);
      },
      child: Container(
        alignment: Alignment.center,
        height: 49,
        width: double.infinity,
        child: getText(
            title: getTranslated('change_language', context)!,
            size: 20,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  changePasswordWidget(ProfileProvider profileProvider) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTextField(
              controller: profileProvider.oldPasswordController,
              hintText: getTranslated('old_Password', context)!,
              errorMsg: profileProvider.oldPasswordErrorMsg,
              onChanged: (val) {
                profileProvider.oldPasswordErrorMsg =
                    AppValidation.passwordValidator(val);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: const ImageIcon(
                  AssetImage(
                    AppImages.passwordIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.newPasswordController,
              hintText: getTranslated('new_password', context)!,
              errorMsg: profileProvider.newPasswordErrorMsg,
              onChanged: (val) {
                profileProvider.newPasswordErrorMsg =
                    AppValidation.reEnterpasswordValidator(
                        val, profileProvider.confirmPasswordController.text);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: const ImageIcon(
                  AssetImage(
                    AppImages.passwordIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            RoundedTextField(
              controller: profileProvider.confirmPasswordController,
              hintText: getTranslated('confirm_password', context)!,
              errorMsg: profileProvider.confirmNewPasswordErrorMsg,
              onChanged: (val) {
                profileProvider.confirmNewPasswordErrorMsg =
                    AppValidation.reEnterpasswordValidator(
                        val, profileProvider.newPasswordController.text);
                setState(() {});
              },
              prefixIcon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: const ImageIcon(
                  const AssetImage(
                    AppImages.passwordIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(50),
            AppButton(
                title: getTranslated('update_password', context)!,
                height: 49,
                width: double.infinity,
                buttonColor: AppColor.appTheme,
                isLoading: profileProvider.isLoading,
                onTap: () {
                  profileProvider.checkPasswordValidation();
                })
          ],
        ),
      ),
    );
  }

  imagePickerBottomSheet(ProfileProvider profileProvider) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getText(
                        title: getTranslated('profile_photo', context)!,
                        size: 17,
                        fontFamily: FontFamily.poppinsMedium,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close))
                  ],
                ),
                ScreenSize.height(25),
                Row(
                  children: [
                    imagePickType(Icons.camera_alt_outlined,
                        getTranslated('camera', context)!, () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.camera);
                    }),
                    ScreenSize.width(30),
                    imagePickType(Icons.image_outlined,
                        getTranslated('gallery', context)!, () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.gallery);
                    }),
                  ],
                )
              ],
            ),
          );
        });
  }

  imagePickType(icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColor.lightTextColor.withOpacity(.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColor.blackColor.withOpacity(.3),
            ),
          ),
          ScreenSize.height(5),
          getText(
              title: title,
              size: 14,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w400)
        ],
      ),
    );
  }

  openBottomSheetOptions() {
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.whiteColor)),
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    openDialogBox(
                        title: getTranslated("logout", context)!,
                        subTitle: getTranslated("want_to_logout", context)!,
                        noTap: () {
                          Navigator.pop(context);
                        },
                        yesTap: () async {
                          Utils.logOut();
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(
                            title: getTranslated('logout', context)!,
                            size: 16,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w400),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColor.appTheme,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
                ScreenSize.height(13),
                Container(
                  height: 1,
                  color: const Color(0xffDDE0E4),
                ),
                ScreenSize.height(13),
                GestureDetector(
                  onTap: () {
                    openDialogBox(
                        title: getTranslated("delete_account", context)!,
                        subTitle: getTranslated("want_to_delete", context)!,
                        noTap: () {
                          Navigator.pop(context);
                        },
                        yesTap: () async {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .deleteAccountApiFunction();
                          // Navigator.pop(context);
                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                          // prefs.clear();
                          // AppRoutes.pushReplacementAndRemoveNavigation(LoginScreen());
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(
                            title: getTranslated('delete_account', context)!,
                            size: 16,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w400),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColor.appTheme,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
                ScreenSize.height(13),
              ],
            ),
          );
        });
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
                      context.read<ProfileProvider>().selectedGender = 0;
                      context.read<ProfileProvider>().genderController.text =
                          'Male';
                      Navigator.pop(context);
                      state(() {});
                    },
                    child: Container(
                      color: AppColor.whiteColor,
                      height: 30,
                      child: Row(
                        children: [
                          customRadio(
                              0,
                              Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .selectedGender),
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
                      context.read<ProfileProvider>().selectedGender = 1;
                      context.read<ProfileProvider>().genderController.text =
                          'Female';
                      state(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: AppColor.whiteColor,
                      height: 30,
                      child: Row(
                        children: [
                          customRadio(
                              1,
                              Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .selectedGender),
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

  vehicleTypeBottomSheet() {
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
                          title: getTranslated('select_vehicle_type', context)!,
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
                  ListView.separated(
                      separatorBuilder: (context, sp) {
                        return ScreenSize.height(10);
                      },
                      shrinkWrap: true,
                      itemCount: Constants.vehicleTypeList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final provider = context.read<ProfileProvider>();
                            if (provider.vehicleType != index) {
                              provider
                                  .clearVehicleControllerOnChangeVehicleTye();

                              ///  clear all controllers values when change vehicle type
                            }
                            provider.vehicleType = index;
                            provider.vehicleTypeController.text =
                                Constants.vehicleTypeList[index];
                            if (provider.profileModel!.data!.vehicleType
                                    .toString()
                                    .toLowerCase() ==
                                provider.vehicleTypeController.text
                                    .toLowerCase()) {
                              print('sdfghj');
                              context
                                  .read<ProfileProvider>()
                                  .setVehicleValuesInController();
                            }
                            Navigator.pop(context);
                            setState(() {});
                            state(() {});
                          },
                          child: Container(
                            color: AppColor.whiteColor,
                            height: 30,
                            child: Row(
                              children: [
                                customRadio(
                                    index,
                                    Provider.of<ProfileProvider>(context,
                                            listen: false)
                                        .vehicleType),
                                ScreenSize.width(15),
                                getText(
                                    title: Constants.vehicleTypeList[index],
                                    size: 16,
                                    fontFamily: FontFamily.nunitoMedium,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            );
          });
        });
  }
}
