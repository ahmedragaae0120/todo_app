import 'package:flutter/material.dart';

class homeProvider extends ChangeNotifier {
  int currentIndex = 0;
  changeCurrentIndex(int newCurrentIndex) {
    currentIndex = newCurrentIndex;
    notifyListeners();
  }
}
