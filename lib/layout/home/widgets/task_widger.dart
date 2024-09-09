import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/detailsTask_widget.dart';
import 'package:todo_app/layout/home/widgets/editTasksheet.dart';
import 'package:todo_app/layout/home/widgets/priorityWidget.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';
import 'package:todo_app/style/app_colors.dart';

class TaskWidget extends StatelessWidget {
  task Task;
  TaskWidget({super.key, required this.Task});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    DateTime taskDate = DateTime.fromMillisecondsSinceEpoch(Task.date ?? 0);
    authprovider provider = Provider.of<authprovider>(context);
    HomeProvider providerhome = Provider.of<HomeProvider>(context);
    return Slidable(
      startActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: 0.4, children: [
        SlidableAction(
            onPressed: (context) async {
              log("id tas; ${Task.id.toString()}");
              await firestoreHelper.deleteTask(
                  userid: provider.firebaseAuthUser!.uid,
                  taskID: Task.id ?? "");
            },
            backgroundColor: appColors.removeTaskbackground,
            icon: Icons.delete,
            label: "Delete",
            autoClose: true,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, EditTasksheet.route_name,
                  arguments: Task);
            },
            backgroundColor: Colors.grey,
            icon: Icons.edit,
            label: "Edit",
            autoClose: true,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
      ]),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => DetailstaskWidget(
                    Task: Task,
                  ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Task.isDone!
                  ? IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        await firestoreHelper.getIsdone(
                            userid: provider.firebaseAuthUser!.uid,
                            taskID: Task.id!,
                            newValue: !Task.isDone!);
                      },
                      icon: Icon(
                        Icons.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ))
                  : IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        await firestoreHelper.getIsdone(
                            userid: provider.firebaseAuthUser!.uid,
                            taskID: Task.id!,
                            newValue: !Task.isDone!);
                      },
                      icon: Icon(
                        Icons.circle_outlined,
                        color: Theme.of(context).colorScheme.onSecondary,
                      )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Task.title ?? "",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          taskDate.day == DateTime.now().day &&
                                  taskDate.month == DateTime.now().month &&
                                  taskDate.year == DateTime.now().year
                              ? "Today At ${Task.time}"
                              : DateFormat.yMd().format(taskDate),
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                        const Spacer(),
                        priorityWidget(
                            index: Task.priority!,
                            widgetDirection:
                                WidgetDirection.horizontal.direction),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
