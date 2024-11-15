import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/home_provider.dart';
import 'package:cn_delivery/provider/profile_provider.dart';
import 'package:cn_delivery/screens/bank_details_screen.dart';
import 'package:cn_delivery/screens/view_order_details_screen.dart';
import 'package:cn_delivery/utils/session_manager.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/btn_widget.dart';
import 'package:cn_delivery/widget/dialog_box.dart';
import 'package:cn_delivery/widget/language_dialogbox.dart';
import 'package:cn_delivery/widget/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<HomeProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      myProvider.callApiFunction();
      myProvider.upcomingOrderApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Consumer<HomeProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        drawer: _drawer(profileProvider),
        appBar: appBar(
            title: getTranslated('dashboard', context)!,
            isLeading: true,
            isNotification: true,
            isWallet: false),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 40, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    onGoingCompletedWidget(
                        AppColor.blueColor,
                        AppImages.onGoingIcon,
                        getTranslated('on_going', context)!,
                        myProvider.homeModel != null &&
                                myProvider.homeModel!.data != null
                            ? myProvider.homeModel!.data!.totalCurrentOrders
                                .toString()
                            : '0'),
                    ScreenSize.width(15),
                    onGoingCompletedWidget(
                        AppColor.lightPinkColor,
                        AppImages.completedIcon,
                        getTranslated('completed', context)!,
                        myProvider.homeModel != null &&
                                myProvider.homeModel!.data != null
                            ? myProvider.homeModel!.data!.totalDeliveredOrders
                                .toString()
                            : '0'),
                  ],
                ),
                ScreenSize.height(23),
                totalOrdersWidget(myProvider),
                ScreenSize.height(23),
                getText(
                    title: getTranslated('upcoming_orders', context)!,
                    size: 22,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
                ScreenSize.height(22),
                upcomingOrdersWidget(myProvider),
              ],
            ),
          ),
        ),
      );
    });
  }

  onGoingCompletedWidget(
      Color color, String img, String title, String subTitle) {
    return Flexible(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 11, top: 23, bottom: 25),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 10,
                  color: AppColor.blueColor.withOpacity(.2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  img,
                  height: 43,
                  width: 43,
                ),
                ScreenSize.width(15),
                Flexible(
                  child: getText(
                      title: title,
                      size: 16,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            ScreenSize.height(22),
            getText(
                title: subTitle,
                size: 30,
                fontFamily: FontFamily.poppinsSemiBold,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w700)
          ],
        ),
      ),
    );
  }

  totalOrdersWidget(HomeProvider provider) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xff5714AC)),
      padding: const EdgeInsets.only(top: 23, left: 23, bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(AppImages.totalOrderIcon),
              ),
              ScreenSize.width(16),
              getText(
                  title: getTranslated('total_orders', context)!,
                  size: 16,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w600)
            ],
          ),
          ScreenSize.height(22),
          getText(
              title:
                  provider.homeModel != null && provider.homeModel!.data != null
                      ? provider.homeModel!.data!.totalOrders.toString()
                      : '0',
              size: 30,
              fontFamily: FontFamily.poppinsSemiBold,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w700)
        ],
      ),
    );
  }

  upcomingOrdersWidget(HomeProvider provider) {
    return provider.upcomingOrderModel != null &&
            provider.upcomingOrderModel!.data != null &&
            provider.upcomingOrderModel!.data!.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(20);
            },
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: provider.upcomingOrderModel!.data!.length,
            itemBuilder: (context, index) {
              return orderUi(index, provider);
            })
        : Container();
    // Center(
    //     child: getText(
    //         title: 'No orders found',
    //         size: 16,
    //         fontFamily: FontFamily.poppinsRegular,
    //         color: AppColor.blackColor,
    //         fontWeight: FontWeight.w400),
    //   );
  }

  orderUi(int index, HomeProvider provider) {
    var model = provider.upcomingOrderModel!.data![index];
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(ViewOrderDetailsScreen(
          orderId: model.id.toString(),
        )).then((value) {});
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffF5F5F5)),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  color: AppColor.blackColor.withOpacity(.2))
            ]),
        padding:
            const EdgeInsets.only(top: 15, left: 17, right: 15, bottom: 17),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: getText(
                  title: model.orderDate.toString(),
                  size: 12,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400),
            ),
            ScreenSize.height(1),
            model.product != null
                ? Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: model.product != null &&
                                  model.product![0].image.isEmpty
                              ? Container()
                              : NetworkImagehelper(
                                  img: model.product![0].image,
                                  height: 60.0,
                                  width: 66.0,
                                )),
                      ScreenSize.width(12),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.product![0].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontFamily.poppinsMedium,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Text.rich(TextSpan(
                              text: '${getTranslated('qty', context)!}: ',
                              style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.poppinsRegular),
                              children: [
                                TextSpan(
                                    text: model.product![0].qty.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.blackColor,
                                        fontFamily: FontFamily.poppinsRegular))
                              ])),
                          Text.rich(TextSpan(
                              text: '${getTranslated('price', context)!}: ',
                              style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.poppinsRegular),
                              children: [
                                TextSpan(
                                    text: model.product![0].price.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.blackColor,
                                        fontFamily: FontFamily.poppinsRegular))
                              ])),
                        ],
                      ))
                    ],
                  )
                : Container(),
            ScreenSize.height(2),
            Align(
                alignment: Alignment.centerRight,
                child: viewOrderDetailsButton((){
                  AppRoutes.pushCupertinoNavigation(ViewOrderDetailsScreen(
              orderId: model.id.toString(),
            )).then((value) {});
                 }),
              ),
            ScreenSize.height(8),
            Row(
              children: [
                getText(
                    title: '${getTranslated('total_order_values', context)!}: ',
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor.withOpacity(.5),
                    fontWeight: FontWeight.w400),
                getText(
                    title: '${model.orderAmount.toString()} COP',
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w400),
              ],
            ),
            ScreenSize.height(4),
            Row(
              children: [
                getText(
                    title: '${getTranslated('payment_method', context)!}: ',
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor.withOpacity(.5),
                    fontWeight: FontWeight.w400),
                Flexible(
                  child: Text(
                    model.paymentMethod.toString() == 'cash_on_delivery'
                        ? "COD"
                        : model.paymentMethod.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            ScreenSize.height(12),
            Row(
              children: [
                Expanded(
                  child: btn(
                      title: getTranslated('reject', context)!,
                      color: AppColor.rejectColor,
                      onTap: () {
                        openDialogBox(
                            title: getTranslated('reject', context)!,
                            subTitle: getTranslated(
                                'confirmation_reject_order', context)!,
                            noTap: () {
                              Navigator.pop(context);
                            },
                            yesTap: () {
                              Navigator.pop(context);
                              provider
                                  .rejectOrderApiFunction(model.id.toString());
                            });
                      }),
                ),
                ScreenSize.width(15),
                Expanded(
                  child: btn(
                      title: getTranslated('accept', context)!,
                      color: AppColor.appTheme,
                      onTap: () {
                        openDialogBox(
                            title: getTranslated('accept', context)!,
                            subTitle: getTranslated(
                                'confirmation_accept_order', context)!,
                            noTap: () {
                              Navigator.pop(context);
                            },
                            yesTap: () {
                              Navigator.pop(context);
                              provider
                                  .acceptOrderApiFunction(model.id.toString());
                            });
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Drawer _drawer(ProfileProvider profileProvider) {
    var fName = '';
    var lName = '';
    var email = '';
    if (profileProvider.profileModel != null &&
        profileProvider.profileModel!.data != null &&
        profileProvider.profileModel!.data!.fName != null) {
      fName = profileProvider.profileModel!.data!.fName.toString().capitalize();
    }
    if (profileProvider.profileModel != null &&
        profileProvider.profileModel!.data != null &&
        profileProvider.profileModel!.data!.lName != null) {
      lName = profileProvider.profileModel!.data!.lName.toString().capitalize();
    }
    if (profileProvider.profileModel != null &&
        profileProvider.profileModel!.data != null &&
        profileProvider.profileModel!.data!.email != null) {
      email = profileProvider.profileModel!.data!.email;
    }
    return Drawer(
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    height: 102,
                    width: 102,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 4, color: AppColor.blueColor),
                    ),
                    child: profileProvider.profileImgUrl.isNotEmpty
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
                  ScreenSize.width(15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                            title: "$fName $lName",
                            size: 18,
                            fontFamily: FontFamily.poppinsMedium,
                            maxLies: 1,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w500),
                        getText(
                            title: email,
                            maxLies: 1,
                            size: 14,
                            fontFamily: FontFamily.nunitoMedium,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: AppColor.borderColor,
            ),
            ScreenSize.height(15),
            drawerTypes(
                img: AppImages.bankIcon,
                title: getTranslated('bank_details', context),
                index: 0),
            // drawerTypes(
            //     img: AppImages.walletIcon,
            //     title: getTranslated('wallet', context),
            //     index: 1),
            drawerTypes(
                img: AppImages.translateIcon,
                title: getTranslated('change_language', context),
                index: 1),
            const Spacer(),
            drawerTypes(
                img: AppImages.logoutIcon,
                title: getTranslated('logout', context),
                index: 2),
          ],
        ),
      ),
    );
  }

  drawerTypes({required String img, title, required int index}) {
    final profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
          AppRoutes.pushCupertinoNavigation(const BankDetailsScreen());
            break;
          case 1:
            SessionManager.languageCode == 'es'
            ? profileProvider.selectedLangIndex = 1
            : 0;
        openLanguageBox(profileProvider);
            break;
          case 2:
            openDialogBox(
                title: getTranslated("logout", context)!,
                subTitle: getTranslated("want_to_logout", context)!,
                noTap: () {
                  Navigator.pop(context);
                },
                yesTap: () async {
                  Utils.logOut();
                });
            break;
          default:
        }
      },
      child: Container(
        height: 45,
        width: double.infinity,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Row(
          children: [
            Image.asset(
              img,
              height: 20,
              width: 20,
            ),
            ScreenSize.width(15),
            getText(
                title: title,
                size: 16,
                fontFamily: FontFamily.poppinsMedium,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500)
          ],
        ),
      ),
    );
  }
}
