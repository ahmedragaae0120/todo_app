import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/priorityWidget.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/dialog_utlis.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class Showdialogs {
  static void showPriorityDialog({
    required BuildContext context,
    required String? title,
    required String? descripion,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        homeProvider providerHome =
            Provider.of<homeProvider>(context, listen: false);
        authprovider providerauth =
            Provider.of<authprovider>(context, listen: false);
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Center(
            child: Text(
              'Task Priority',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.maxFinite,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 16, mainAxisSpacing: 16),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return priorityWidget(
                  index: index + 1,
                  widgetDirection: WidgetDirection.vertical.direction,
                );
              },
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                    onPressed: () async {
                      await firestoreHelper.AddNewTask(
                          task: task(
                            title: title,
                            descripion: descripion,
                            date: providerHome
                                .SelectedDate!.millisecondsSinceEpoch,
                            priority: providerHome.priorityTask,
                            time: providerHome.selectedTime.format(context),
                          ),
                          userid: providerauth.firebaseAuthUser!.uid);
                      dialogUtils.showMessage(
                        context: context,
                        message: "task added Successfuly",
                        positiveText: "ok",
                        positiveButton: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Text("Save",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        )),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
