import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class DetailstaskWidget extends StatelessWidget {
  final task Task;
  const DetailstaskWidget({super.key, required this.Task});

  @override
  Widget build(BuildContext context) {
    DateTime taskDate = DateTime.fromMillisecondsSinceEpoch(Task.date ?? 0);
    authprovider provider = Provider.of<authprovider>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primary,
        ),
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(border: InputBorder.none),
              controller: TextEditingController(
                text: Task.title ?? "",
              ),
              style: const TextStyle(color: Colors.white, fontSize: 20),
              cursorColor: Theme.of(context).colorScheme.secondary,
              onChanged: (value) async {
                log(value.toString());
                log(selectedEditTask.description.selectedEdit.toString());
                await firestoreHelper.editTask(
                  userid: provider.firebaseAuthUser!.uid,
                  taskID: Task.id ?? "",
                  selectedEditTask: selectedEditTask.title.selectedEdit,
                  descripTion: value,
                );
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMd().format(taskDate),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  Task.time ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "${Task.descripion?.trim().length ?? "No Descripion"} character",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
            Divider(
              thickness: 3,
              height: 6,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              decoration: const InputDecoration(border: InputBorder.none),
              controller: TextEditingController(text: Task.descripion ?? ""),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              minLines: 1,
              maxLines: 10,
              cursorColor: Theme.of(context).colorScheme.secondary,
              onChanged: (value) async {
                log(value.toString());
                log(selectedEditTask.description.selectedEdit.toString());
                await firestoreHelper.editTask(
                  userid: provider.firebaseAuthUser!.uid,
                  taskID: Task.id ?? "",
                  selectedEditTask: selectedEditTask.description.selectedEdit,
                  descripTion: value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum selectedEditTask {
  title("title"),
  description("descripion");

  final String selectedEdit;
  const selectedEditTask(this.selectedEdit);
}

// void showDetailsTaskDialog({
//   required BuildContext context,
//   required task Task,
// }) async {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         content: DetailstaskWidget(Task: Task),
//         actions: const [],
//       );
//     },
//   );
// }
