import 'package:flutter/material.dart';
import 'package:todo_app/shared/reusable_commponets/custom_text_filed.dart';

class addTaskSheet extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  addTaskSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Theme.of(context).colorScheme.onPrimary,
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add new Task",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                customTextfiled(
                  lable: "Enter task title",
                  keyboard: TextInputType.text,
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Title can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                customTextfiled(
                  lable: "Enter task description",
                  keyboard: TextInputType.multiline,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Description can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)));
                  },
                  child: Text("select date"),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
