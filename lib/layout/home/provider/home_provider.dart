import 'package:flutter/material.dart';

class homeProvider extends ChangeNotifier {
  int currentIndex = 0;
  DateTime SelectedDate = DateTime.now();
  changeCurrentIndex(int newCurrentIndex) {
    currentIndex = newCurrentIndex;
    notifyListeners();
  }

  changeSelectedDate(DateTime newSelectedDate) {
    SelectedDate = newSelectedDate;
    notifyListeners();
  }

  bool cheekTextfiledIsEmpty(TextEditingController titleController,
      TextEditingController descriptionController, BuildContext context) {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      Navigator.pop(context);
      return true;
    }
    return false;
  }
}
