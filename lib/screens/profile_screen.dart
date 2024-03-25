import 'dart:io';

import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/customtextfield.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/provider/profile_provider.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      myProvider.setValuesInController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: profileAppBar(myProvider.isOnline, (val) {
          myProvider.updateInOnline(val);
        }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tabBar(myProvider),
            Expanded(
                child: myProvider.tabBarIndex == 0
                    ? userDetailsWidget(myProvider)
                    : changePasswordWidget(myProvider))
          ],
        ),
      );
    });
  }

  tabBar(ProfileProvider profileProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                profileProvider.updateTabBarIndex(0);
              },
              child: Container(
                height: 50,
                color: Colors.white,
                child: Column(
                  children: [
                    getText(
                        title: 'Personal Info',
                        size: 16,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: profileProvider.tabBarIndex == 0
                            ? AppColor.blueColor
                            : AppColor.blackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(15),
                    Container(
                      height: profileProvider.tabBarIndex == 0 ? 4 : 1,
                      color: profileProvider.tabBarIndex == 0
                          ? AppColor.blueColor
                          : const Color(0xffD9D9D9),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                profileProvider.updateTabBarIndex(1);
              },
              child: Container(
                color: Colors.white,
                height: 50,
                child: Column(
                  children: [
                    getText(
                        title: 'Change Password',
                        size: 16,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: profileProvider.tabBarIndex == 1
                            ? AppColor.blueColor
                            : AppColor.blackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(15),
                    Container(
                      height: profileProvider.tabBarIndex == 1 ? 4 : 1,
                      color: profileProvider.tabBarIndex == 1
                          ? AppColor.blueColor
                          : const Color(0xffD9D9D9),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  userDetailsWidget(ProfileProvider profileProvider) {
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
                              child: Image.network(
                                profileProvider.profileImgUrl,
                                fit: BoxFit.cover,
                                cacheHeight: 600,
                                cacheWidth: 600,
                              ))
                          : Image.asset(
                              'assets/images/profileImg.png',
                              fit: BoxFit.cover,
                            ),
                ),
                ScreenSize.width(30),
                GestureDetector(
                  onTap: () {
                    imagePickerBottomSheet(profileProvider);
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
                            title: 'Change Picture',
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
            CustomTextfield(
              controller: profileProvider.firstNameController,
              hintText: 'First Name',
              errorMsg: profileProvider.fNameErrorMsg,
              isReadOnly: profileProvider.profileLoading,
              onChanged: (val) {
                profileProvider.fNameErrorMsg =
                    AppValidation.firstNameValidator(val);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.profileIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.lastNameController,
              hintText: 'Last Name',
              errorMsg: profileProvider.lNameErrorMsg,
              isReadOnly: profileProvider.profileLoading,
              onChanged: (val) {
                profileProvider.lNameErrorMsg =
                    AppValidation.lastNameValidator(val);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.profileIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.mobileController,
              hintText: 'Mobile Number',
              isReadOnly: profileProvider.profileLoading,
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
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.callIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.emailController,
              hintText: 'Email Address',
              errorMsg: profileProvider.emailErrorMsg,
              isReadOnly: profileProvider.profileLoading,
              onChanged: (val) {
                profileProvider.emailErrorMsg =
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
            CustomTextfield(
              controller: profileProvider.addressController,
              hintText: 'Address',
              isReadOnly: profileProvider.profileLoading,
              errorMsg: profileProvider.addressErrorMsg,
              onChanged: (val) {
                profileProvider.addressErrorMsg =
                    AppValidation.addressValidator(val);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.locationIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.cityController,
              hintText: 'City',
              isReadOnly: profileProvider.profileLoading,
              errorMsg: profileProvider.cityErrorMsg,
              onChanged: (val) {
                profileProvider.cityErrorMsg = AppValidation.cityValidator(val);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.cityIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.stateController,
              hintText: 'State',
              isReadOnly: profileProvider.profileLoading,
              errorMsg: profileProvider.stateErrorMsg,
              onChanged: (val) {
                profileProvider.stateErrorMsg =
                    AppValidation.stateValidator(val);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.stateIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.countryController,
              hintText: 'Country',
              isReadOnly: profileProvider.profileLoading,
              errorMsg: profileProvider.countyErrorMsg,
              onChanged: (val) {
                profileProvider.countyErrorMsg =
                    AppValidation.countryValidator(val);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.countryIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.stateIdController,
              hintText: 'State ID (Identity Number)',
              isReadOnly: profileProvider.profileLoading,
              errorMsg: profileProvider.stateIdErrorMsg,
              onChanged: (val) {
                profileProvider.stateIdErrorMsg =
                    AppValidation.stateIdValidator(val);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.stateIdIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(50),
            AppButton(
                title: "UPDATE PROFILE",
                height: 49,
                width: double.infinity,
                buttonColor: AppColor.appTheme,
                isLoading: profileProvider.profileLoading,
                onTap: () {
                  profileProvider.checkUpdateProfileValidation();
                })
          ],
        ),
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
            CustomTextfield(
              controller: profileProvider.oldPasswordController,
              hintText: 'Old Password',
              errorMsg: profileProvider.oldPasswordErrorMsg,
              onChanged: (val) {
                profileProvider.oldPasswordErrorMsg =
                    AppValidation.passwordValidator(val);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.passwordIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.newPasswordController,
              hintText: 'New Password',
              errorMsg: profileProvider.newPasswordErrorMsg,
              onChanged: (val) {
                profileProvider.newPasswordErrorMsg =
                    AppValidation.reEnterpasswordValidator(
                        val, profileProvider.confirmPasswordController.text);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
                  const AssetImage(
                    AppImages.passwordIcon,
                  ),
                  size: 24,
                  color: AppColor.blueColor,
                ),
              ),
            ),
            ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.confirmPasswordController,
              hintText: 'Confirm New Password',
              errorMsg: profileProvider.confirmNewPasswordErrorMsg,
              onChanged: (val) {
                profileProvider.confirmNewPasswordErrorMsg =
                    AppValidation.reEnterpasswordValidator(
                        val, profileProvider.newPasswordController.text);
                setState(() {});
              },
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: ImageIcon(
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
                title: "UPDATE PASSWORD",
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
                        title: 'Profile Photo',
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
                    imagePickType(Icons.camera_alt_outlined, 'Camera', () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.camera);
                    }),
                    ScreenSize.width(30),
                    imagePickType(Icons.image_outlined, 'Gallery', () {
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
}
