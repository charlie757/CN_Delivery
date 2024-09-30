import 'dart:io';

import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/customtextfield.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/localization_provider.dart';
import 'package:cn_delivery/provider/profile_provider.dart';
import 'package:cn_delivery/screens/auth/login_screen.dart';
import 'package:cn_delivery/utils/app_validation.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/signup_provider.dart';
import '../widget/customradio.dart';
import '../widget/image_bottom_sheet.dart';
import '../widget/upload_image_widget.dart';

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
      myProvider.getProfileApiFunction(false);
      myProvider.setValuesInController();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(SessionManager.token);
    return Consumer<ProfileProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: profileAppBar (value: myProvider.isOnline,
               onChanged: (val) {
          myProvider.updateInOnline(val);
        },onTap: (){
              openBottomSheetOptions();
            }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tabBar(myProvider),
            Expanded(
                child: myProvider.tabBarIndex == 0
                    ? userDetailsWidget(myProvider)
                    :myProvider.tabBarIndex == 1?
                vehicleInfoWidget(myProvider):
                changePasswordWidget(myProvider))
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
            GestureDetector(
              onTap: () {
                profileProvider.updateTabBarIndex(0);
              },
              child: Container(
                height: 50,
                width: 120,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                        getTranslated('personal_info', context)!,
                       maxLines: 1,overflow: TextOverflow.ellipsis,
                       style:TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: profileProvider.tabBarIndex == 0
                            ? AppColor.blueColor
                            : AppColor.blackColor,
                        fontWeight: FontWeight.w600)),
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
            ScreenSize.width(10),
            GestureDetector(
              onTap: () {
                profileProvider.updateTabBarIndex(1);
              },
              child: Container(
                height: 50,
                width: 120,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                        getTranslated('vehicle_info', context)!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: profileProvider.tabBarIndex == 1
                            ? AppColor.blueColor
                            : AppColor.blackColor,
                        fontWeight: FontWeight.w600)),
                    ScreenSize.height(15),
                    Container(
                      height: profileProvider.tabBarIndex ==1 ? 4 : 1,
                      color: profileProvider.tabBarIndex == 1
                          ? AppColor.blueColor
                          : const Color(0xffD9D9D9),
                    )
                  ],
                ),
              ),
            ),
            ScreenSize.width(10),
            GestureDetector(
              onTap: () {
                profileProvider.updateTabBarIndex(2);
              },
              child: Container(
                color: Colors.white,
                height: 50,
                width: 180,
                child: Column(
                  children: [
                    Text(
                      getTranslated('change_password', context)!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: profileProvider.tabBarIndex == 2
                              ? AppColor.blueColor
                              : AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    ScreenSize.height(15),
                    Container(
                      height: profileProvider.tabBarIndex == 2? 4 : 1,
                      color: profileProvider.tabBarIndex == 2
                          ? AppColor.blueColor
                          : const Color(0xffD9D9D9),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
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
                    imageBottomSheet(context,
                        cameraTap: (){
                          Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.camera).then((val){
                            if(val!=null){
                              profileProvider.imgFile = val;
                              setState(() {

                              });
                              Navigator.pop(context);
                            }
                          });
                        },galleryTap: (){
                          Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.gallery).then((val){
                            if(val!=null){
                              profileProvider.imgFile = val;
                              setState(() {
                              });
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
            CustomTextfield(
              controller: profileProvider.firstNameController,
              hintText: getTranslated('first_name', context)!,
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
              hintText: getTranslated('last_name', context)!,
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
              hintText: getTranslated('email_address', context)!,
              errorMsg: profileProvider.emailErrorMsg,
              isReadOnly: true,
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
              hintText: getTranslated('address', context)!,
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
              controller: profileProvider.genderController,
              hintText: getTranslated('gender', context)!,
              isReadOnly: true,
              errorMsg: profileProvider.genderErrorMsg,
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
              onTap: (){
                genderBottomSheet();
              },
            ),
            ScreenSize.height(20),
            // CustomTextfield(
            //   controller: profileProvider.cityController,
            //   hintText: getTranslated('city', context)!,
            //   isReadOnly: profileProvider.profileLoading,
            //   errorMsg: profileProvider.cityErrorMsg,
            //   onChanged: (val) {
            //     profileProvider.cityErrorMsg = AppValidation.cityValidator(val);
            //     setState(() {});
            //   },
            //   icon: Container(
            //     height: 30,
            //     width: 30,
            //     alignment: Alignment.center,
            //     child: ImageIcon(
            //       const AssetImage(
            //         AppImages.cityIcon,
            //       ),
            //       size: 24,
            //       color: AppColor.blueColor,
            //     ),
            //   ),
            // ),
            // ScreenSize.height(20),
            // CustomTextfield(
            //   controller: profileProvider.stateController,
            //   hintText: getTranslated('state', context)!,
            //   isReadOnly: profileProvider.profileLoading,
            //   errorMsg: profileProvider.stateErrorMsg,
            //   onChanged: (val) {
            //     profileProvider.stateErrorMsg =
            //         AppValidation.stateValidator(val);
            //     setState(() {});
            //   },
            //   icon: Container(
            //     height: 30,
            //     width: 30,
            //     alignment: Alignment.center,
            //     child: ImageIcon(
            //       const AssetImage(
            //         AppImages.stateIcon,
            //       ),
            //       size: 24,
            //       color: AppColor.blueColor,
            //     ),
            //   ),
            // ),
            // ScreenSize.height(20),
            // CustomTextfield(
            //   controller: profileProvider.countryController,
            //   hintText: getTranslated('country', context)!,
            //   isReadOnly: profileProvider.profileLoading,
            //   errorMsg: profileProvider.countyErrorMsg,
            //   onChanged: (val) {
            //     profileProvider.countyErrorMsg =
            //         AppValidation.countryValidator(val);
            //     setState(() {});
            //   },
            //   icon: Container(
            //     height: 30,
            //     width: 30,
            //     alignment: Alignment.center,
            //     child: ImageIcon(
            //       const AssetImage(
            //         AppImages.countryIcon,
            //       ),
            //       size: 24,
            //       color: AppColor.blueColor,
            //     ),
            //   ),
            // ),
            // ScreenSize.height(20),
            CustomTextfield(
              controller: profileProvider.stateIdController,
              hintText: getTranslated('state_id', context)!,
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
            ScreenSize.height(20),
            getText(title: getTranslated('passport_image', context)!,
                size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor,
                fontWeight: FontWeight.w400),
            ScreenSize.height(6),
            uploadImageWidget(onTap: (){
              imageBottomSheet(context,
                  cameraTap: (){
                Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.camera).then((val){
                  if(val!=null){
                    profileProvider.passportImage = val;
                    setState(() {

                    });
                    Navigator.pop(context);
                  }
                });
              },galleryTap: (){
                Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.gallery).then((val){
                  if(val!=null){
                    profileProvider.passportImage = val;
                    setState(() {
                    });
                    Navigator.pop(context);
                  }
                });
              });
            },
                imgPath:profileProvider.passportImage,imgUrl:
                profileProvider.profileModel!=null&&profileProvider.profileModel!.data!=null?
                profileProvider.profileModel!.data!.passportImage??"":""),
            ScreenSize.height(20),
            getText(title: getTranslated('identity_image', context)!,
                size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor,
                fontWeight: FontWeight.w400),
            ScreenSize.height(6),
            uploadImageWidget(onTap: (){
              imageBottomSheet(context,cameraTap: (){
                Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.camera).then((val){
                  if(val!=null){
                    profileProvider.licenceImage = val;
                    setState(() {

                    });
                    Navigator.pop(context);
                  }
                });
              },galleryTap: (){
                Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.gallery).then((val){
                  if(val!=null){
                    profileProvider.licenceImage = val;
                    setState(() {
                    });
                    Navigator.pop(context);
                  }
                });
              });
            },
                imgPath:profileProvider.licenceImage,imgUrl:
                profileProvider.profileModel!=null&&profileProvider.profileModel!.data!=null?
                profileProvider.profileModel!.data!.drivingLicenseImage??"":""),
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

  vehicleInfoWidget(ProfileProvider profileProvider){
    return SingleChildScrollView(
      padding:
      const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextfield(
            controller: profileProvider.vehicleNameController,
            hintText: getTranslated('vehicle_name', context)!,
            isReadOnly: false,
            errorMsg: profileProvider.vehicleNameErrorMsg,
            onChanged: (val) {
              profileProvider.vehicleNameErrorMsg =
                  AppValidation.vehicleNameValidator(val);
              setState(() {});
            },
            icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.card_travel,color: AppColor.blueColor.withOpacity(.7),)
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.vehicleTypeController,
            hintText: getTranslated('vehicle_type', context)!,
            isReadOnly: true,
            errorMsg: profileProvider.vehicleTypeErrorMsg,
            onTap: (){
              vehicleTypeBottomSheet();
            },
            onChanged: (val) {
              profileProvider.vehicleTypeErrorMsg =
                  AppValidation.vehicleTypeValidator(val);
              setState(() {});
            },
            icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.card_travel,color: AppColor.blueColor.withOpacity(.7),)
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.modelNumberController,
            hintText: getTranslated('model_number', context)!,
            isReadOnly: false,
            errorMsg: profileProvider.modelNumberErrorMsg,
            onChanged: (val) {
              profileProvider.modelNumberErrorMsg =
                  AppValidation.modelNumberValidator(val);
              setState(() {});
            },
            icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.card_travel,color: AppColor.blueColor.withOpacity(.7),)
            ),
          ),
          ScreenSize.height(20),
          // CustomTextfield(
          //   controller: profileProvider.domController,
          //   hintText: getTranslated('date_of_manufacture', context)!,
          //   isReadOnly: true,
          //   errorMsg: profileProvider.domErrorMsg,
          //   onTap: (){
          //     Provider.of<SignupProvider>(context,listen: false).datePicker(profileProvider.selectedDOMDate).then((val){
          //       print(val);
          //       if(val!=null){
          //         profileProvider.selectedDOMDate = val;
          //         profileProvider.domController.text = "${val.day.toString().length==1?"0${val.day}":val.day}-${val.month.toString().length==1?"0${val.month}":val.month}-${val.year}";
          //       }
          //     });
          //   },
          //   onChanged: (val) {
          //     profileProvider.domErrorMsg =
          //         AppValidation.dateOfManufactureValidator(val);
          //     setState(() {});
          //
          //   },
          //   icon: Container(
          //       height: 30,
          //       width: 30,
          //       alignment: Alignment.center,
          //       child: Icon(Icons.date_range,color: AppColor.blueColor.withOpacity(.7),)
          //   ),
          // ),
          // ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.dorController,
            hintText: getTranslated('date_of_registration', context)!,
            isReadOnly: true,
            errorMsg: profileProvider.dorErrorMsg,
            onTap: (){
              Provider.of<SignupProvider>(context,listen: false).datePicker(profileProvider.selectedDORDate).then((val){
                if(val!=null){
                  profileProvider.selectedDORDate = val;
                  profileProvider.dorController.text = "${val.day.toString().length==1?"0${val.day}":val.day}-${val.month.toString().length==1?"0${val.month}":val.month}-${val.year}";
                }
              });
            },
            onChanged: (val) {
              profileProvider.dorErrorMsg =
                  AppValidation.dateOfRegistrationValidator(val);
              setState(() {});
            },
            icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.date_range,color: AppColor.blueColor.withOpacity(.7),)
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.fuelController,
            hintText: getTranslated('fuel_type', context)!,
            isReadOnly: true,
            errorMsg: profileProvider.fuelErrorMsg,
            onTap: (){
              fuelTypeBottomSheet();
            },
            onChanged: (val) {
              profileProvider.fuelErrorMsg =
                  AppValidation.fuelTypeValidator(val);
              setState(() {});
            },
            icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.card_travel,color: AppColor.blueColor,)
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.vehicleRegistrationController,
            hintText: getTranslated('registration_number', context)!,
            isReadOnly: false,
            errorMsg: profileProvider.vehicleRegistrationErrorMsg,
            onChanged: (val) {
              profileProvider.vehicleRegistrationErrorMsg =
                  AppValidation.vehicleRegistrationValidator(val);
              setState(() {});
            },
            icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.card_travel,color: AppColor.blueColor,)
            ),
          ),
          ScreenSize.height(20),
          getText(title: getTranslated('insurance_copy', context)!,
              size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor,
              fontWeight: FontWeight.w400),
          ScreenSize.height(6),

          uploadImageWidget(onTap: (){
            imageBottomSheet(context,cameraTap: (){
              Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.camera).then((val){
                if(val!=null){
                  profileProvider.insuranceCopyImage = val;
                  setState(() {

                  });
                  Navigator.pop(context);
                }
              });
            },galleryTap: (){
              Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.gallery).then((val){
                if(val!=null){
                  profileProvider.insuranceCopyImage = val;
                  setState(() {
                  });
                  Navigator.pop(context);
                }
              });
            });
          },
              imgPath:profileProvider.insuranceCopyImage,imgUrl:
              profileProvider.profileModel!=null&&profileProvider.profileModel!.data!=null?
              profileProvider.profileModel!.data!.vehicleInsuranceImage??"":""),
          ScreenSize.height(20),
          getText(title: getTranslated('tourist_permit', context)!,
              size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor,
              fontWeight: FontWeight.w400),
          ScreenSize.height(6),
          uploadImageWidget(onTap: (){
            imageBottomSheet(context,cameraTap: (){
              Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.camera).then((val){
                if(val!=null){
                  profileProvider.touristPermitImage = val;
                  setState(() {

                  });
                  Navigator.pop(context);
                }
              });
            },galleryTap: (){
              Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.gallery).then((val){
                if(val!=null){
                  profileProvider.touristPermitImage = val;
                  setState(() {
                  });
                  Navigator.pop(context);
                }
              });
            });
          },
              imgPath:profileProvider.touristPermitImage,imgUrl:
              profileProvider.profileModel!=null&&profileProvider.profileModel!.data!=null?
              profileProvider.profileModel!.data!.vehicleTouristPermitImage??"":""),
          ScreenSize.height(20),
          getText(title: getTranslated('vehicle_image', context)!,
              size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor,
              fontWeight: FontWeight.w400),
          ScreenSize.height(6),

          uploadImageWidget(onTap: (){
            imageBottomSheet(context,cameraTap: (){
              Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.camera).then((val){
                if(val!=null){
                  profileProvider.vehicleImage = val;
                  setState(() {

                  });
                  Navigator.pop(context);
                }
              });
            },galleryTap: (){
              Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.gallery).then((val){
                if(val!=null){
                  profileProvider.vehicleImage = val;
                  setState(() {
                  });
                  Navigator.pop(context);
                }
              });
            });
          },
              imgPath:profileProvider.vehicleImage,imgUrl:
              profileProvider.profileModel!=null&&profileProvider.profileModel!.data!=null?
              profileProvider.profileModel!.data!.vehicleImage??"":""),
          ScreenSize.height(50),
          AppButton(
              title: getTranslated('update_vehicle_info', context)!,
              height: 49,
              width: double.infinity,
              buttonColor: AppColor.appTheme,
              isLoading: profileProvider.profileLoading,
              onTap: () {
                profileProvider.checkVehicleInfoValidation();
              }),

        ],
      ),
    );
  }

  viewVehicleImagesWidget(ProfileProvider profileProvider){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 ],
              ),
            ),
            ScreenSize.width(15),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(title: getTranslated('tourist_permit', context)!,
                    size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor,
                    fontWeight: FontWeight.w400),
                ScreenSize.height(6),

                uploadImageWidget(onTap: (){
                  imageBottomSheet(context,cameraTap: (){
                    Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.camera).then((val){
                      if(val!=null){
                        profileProvider.touristPermitImage = val;
                        setState(() {

                        });
                        Navigator.pop(context);
                      }
                    });
                  },galleryTap: (){
                    Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.gallery).then((val){
                      if(val!=null){
                        profileProvider.touristPermitImage = val;
                        setState(() {
                        });
                        Navigator.pop(context);
                      }
                    });
                  });
                },
                    imgPath:profileProvider.touristPermitImage,imgUrl:
                    profileProvider.profileModel!=null&&profileProvider.profileModel!.data!=null?
                    profileProvider.profileModel!.data!.vehicleTouristPermitImage??"":"")
              ],
            ))
          ],
        ),
        ScreenSize.height(20),
        Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(title: getTranslated('vehicle_image', context)!,
                    size: 12, fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor,
                    fontWeight: FontWeight.w400),
                ScreenSize.height(6),

                uploadImageWidget(onTap: (){
                  imageBottomSheet(context,cameraTap: (){
                    Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.camera).then((val){
                      if(val!=null){
                        profileProvider.vehicleImage = val;
                        setState(() {

                        });
                        Navigator.pop(context);
                      }
                    });
                  },galleryTap: (){
                    Provider.of<SignupProvider>(context,listen: false).imagePicker(context, ImageSource.gallery).then((val){
                      if(val!=null){
                        profileProvider.vehicleImage = val;
                        setState(() {
                        });
                        Navigator.pop(context);
                      }
                    });
                  });
                },
                    imgPath:profileProvider.vehicleImage,imgUrl:
                    profileProvider.profileModel!=null&&profileProvider.profileModel!.data!=null?
                    profileProvider.profileModel!.data!.vehicleImage??"":"")
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
            CustomTextfield(
              controller: profileProvider.oldPasswordController,
              hintText: getTranslated('old_Password', context)!,
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
              hintText: getTranslated('new_password', context)!,
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
              hintText: getTranslated('confirm_password', context)!,
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

  openLanguageBox(ProfileProvider profileProvider) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, state) {
          return Center(
            child: Container(
              // height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getText(
                          title: getTranslated('change_language', context)!,
                          size: 16,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                      // Icon(Icons.close)
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  ScreenSize.height(20),
                  GestureDetector(
                    onTap: () {
                      profileProvider.updateLangIndex(0);

                      state(() {});
                    },
                    child: Container(
                      height: 30,
                      color: AppColor.whiteColor,
                      child: Row(
                        children: [
                          radioButton(profileProvider, 0),
                          ScreenSize.width(15),
                          getText(
                              title: getTranslated('english', context)!,
                              size: 18,
                              fontFamily: FontFamily.nunitoMedium,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  ),
                  ScreenSize.height(15),
                  GestureDetector(
                    onTap: () {
                      profileProvider.updateLangIndex(1);
                      state(() {});
                    },
                    child: Container(
                      height: 30,
                      color: AppColor.whiteColor,
                      child: Row(
                        children: [
                          radioButton(profileProvider, 1),
                          ScreenSize.width(15),
                          getText(
                              title: getTranslated('spanish', context)!,
                              size: 18,
                              fontFamily: FontFamily.nunitoMedium,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  ),
                  ScreenSize.height(30),
                  AppButton(
                      title: getTranslated('okay', context)!,
                      height: 45,
                      width: 150,
                      buttonColor: AppColor.appTheme,
                      onTap: () {
                        Provider.of<LocalizationProvider>(context,
                                listen: false)
                            .setLanguage(Locale(
                          Constants.languages[profileProvider.selectedLangIndex]
                              .languageCode!,
                          Constants.languages[profileProvider.selectedLangIndex]
                              .countryCode,
                        ));

                        Provider.of<LocalizationProvider>(context,
                                listen: false)
                            .loadCurrentLanguage();
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  radioButton(ProfileProvider profileProvider, int index) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.blueColor)),
      padding: const EdgeInsets.all(3),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: profileProvider.selectedLangIndex == index
                ? AppColor.blueColor
                : AppColor.whiteColor,
            shape: BoxShape.circle),
      ),
    );
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
                        isLogout: true,
                        title: getTranslated("logout", context)!,
                        subTitle:  getTranslated("want_to_logout", context)!,
                        noTap: () {
                          Navigator.pop(context);
                        },
                        yesTap: () async{
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
                        isLogout: false,
                        title: getTranslated("delete_account", context)!,
                        subTitle:  getTranslated("want_to_delete", context)!,
                        noTap: () {
                          Navigator.pop(context);
                        },
                        yesTap: () async{
                         Provider.of<ProfileProvider>(context,listen: false).deleteAccountApiFunction();
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

  void openDialogBox(
      {required bool isLogout,
        required String title,
        required String subTitle,
        required Function() noTap,
        required Function() yesTap}) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            Center(
              child: Container(
                // height: 394,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 35, left: 20, right: 20, bottom: 33),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      ScreenSize.height(20),
                      Align(
                        alignment:Alignment.center,
                          child : Text(
  subTitle,
  style: TextStyle(
      decoration: TextDecoration.none,
      fontSize: 14,
      fontFamily: FontFamily.poppinsSemiBold,
      color: AppColor.textBlackColor,
      fontWeight: FontWeight.w600),
  textAlign: TextAlign.center,
)  ),
                      ScreenSize.height(47),
                      Row(
                        children: [
                          Flexible(
                            child: AppButton(
                                title: getTranslated('no', context)!,
                                height: 50,
                                width: double.infinity,
                                buttonColor: AppColor.whiteColor,
                                textColor: AppColor.textBlackColor,
                                onTap: noTap),
                          ),
                          ScreenSize.width(20),
                          Flexible(
                            child: AppButton(
                                title: getTranslated('yes', context)!,
                                height: 50,
                                width: double.infinity,
                                buttonColor: AppColor.appTheme,
                                onTap: yesTap),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //     right: 0 + 33,
            //     top: isLogout
            //         ? MediaQuery.of(context).size.height / 2.8
            //         : MediaQuery.of(context).size.height / 2.9,
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: Image.asset(
            //         AppImages.closeIcon,
            //         height: 25,
            //         width: 25,
            //       ),
            //     ))
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  genderBottomSheet(){
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context,state) {
                return Container(
                  padding:const EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getText(title: getTranslated('select_gender', context)!, size: 18,
                              fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:const Icon(Icons.close),)
                        ],
                      ),
                      ScreenSize.height(20),
                      GestureDetector(
                        onTap: (){
                          Provider.of<ProfileProvider>(context,listen: false).selectedGender =0;
                          Provider.of<ProfileProvider>(context,listen: false).genderController.text = 'Male';
                          Navigator.pop(context);
                          state(() {

                          });
                        },
                        child: Container(
                          color: AppColor.whiteColor,
                          height: 30,
                          child: Row(
                            children: [
                              customRadio(0,Provider.of<ProfileProvider>(context,listen: false).selectedGender),
                              ScreenSize.width(15),
                              getText(title: getTranslated('male', context)!, size: 16,
                                  fontFamily: FontFamily.nunitoMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      ),
                      ScreenSize.height(10),
                      GestureDetector(
                        onTap: (){
                          Provider.of<ProfileProvider>(context,listen: false).selectedGender =1;
                          Provider.of<ProfileProvider>(context,listen: false).genderController.text = 'Female';
                          state(() {
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: AppColor.whiteColor,
                          height: 30,
                          child: Row(
                            children: [
                              customRadio(1,Provider.of<ProfileProvider>(context,listen: false).selectedGender),
                              ScreenSize.width(15),
                              getText(title: getTranslated('female', context)!, size: 16,
                                  fontFamily: FontFamily.nunitoMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        });
  }

  fuelTypeBottomSheet(){
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context,state) {
                return Container(
                  padding:const EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getText(title: getTranslated('select_fuel_type', context)!, size: 18,
                              fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:const Icon(Icons.close),)
                        ],
                      ),
                      ScreenSize.height(20),
                      GestureDetector(
                        onTap: (){
                          Provider.of<ProfileProvider>(context,listen:false).fuelType =0;
                          Provider.of<ProfileProvider>(context,listen: false).fuelController.text = 'Petrol';
                          Navigator.pop(context);
                          state(() {

                          });
                        },
                        child: Container(
                          color: AppColor.whiteColor,
                          height: 30,
                          child: Row(
                            children: [
                              customRadio(0,Provider.of<ProfileProvider>(context,listen:false).fuelType),
                              ScreenSize.width(15),
                              getText(title: getTranslated('petrol', context)!, size: 16,
                                  fontFamily: FontFamily.nunitoMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      ),
                      ScreenSize.height(10),
                      GestureDetector(
                        onTap: (){
                          Provider.of<ProfileProvider>(context,listen:false).fuelType=1;
                          Provider.of<ProfileProvider>(context,listen: false).fuelController.text = 'Diesel';
                          state(() {
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: AppColor.whiteColor,
                          height: 30,
                          child: Row(
                            children: [
                              customRadio(1,Provider.of<ProfileProvider>(context,listen:false).fuelType),
                              ScreenSize.width(15),
                              getText(title: getTranslated('diesel', context)!, size: 16,
                                  fontFamily: FontFamily.nunitoMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        });
  }

  vehicleTypeBottomSheet(){
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context,state) {
                return Container(
                  padding:const EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getText(title: getTranslated('select_vehicle_type', context)!, size: 18,
                              fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:const Icon(Icons.close),)
                        ],
                      ),
                      ScreenSize.height(20),
                      ListView.separated(
                          separatorBuilder: (context,sp){
                            return ScreenSize.height(10);
                          },
                          shrinkWrap: true,
                          itemCount: Constants.vehicleTypeList.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                               Provider.of<ProfileProvider>(context,listen:false).vehicleType =index;
                                Provider.of<ProfileProvider>(context,listen: false).vehicleTypeController.text= Constants.vehicleTypeList[index];
                                Navigator.pop(context);
                                state(() {

                                });
                              },
                              child: Container(
                                color: AppColor.whiteColor,
                                height: 30,
                                child: Row(
                                  children: [
                                    customRadio(index,Provider.of<ProfileProvider>(context,listen:false).vehicleType),
                                    ScreenSize.width(15),
                                    getText(title: Constants.vehicleTypeList[index], size: 16,
                                        fontFamily: FontFamily.nunitoMedium, color: AppColor.blackColor, fontWeight: FontWeight.w500)
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                );
              }
          );
        });
  }

}
