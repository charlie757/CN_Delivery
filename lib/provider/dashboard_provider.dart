import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 0;

  updateIndex(value) {
    currentIndex = value;
    notifyListeners();
  }
}
