import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_app/model/task_model.dart';

class homeProvider extends ChangeNotifier {
  task? Task;
  int currentIndex = 0;
  bool isTextfiledIsEmpty = true;
  bool showbuttoncheek = true;
  String tabName = "Index";
  changeisDone(bool newValue) {
    if (showbuttoncheek == newValue) return;
    showbuttoncheek = newValue;
    notifyListeners();
  }

  changeCurrentIndex(int newCurrentIndex) {
    currentIndex = newCurrentIndex;
    notifyListeners();
  }

  changeTabName(String newTabName) {
    if (tabName == newTabName) return;
    tabName = newTabName;
    notifyListeners();
  }

  DateTime? SelectedDate = DateTime.now();
  changeSelectedDate(DateTime? newSelectedDate) {
    SelectedDate = newSelectedDate;
    notifyListeners();
  }

  int? priorityIndex;

  changePriorityIndex(int? newPriorityindex) {
    if (priorityIndex == newPriorityindex) return;
    priorityIndex = newPriorityindex;
    notifyListeners();
  }

  int priorityTask = 1;

  changePriorityTask(int newPriorityTask) {
    if (priorityTask == newPriorityTask) return;
    priorityTask = newPriorityTask;
    notifyListeners();
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  chageSelectedTime({TimeOfDay? newTime}) {
    if (newTime != null) {
      selectedTime = newTime;
      notifyListeners();
    }
    notifyListeners();
  }

  bool listOfAllTasksIsEmpty = false;
  changeListOfAllTasksIsEmpty(bool newlistOfTasksIsEmpty) {
    if (listOfAllTasksIsEmpty == newlistOfTasksIsEmpty) return;
    listOfAllTasksIsEmpty = newlistOfTasksIsEmpty;
    notifyListeners();
  }

  bool listOfCompletedTasksIsEmpty = false;
  changeListOfCompletedTasksIsEmpty(bool newlistOfCompletedTasksIsEmpty) {
    if (listOfCompletedTasksIsEmpty == newlistOfCompletedTasksIsEmpty) return;
    listOfCompletedTasksIsEmpty = newlistOfCompletedTasksIsEmpty;
    notifyListeners();
  }

  // bool cheekTextfiledIsEmpty(
  //     {required TextEditingController titleController,
  //     required TextEditingController descriptionController,
  //     required BuildContext context}) {
  //   if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
  //     isTextfiledIsEmpty = true;
  //     return true;
  //   }
  //   isTextfiledIsEmpty = false;
  //   return false;
  // }

  bool changeDone() {
    if (Task?.isDone == true) return false;
    Task?.isDone = true;
    notifyListeners();
    return true;
  }

  String dropdownLanguage = "en";
  String dropdownMode = "Light";
  changedropdownLanguage(String newLanguage) {
    if (dropdownLanguage == newLanguage) return;
    dropdownLanguage = newLanguage;
    notifyListeners();
  }

  changedropdownMode(String newMode) {
    if (dropdownMode == newMode) return;
    dropdownMode = newMode;
    notifyListeners();
  }
}
