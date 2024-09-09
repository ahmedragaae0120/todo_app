import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/task_widger.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class AllTasksStream extends StatelessWidget {
  const AllTasksStream({super.key});

  @override
  Widget build(BuildContext context) {
    authprovider providerAuth = Provider.of<authprovider>(context);
    homeProvider providerHome = Provider.of<homeProvider>(context);

    return StreamBuilder(
      stream: firestoreHelper.ListenToAllTasks(
          userid: providerAuth.firebaseAuthUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Text(
                    "something went wrong ${snapshot.error}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Try agian")),
                ],
              ),
            ),
          );
        }
        List<task> tasks = snapshot.data ?? [];
        Future.delayed(const Duration(seconds: 1), () {
          providerHome
              .changeListOfAllTasksIsEmpty(tasks.isEmpty ? true : false);
        });
        return SliverList.separated(
          itemBuilder: (context, index) => taskWidget(Task: tasks[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: tasks.length,
        );
      },
    );
  }
}


// Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 120,
//                     ),
//                     Align(child: Image.asset("assets/images/Checklist.png")),
//                     Text(
//                       "What do you want to do today?",
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyLarge!
//                           .copyWith(color: Colors.white, fontSize: 20),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Tap + to add your tasks",
//                       style: Theme.of(context).textTheme.bodySmall,
//                     )
//                   ],
//                 ),

