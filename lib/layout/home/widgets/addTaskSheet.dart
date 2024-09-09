import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/dialog.dart';

import 'package:todo_app/shared/reusable_commponets/custom_text_filed.dart';

class addTaskSheet extends StatefulWidget {
  const addTaskSheet({
    super.key,
  });

  @override
  State<addTaskSheet> createState() => _addTaskSheetState();
}

class _addTaskSheetState extends State<addTaskSheet> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    homeProvider providerHome = Provider.of<homeProvider>(context);
    return SingleChildScrollView(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add Task".tr(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 15),
                customTextfiled(
                  hintText: "Enter task title".tr(),
                  keyboard: TextInputType.text,
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title can't be empty".tr();
                    }
                    return null;
                  },
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                const SizedBox(height: 20),
                customTextfiled(
                  hintText: "Enter task description".tr(),
                  keyboard: TextInputType.multiline,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description can't be empty".tr();
                    }
                    return null;
                  },
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.timer_outlined,
                          color: Theme.of(context).colorScheme.onSecondary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark_add_outlined,
                          color: Theme.of(context).colorScheme.onSecondary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.flag_outlined,
                          color: Theme.of(context).colorScheme.onSecondary,
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          if ((formkey.currentState?.validate() ?? false) &&
                              providerHome.SelectedDate != null) {
                            if (formkey.currentState?.validate() == false) {
                              return;
                            }
                            _showDatePicker(context);
                          }
                        },
                        icon: Icon(
                          Icons.send_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    homeProvider provider = Provider.of<homeProvider>(context, listen: false);

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: provider.selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor:
                  Theme.of(context).colorScheme.primary, // خلفية كاملة للمحدد
              hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Colors.black
                      : Colors.white), // لون النص
              hourMinuteColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.grey[800] ??
                          Colors.grey), // لون مربع الساعة والدقائق
              dayPeriodColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.grey[800] ?? Colors.grey), // لون مربع AM/PM
              dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Colors.black
                      : Colors.white), // لون نص AM/PM
              dialHandColor: Theme.of(context)
                  .colorScheme
                  .secondary, // لون المؤشر عند السحب
              dialBackgroundColor: Theme.of(context)
                  .colorScheme
                  .tertiary, // لون خلفية الدائرة الكبيرة
              entryModeIconColor:
                  Colors.white, // لون رمز التبديل بين نمطي الإدخال
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ), // شكل الساعة والدقائق
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ), // شكل AM/PM
              helpTextStyle: const TextStyle(
                color: Colors.white,
              ), // لون النص العلوي
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context)
                    .colorScheme
                    .secondary, // لون النص لأزرار Cancel و Save
                backgroundColor: Colors.transparent,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime == null) {
      await provider.chageSelectedTime(newTime: TimeOfDay.now());
    }
    await provider.chageSelectedTime(newTime: selectedTime);
  }

  Future<void> _showDatePicker(BuildContext context) async {
    homeProvider provider = Provider.of<homeProvider>(context, listen: false);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: DateTime.now(),
      // textDirection: TextDirection.ltr,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            iconTheme: const IconThemeData(
              color: Colors.white, // تغيير لون أيقونات تغيير الشهر
            ),
          ),
          child: child!,
        );
      },
    );
    provider.changeSelectedDate(selectedDate);
    if (selectedDate == null) return;
    await _selectTime(context);
    log(provider.selectedTime.format(context).toString());
    Showdialogs.showPriorityDialog(
      context: context,
      title: titleController.text,
      descripion: descriptionController.text,
    );
  }

  // bool cheekTextfiledIsEmpty(BuildContext context) {
  //   homeProvider provider = Provider.of<homeProvider>(context, listen: false);
  //   return provider.cheekTextfiledIsEmpty(
  //       titleController: titleController,
  //       descriptionController: descriptionController,
  //       context: context);
  // }
}
