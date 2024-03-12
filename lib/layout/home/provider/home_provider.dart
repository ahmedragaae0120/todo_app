import 'package:flutter/material.dart';

class homeProvider extends ChangeNotifier {
  int currentIndex = 0;
  bool isTextfiledIsEmpty = true;
  changeCurrentIndex(int newCurrentIndex) {
    currentIndex = newCurrentIndex;
    notifyListeners();
  }

  DateTime? SelectedDate;
  changeSelectedDate(DateTime? newSelectedDate) {
    SelectedDate = newSelectedDate;
    notifyListeners();
  }

  bool cheekTextfiledIsEmpty(
      {required TextEditingController titleController,
      required TextEditingController descriptionController,
      required BuildContext context}) {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      isTextfiledIsEmpty = true;
      return true;
    }
    isTextfiledIsEmpty = false;
    return false;
  }
}
