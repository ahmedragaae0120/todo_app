import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/task_widger.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class AllCompletedTasksStream extends StatelessWidget {
  const AllCompletedTasksStream({super.key});

  @override
  Widget build(BuildContext context) {
    authprovider providerAuth = Provider.of<authprovider>(context);
    HomeProvider providerHome = Provider.of<HomeProvider>(context);
    return StreamBuilder(
      stream: firestoreHelper.ListenToCompletedTasks(
          userid: providerAuth.firebaseAuthUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                Text("something went wrong ${snapshot.error}"),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Try agian")),
              ],
            ),
          );
        }
        List<task> tasks = snapshot.data ?? [];
        Future.delayed(const Duration(seconds: 1), () {
          providerHome
              .changeListOfCompletedTasksIsEmpty(tasks.isEmpty ? true : false);
        });

        return SliverList.separated(
          itemBuilder: (context, index) => TaskWidget(Task: tasks[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: tasks.length,
        );
      },
    );
  }
}
