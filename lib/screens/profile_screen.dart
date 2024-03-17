import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/customtextfield.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/provider/profile_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.appTheme,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.arrowBackIcon,
              width: 28,
              height: 30,
              color: AppColor.whiteColor,
            ),
            ScreenSize.width(20),
            getText(
                title: 'Profile',
                size: 20,
                fontFamily: FontFamily.poppinsSemiBold,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w600)
          ],
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, myProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileWidget(),
              Align(
                alignment: Alignment.center,
                child: getText(
                    title: 'Change Picture',
                    size: 12,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w400),
              ),
              userDetailsWidget(myProvider)
            ],
          ),
        );
      }),
    );
  }

  profileWidget() {
    return SizedBox(
      height: 170,
      child: Stack(
        children: [
          Container(
            height: 100,
            color: AppColor.appTheme,
            padding: const EdgeInsets.only(top: 50, left: 16),
            // child:
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/profileImg.png',
              width: 142,
              height: 142,
            ),
          )
        ],
      ),
    );
  }

  userDetailsWidget(ProfileProvider profileProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextfield(
            controller: profileProvider.firstNameController,
            hintText: 'First Name',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.profileIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.lastNameController,
            hintText: 'Last Name',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.profileIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.mobileController,
            hintText: 'Mobile Number',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.callIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.emailController,
            hintText: 'Email Address',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.emailIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.addressController,
            hintText: 'Address',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.locationIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.cityController,
            hintText: 'City',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.cityIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.stateController,
            hintText: 'State',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.stateIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.countryController,
            hintText: 'Country',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.countryIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.stateIdController,
            hintText: 'State ID',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.stateIdIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(30),
          Container(
            height: 1,
            color: const Color(0xffD9D9D9).withOpacity(.4),
          ),
          ScreenSize.height(30),
          getText(
              title: 'Change Password',
              size: 16,
              fontFamily: FontFamily.poppinsSemiBold,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
          ScreenSize.height(30),
          CustomTextfield(
            controller: profileProvider.oldPasswordController,
            hintText: 'Old Password',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.passwordIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.newPasswordController,
            hintText: 'New Password',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.passwordIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(20),
          CustomTextfield(
            controller: profileProvider.confirmPasswordController,
            hintText: 'Confirm New Password',
            icon: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: ImageIcon(
                const AssetImage(
                  AppImages.passwordIcon,
                ),
                size: 24,
                color: AppColor.appTheme,
              ),
            ),
          ),
          ScreenSize.height(30),
          AppButton(
              title: "UPDATE PROFILE",
              height: 49,
              width: double.infinity,
              buttonColor: AppColor.appTheme,
              onTap: () {})
        ],
      ),
    );
  }
}
