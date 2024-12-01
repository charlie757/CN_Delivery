import 'package:cn_delivery/helper/appImages.dart';
import 'package:flutter/material.dart';

Widget topLogo({Alignment alignment = Alignment.center}) {
  return Align(
    alignment: alignment,
    child: Image.asset(
      AppImages.appIcon,
      width: 165,
      fit: BoxFit.cover,
    ),
  );
}
