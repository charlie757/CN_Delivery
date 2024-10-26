import "package:flutter/material.dart";

import "../helper/appcolor.dart";
customRadio(int index,selectedIndex,{Color color =AppColor.blueColor, Color borderColor = AppColor.lightTextColor}){
  return Container(height: 20,
    width: 20,
    decoration: BoxDecoration(
      shape: BoxShape.circle,

      border: Border.all(color: borderColor),
    ),
    alignment: Alignment.center,
    padding:const EdgeInsets.all(3),
    child: selectedIndex==index? Container(
      height: 18,width: 18,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color
      ),
    ):Container(),
  );
}

