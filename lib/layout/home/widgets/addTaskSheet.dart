import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/shared/reusable_commponets/custom_text_filed.dart';

class addTaskSheet extends StatefulWidget {
  TextEditingController titleController;

  TextEditingController descriptionController;

  GlobalKey<FormState> formkey;
  addTaskSheet(
      {super.key,
      required this.descriptionController,
      required this.titleController,
      required this.formkey});

  @override
  State<addTaskSheet> createState() => _addTaskSheetState();
}

class _addTaskSheetState extends State<addTaskSheet> {
  @override
  Widget build(BuildContext context) {
    homeProvider providerhome = Provider.of<homeProvider>(context);
    cheekTextfiledIsEmpty(context);
    return SingleChildScrollView(
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Theme.of(context).colorScheme.onPrimary,
          child: Form(
            key: widget.formkey,
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
                  controller: widget.titleController,
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
                  controller: widget.descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Description can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                      initialDate: DateTime.now(),
                    );
                    providerhome.changeSelectedDate(selectedDate);
                    setState(() {});
                  },
                  child: providerhome.SelectedDate == null
                      ? Text("select date")
                      : Text(
                          "${providerhome.SelectedDate?.day} / ${providerhome.SelectedDate?.month} / ${providerhome.SelectedDate?.year} "),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool cheekTextfiledIsEmpty(BuildContext context) {
    homeProvider provider = Provider.of<homeProvider>(context, listen: false);
    return provider.cheekTextfiledIsEmpty(
        titleController: widget.titleController,
        descriptionController: widget.descriptionController,
        context: context);
  }
}
