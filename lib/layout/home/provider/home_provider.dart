import 'package:flutter/material.dart';
import 'package:todo_app/model/task_model.dart';

class homeProvider extends ChangeNotifier {
  task? Task;
  int currentIndex = 0;
  bool isTextfiledIsEmpty = true;
  bool showbuttoncheek = true;
  changeisDone(bool newValue) {
    if (showbuttoncheek == newValue) return;
    showbuttoncheek = newValue;
    notifyListeners();
  }

  changeCurrentIndex(int newCurrentIndex) {
    currentIndex = newCurrentIndex;
    notifyListeners();
  }

  DateTime? SelectedDate = DateTime.now();
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

  bool changeDone() {
    if (Task?.isDone == true) return false;
    Task?.isDone = true;
    notifyListeners();
    return true;
  }
}
