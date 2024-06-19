import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/editTasksheet.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';
import 'package:todo_app/style/app_colors.dart';

class taskWidget extends StatelessWidget {
  task Task;
  taskWidget({super.key, required this.Task});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    DateTime taskDate = DateTime.fromMillisecondsSinceEpoch(Task.date ?? 0);
    authprovider provider = Provider.of<authprovider>(context);
    homeProvider providerhome = Provider.of<homeProvider>(context);
    return Slidable(
      startActionPane:
          ActionPane(motion: ScrollMotion(), extentRatio: 0.4, children: [
        SlidableAction(
          onPressed: (context) async {
            log("id tas; ${Task.id.toString()}");
            await firestoreHelper.deleteTask(
                userid: provider.firebaseAuthUser!.uid, taskID: Task.id ?? "");
          },
          backgroundColor: appColors.removeTaskbackground,
          icon: Icons.delete,
          label: "Delete",
          autoClose: true,
          borderRadius: BorderRadius.circular(20),
        ),
        SlidableAction(
          onPressed: (context) {
            Navigator.pushNamed(context, editTasksheet.route_name,
                arguments: Task);
          },
          backgroundColor: Colors.grey,
          icon: Icons.edit,
          label: "Edit",
          autoClose: true,
          borderRadius: BorderRadius.circular(20),
        ),
      ]),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Row(
          children: [
            Container(
              height: height * 0.1,
              width: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Task.isDone == false
                    ? Theme.of(context).colorScheme.primary
                    : appColors.Donetask,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Task.title ?? "",
                    style: Task.isDone == false
                        ? Theme.of(context).textTheme.bodyLarge
                        : Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      Text(
                        "${DateFormat.yMd().format(taskDate)}",
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Task.isDone!
                ? TextButton(
                    onPressed: () async {
                      await firestoreHelper.getIsdone(
                          userid: provider.firebaseAuthUser!.uid,
                          taskID: Task.id!,
                          newValue: !Task.isDone!);
                    },
                    child: Text(
                      "Done !",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      await firestoreHelper.getIsdone(
                          userid: provider.firebaseAuthUser!.uid,
                          taskID: Task.id!,
                          newValue: !Task.isDone!);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Icon(Icons.check)),
          ],
        ),
      ),
    );
  }
}
