import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';
import 'package:todo_app/shared/reusable_commponets/custom_text_filed.dart';

class editTasksheet extends StatefulWidget {
  static const String route_name = "editTasksheet";

  editTasksheet({
    super.key,
  });

  @override
  State<editTasksheet> createState() => _addTaskSheetState();
}

class _addTaskSheetState extends State<editTasksheet> {
  @override
  Widget build(BuildContext context) {
    homeProvider providerhome = Provider.of<homeProvider>(context);
    authprovider provider = Provider.of<authprovider>(context);
    TextEditingController titleController = TextEditingController();
    TextEditingController descreptionController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    task args = ModalRoute.of(context)!.settings.arguments as task;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Edit Task",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  customTextfiled(
                    lable: "This is title",
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
                    lable: "This is description",
                    keyboard: TextInputType.multiline,
                    controller: descreptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Description can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: InkWell(
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
                  ),
                  SizedBox(height: 30),
                  Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate() ?? false) {
                              await firestoreHelper.editTask(
                                  userid: provider.firebaseAuthUser!.uid,
                                  taskID: args.id!,
                                  task: task(
                                    title: titleController.text,
                                    descripion: descreptionController.text,
                                    date: DateTime(
                                      providerhome.SelectedDate!.year,
                                      providerhome.SelectedDate!.month,
                                      providerhome.SelectedDate!.day,
                                    ).millisecondsSinceEpoch,
                                  ));
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary),
                          child: Text("Save Changes")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
