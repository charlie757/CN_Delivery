import 'package:cn_delivery/helper/appcolor.dart';
import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/provider/notification_provider.dart';
import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: appbarWithLeading(getTranslated('notification', context)!),
      );
    });
  }
}
