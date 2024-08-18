import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/widgets/task_widger.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    authprovider providerAuth = Provider.of<authprovider>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: firestoreHelper.ListenToHistoryTasks(
            userid: providerAuth.firebaseAuthUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            const Center(child: Text("No Internet"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text("something went wrong ${snapshot.error}"),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Try agian")),
                ],
              ),
            );
          }
          List<task> Tasks = snapshot.data ?? [];

          return ListView.separated(
            itemBuilder: (context, index) => taskWidget(Task: Tasks[index]),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 10,
            ),
            itemCount: Tasks.length,
          );
        },
      ),
    );
  }
}
