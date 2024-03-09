import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';

class listTab extends StatelessWidget {
  const listTab({super.key});

  @override
  Widget build(BuildContext context) {
    homeProvider provider = Provider.of<homeProvider>(context);
    return Column(
      children: [
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now(),
          focusDate: provider.SelectedDate,
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateChange: (selectedDate) {
            provider.changeSelectedDate(selectedDate);
          },
          // controller:
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
      ],
    );
  }
}
