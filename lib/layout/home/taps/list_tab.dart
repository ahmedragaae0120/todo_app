import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/task_widger.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class listTab extends StatelessWidget {
  const listTab({super.key});

  @override
  Widget build(BuildContext context) {
    homeProvider provider = Provider.of<homeProvider>(context);
    authprovider providerauth = Provider.of<authprovider>(context);
    return Column(
      children: [
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now(),
          focusDate: provider.SelectedDate,
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateChange: (selectedDate) {
            provider.changeSelectedDate(DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day));
          },
          showTimelineHeader: false,
          dayProps: EasyDayProps(
            todayHighlightColor: Theme.of(context).colorScheme.onSecondary,
            todayStyle: DayStyle(
              borderRadius: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.onPrimary,
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 3),
              ),
            ),
            activeDayStyle: DayStyle(borderRadius: 30),
            inactiveDayStyle: DayStyle(
              borderRadius: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
          locale: "ar",
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder(
            stream: firestoreHelper.ListenToTasks(
                userid: providerauth.firebaseAuthUser!.uid,
                date: provider.SelectedDate!.millisecondsSinceEpoch),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text("something went wrong ${snapshot.error}"),
                    ElevatedButton(onPressed: () {}, child: Text("Try agian")),
                  ],
                );
              }
              List<task> tasks = snapshot.data ?? [];
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return taskWidget(Task: tasks[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemCount: tasks.length);
            },
          ),
        )),
      ],
    );
  }
}
