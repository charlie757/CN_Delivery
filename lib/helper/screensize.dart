import 'package:flutter/material.dart';

class ScreenSize {
  static Widget height(double size) {
    return SizedBox(
      height: size,
    );
  }

  static Widget width(double size) {
    return SizedBox(
      width: size,
    );
  }
}
