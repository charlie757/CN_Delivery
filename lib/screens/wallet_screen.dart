import 'package:cn_delivery/helper/appImages.dart';
import 'package:cn_delivery/helper/appbutton.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/wallet_provider.dart';
import 'package:cn_delivery/utils/time_format.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/btn_widget.dart';
import 'package:cn_delivery/widget/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitialFunction();
    });
    super.initState();
  }

  callInitialFunction() async {
    final provider = Provider.of<WalletProvider>(context, listen: false);
    provider.walletEarnApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(
        title: getTranslated('wallet', context)!,
      ),
      body: Consumer<WalletProvider>(builder: (context, myProvider, child) {
        var model = myProvider.model != null && myProvider.model!.data != null
            ? myProvider.model!.data
            : null;
        return SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 30),
          child: Column(
            children: [
              remainingBalanceWidget(myProvider),
              ScreenSize.height(20),
              balanceDetailsWidget(
                  amount: model != null ? model.totalEarn.toString() : '0',
                  title: getTranslated('total_earned', context)!,
                  img: AppImages.pwIcon),
              ScreenSize.height(20),
              balanceDetailsWidget(
                  amount:
                      model != null ? model.adminCommission.toString() : '0',
                  title: getTranslated('total_consumed', context)!,
                  img: AppImages.pwIcon),
              ScreenSize.height(20),
              balanceDetailsWidget(
                  amount: model != null
                      ? model.withdrawableBalance.toString()
                      : '0',
                  title: getTranslated('balance_to_be_transferred', context)!,
                  img: AppImages.pwIcon),
              ScreenSize.height(20),
              warningBalanceWidget(),
              ScreenSize.height(20),
              transactionWidget(myProvider)
              // recentTranscationWidget(myProvider)
            ],
          ),
        );
      }),
    );
  }

  remainingBalanceWidget(WalletProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 4)
          ]),
      child: Column(
        children: [
          Image.asset(
            AppImages.withdrawIcon,
            height: 48,
          ),
          ScreenSize.height(7),
          getText(
              title:
                  '\$ ${provider.model != null && provider.model!.data != null ? provider.model!.data!.currentBalance : "0"}',
              size: 25,
              fontFamily: FontFamily.poppinsSemiBold,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
          ScreenSize.height(2),
           getText(
              title: getTranslated('remaining_balances', context)!,
              size: 15,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.lightTextColor,
              fontWeight: FontWeight.w400),
          ScreenSize.height(25),
          btn(
              title: getTranslated('withdraw', context)!,
              width: 120,
              height: 45,
              color: AppColor.blueColor,
              onTap: (){
                dialogBox();
              }
              ),
              
        ],
      ),
    );
  }

  balanceDetailsWidget(
      {required String amount, required String title, required String img}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 4)
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(
                    title: '\$ $amount',
                    size: 23,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                getText(
                    title: title,
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w400),
              ],
            ),
          ),
          Image.asset(
            img,
            height: 48,
          )
        ],
      ),
    );
  }

  warningBalanceWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 4)
          ]),
      child: getText(
          title:
              getTranslated('balance_transferred_msg', context)!,
          size: 14,
          fontFamily: FontFamily.poppinsMedium,
          color: AppColor.redColor,
          fontWeight: FontWeight.w500),
    );
  }

  transactionWidget(WalletProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 4)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: getText(
                title: getTranslated('recent_transcation', context)!,
                size: 14,
                fontFamily: FontFamily.nunitoMedium,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500),
          ),
          ScreenSize.height(20),
          provider.model != null && provider.model!.data != null
              ? provider.model!.data!.transactionHistory!.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, sp) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin:const EdgeInsets.symmetric(vertical: 20),
                          color: AppColor.borderD9Color,
                          height: 1,
                        );
                      },
                      itemCount:
                          provider.model!.data!.transactionHistory!.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return walletTransaction(context, index, provider);
                      })
                  : noDataFound(
                      getTranslated('no_transaction_history', context)!)
              : Container()
        ],
      ),
    );
  }

  recentTranscationWidget(WalletProvider provider) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: AppColor.blackColor.withOpacity(.1),
                blurRadius: 10)
          ]),
      padding: const EdgeInsets.only(top: 20, left: 23, right: 17, bottom: 18),
      child: Column(
        children: [
          Center(
            child: getText(
                title: getTranslated('recent_transcation', context)!,
                size: 14,
                fontFamily: FontFamily.nunitoMedium,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500),
          ),
          provider.model != null && provider.model!.data != null
              ? provider.model!.data!.transactionHistory!.isNotEmpty
                  ? ListView.builder(
                      itemCount:
                          provider.model!.data!.transactionHistory!.length,
                      padding: const EdgeInsets.only(top: 15),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return walletTransaction(context, index, provider);
                      })
                  : noDataFound(
                      getTranslated('no_transaction_history', context)!)
              : Container()
        ],
      ),
    );
  }

  walletTransaction(BuildContext context, int index, WalletProvider provider) {
    var model = provider.model!.data!.transactionHistory![index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customTransactionColumn(
                  title: getTranslated('Debit', context)!, subTitle: model.debit ?? ''),
              customTransactionColumn(
                  title: getTranslated('Credit', context)!, subTitle: model.credit ?? ''),
              customTransactionColumn(
                  title: getTranslated('Balance', context)!, subTitle: model.balance ?? ''),
            ],
          ),
          ScreenSize.height(10),
          Row(
            children: [
              getText(
                  title: "${getTranslated('transaction_type', context)}: ",
                  size: 12,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor.withOpacity(.7),
                  fontWeight: FontWeight.w400),
              ScreenSize.height(3),
              Expanded(
                child: getText(
                    title:
                        model.transactionType.toString().replaceAll('_', ' '),
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          ScreenSize.height(7),
          Row(
            children: [
              getText(
                  title: "${getTranslated('date', context)}: ",
                  size: 12,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.blackColor.withOpacity(.7),
                  fontWeight: FontWeight.w400),
              ScreenSize.height(3),
              Expanded(
                child: getText(
                    title: TimeFormat.convertDateWithTime(model.createdAt),
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  customTransactionColumn({required String title, required String subTitle}) {
    return Column(
      children: [
        getText(
            title: title,
            size: 12,
            fontFamily: FontFamily.poppinsRegular,
            color: AppColor.blackColor.withOpacity(.7),
            fontWeight: FontWeight.w400),
        ScreenSize.height(3),
        getText(
            title: subTitle,
            size: 14,
            fontFamily: FontFamily.poppinsMedium,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500),
      ],
    );
  }

dialogBox(){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      content: getText(title: getTranslated('coming_soon', context)!, size: 18,
       fontFamily: FontFamily.poppinsMedium, color: AppColor.blackColor, fontWeight: FontWeight.w400),
       actions: [
        btn(title: getTranslated('Okay', context)!,
        color: AppColor.blueColor,
        height:40,width: 80,
        onTap:(){
          Navigator.pop(context);
        }
        )
       ],
    );
  });
}

}
