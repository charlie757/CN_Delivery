import 'package:cn_delivery/config/approutes.dart';
import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/network_image_helper.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/current_order_model.dart';
import 'package:cn_delivery/model/order_model.dart';
import 'package:cn_delivery/provider/current_order_provider.dart';
import 'package:cn_delivery/screens/view_order_details_screen.dart';
import 'package:cn_delivery/utils/constants.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/order_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentOrderScreen extends StatefulWidget {
  const CurrentOrderScreen({super.key});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider =
        Provider.of<CurrentOrderProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      myProvider.callApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentOrderProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
          appBar: appBar(title: getTranslated('current_order', context)!),
          body: myProvider.currentOrderList.isEmpty
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
                  itemCount: myProvider.currentOrderList.length,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 40, top: 20),
                  itemBuilder: (context, index) {
                    var model =
                        OrderModel.fromJson(myProvider.currentOrderList[index]);
                    return orderWidget(
                     model: model,
                     context: context,
                     onTap:  () {
                        AppRoutes.pushCupertinoNavigation(
                            ViewOrderDetailsScreen(
                          orderId: model.id.toString(),
                        )).then((value) {
                          myProvider.callApiFunction();
                        });
                      },
                    );
                  }));
    });
  }
}
