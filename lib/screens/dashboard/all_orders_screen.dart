import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/order_model.dart';
import 'package:cn_delivery/provider/all_order_provider.dart';
import 'package:cn_delivery/screens/dashboard/view_order_details_screen.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<AllOrderProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      myProvider.getAllOrderApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(title: getTranslated('all_orders', context)!),
      body: Consumer<AllOrderProvider>(builder: (context, myProvider, child) {
        return myProvider.allOrderList.isEmpty
            ? Center(
                child: getText(
                    title: getTranslated('no_order_found', context)!,
                    size: 16,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w400),
              )
            : ListView.separated(
                separatorBuilder: (context, sp) {
                  return ScreenSize.height(15);
                },
                itemCount: myProvider.allOrderList.length,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 40, top: 20),
                itemBuilder: (context, index) {
                  var model =
                      OrderModel.fromJson(myProvider.allOrderList[index]);
                  return orderWidget(
                     model: model,
                     context: context,
                     onTap:  () {
                        AppRoutes.pushCupertinoNavigation(
                            ViewOrderDetailsScreen(
                          orderId: model.id.toString(),
                        )).then((value) {
                          myProvider.getAllOrderApiFunction();
                        });
                      },
                     );
                });
      }),
    );
  }

}
