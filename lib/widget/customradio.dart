import "package:flutter/material.dart";

import "../helper/appcolor.dart";
customRadio(int index,selectedIndex){
  return Container(height: 20,
    width: 20,
    decoration: BoxDecoration(
      shape: BoxShape.circle,

      border: Border.all(color: AppColor.lightTextColor),
    ),
    alignment: Alignment.center,
    padding:const EdgeInsets.all(3),
    child: selectedIndex==index? Container(
      height: 18,width: 18,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.blueColor
      ),
    ):Container(),
  );
}

