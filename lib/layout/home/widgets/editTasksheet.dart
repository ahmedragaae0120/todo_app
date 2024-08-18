import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';
import 'package:todo_app/shared/reusable_commponets/custom_text_filed.dart';

class editTasksheet extends StatefulWidget {
  static const String route_name = "editTasksheet";
  TextEditingController titleController = TextEditingController();
  TextEditingController descreptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  editTasksheet({super.key});

  @override
  State<editTasksheet> createState() => _addTaskSheetState();
}

class _addTaskSheetState extends State<editTasksheet> {
  @override
  Widget build(BuildContext context) {
    homeProvider providerhome = Provider.of<homeProvider>(context);
    authprovider provider = Provider.of<authprovider>(context);
    final task Task = ModalRoute.of(context)?.settings.arguments as task;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: height * 0.2,
        title: const Text("To Do List"),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            child: Form(
              key: widget.formkey,
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
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  customTextfiled(
                    lable: "This is title",
                    keyboard: TextInputType.text,
                    controller: widget.titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Title can't be empty";
                      }
                      return null;
                    },
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  const SizedBox(height: 20),
                  customTextfiled(
                    lable: "This is description",
                    keyboard: TextInputType.multiline,
                    controller: widget.descreptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Description can't be empty";
                      }
                      return null;
                    },
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                          initialDate: DateTime.now(),
                        );
                        providerhome.changeSelectedDate(selectedDate);
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("select date:",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontSize: 20)),
                          providerhome.SelectedDate == null
                              ? Text(
                                  " __  /  __  /  __  ",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              : Text(
                                  "${providerhome.SelectedDate?.day} / ${providerhome.SelectedDate?.month} / ${providerhome.SelectedDate?.year} ",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (widget.formkey.currentState!.validate()) {
                              // await firestoreHelper.editTask(
                              //     userid: provider.firebaseAuthUser!.uid,
                              //     taskID: Task.id ?? "",
                              //     task: task(
                              //       title: widget.titleController.text,
                              //       descripion:
                              //           widget.descreptionController.text,
                              //       date: DateTime(
                              //         providerhome.SelectedDate!.year,
                              //         providerhome.SelectedDate!.month,
                              //         providerhome.SelectedDate!.day,
                              //       ).millisecondsSinceEpoch,
                              //       time: providerhome.selectedTime
                              //           .format(context),
                              //       id: Task.id ?? "",
                              //     ));
                              Navigator.pop(context);
                              log("id task after edit ${Task.id.toString()}");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary),
                          child: const Text("Save Changes")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
