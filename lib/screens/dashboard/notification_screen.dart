import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/helper/fontfamily.dart';
import 'package:cn_delivery/helper/gettext.dart';
import 'package:cn_delivery/helper/screensize.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/notification_provider.dart';
import 'package:cn_delivery/utils/time_format.dart';
import 'package:cn_delivery/utils/utils.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:cn_delivery/widget/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction()async{
    final provider  = Provider.of<NotificationProvider>(context,listen: false);
    Future.delayed(Duration.zero,(){
      provider.callApiFunction();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: appbarWithLeading(getTranslated('notification', context)!),
        body: myProvider.model!=null&&myProvider.model!.data!=null&&
        myProvider.model!.data!.notifications!.isNotEmpty? ListView.separated(
          separatorBuilder: (context,sp){
            return ScreenSize.height(16);
          },
          shrinkWrap: true,
          padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          itemCount: myProvider.model!.data!.notifications!.length,
          itemBuilder: (context,index){
            var model = myProvider.model!.data!.notifications![index];
          return notificationWidget(name: model.order!=null&&model.order!.customer!=null?
          "${model.order!.customer!.fName.toString().capitalize()} ${model.order!.customer!.lName.toString().capitalize()}":'',date: model.createdAt);
        }):noDataFound(getTranslated('no_notifications', context)!),
      );
    });
  }


  notificationWidget({required String name, required String date}){
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffF5F5F5)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2,
                color: AppColor.blackColor.withOpacity(.2))
          ]),
      padding: const EdgeInsets.only(top: 15, left: 17, right: 15, bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
          children: [
          Expanded(
            child: getText(title: getTranslated('new_order_received', context)!,
             size: 16, fontFamily: FontFamily.nunitoMedium,
              color: AppColor.blackColor, fontWeight: FontWeight.w500),
          ),
          getText(title: TimeFormat.convertNotificationDate(date),
           size: 14, fontFamily: FontFamily.nunitoMedium,
            color: AppColor.blackColor, fontWeight: FontWeight.w400),
          ],
        ),
        ScreenSize.height(5),
        Text.rich(
          TextSpan(
            text: '${getTranslated('new_order_received', context)!} ${getTranslated('from', context)!} ',
            style:const TextStyle(
              fontSize: 14, fontFamily: FontFamily.nunitoRegular,
              color: AppColor.lightTextColor, fontWeight: FontWeight.w400
            ),
            children: [
              TextSpan(
                text: name,
              style: TextStyle(
              fontSize: 14, fontFamily: FontFamily.nunitoMedium,
              color: AppColor.blackColor, fontWeight: FontWeight.w500
            ),
              )
            ]
          )
        ),
        ],
      ),
    );
  }
}
