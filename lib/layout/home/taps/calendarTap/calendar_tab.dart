import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/task_widger.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class listTab extends StatefulWidget {
  const listTab({super.key});

  @override
  State<listTab> createState() => _listTabState();
}

class _listTabState extends State<listTab> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    authprovider providerauth = Provider.of<authprovider>(context);

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: provider.SelectedDate!,
                  calendarFormat: CalendarFormat.week,
                  selectedDayPredicate: (day) {
                    return isSameDay(provider.SelectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    provider.changeSelectedDate(DateTime(
                      selectedDay.year,
                      selectedDay.month,
                      selectedDay.day,
                    ));
                    log(provider.SelectedDate.toString());
                  },

                  // onPageChanged: (focusedDay) {
                  //   log(focusedDay.toString());
                  //   provider.SelectedDate = focusedDay;
                  // },
                  onFormatChanged: (format) {
                    log(format.toString());
                  },
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: false,
                    defaultDecoration: const BoxDecoration(
                      color: Color(0xff272727),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    weekendDecoration: BoxDecoration(
                      color: const Color(0xff272727),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    weekendTextStyle: const TextStyle(color: Colors.red),
                    defaultTextStyle: const TextStyle(color: Colors.white),
                    disabledTextStyle: TextStyle(color: Colors.grey[700]),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                    weekdayStyle: TextStyle(color: Colors.white),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(color: Colors.white),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  daysOfWeekVisible: true,
                  daysOfWeekHeight: 16.0,
                ),
              ),
            ),
          ],
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
            stream: firestoreHelper.ListenToTasks(
                userid: providerauth.firebaseAuthUser!.uid,
                date: provider.SelectedDate!.millisecondsSinceEpoch),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
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
              List<task> tasks = snapshot.data ?? [];
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskWidget(Task: tasks[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemCount: tasks.length);
            },
          ),
        )),
      ],
    );
  }
}
