import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';

class priorityWidget extends StatefulWidget {
  final int index;
  final String widgetDirection;

  const priorityWidget(
      {super.key, required this.index, required this.widgetDirection});

  @override
  State<priorityWidget> createState() => _priorityWidgetState();
}

class _priorityWidgetState extends State<priorityWidget> {
  // bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    HomeProvider providerHome = Provider.of<HomeProvider>(context);
    bool isSelected = providerHome.priorityIndex == widget.index - 1;
    return widget.widgetDirection == WidgetDirection.vertical.direction
        ? InkWell(
            onTap: () {
              setState(() {
                if (isSelected) {
                  providerHome.changePriorityIndex(null);
                  log(true.toString());
                  // log(providerHome.priorityTask.toString());
                  // log(providerHome.priorityIndex.toString());
                } else {
                  providerHome.changePriorityTask(widget.index);
                  providerHome.changePriorityIndex(widget.index - 1);
                  log(false.toString());
                  log(providerHome.priorityTask.toString());
                  log(providerHome.priorityIndex.toString());
                }
              });
            },
            child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.secondary
                        : const Color(0xff272727),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flag_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${widget.index}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    )
                  ],
                )))
        : Container(
            height: 30,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary)),
            child: Row(
              children: [
                Icon(
                  Icons.flag_outlined,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${widget.index}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                )
              ],
            ));
  }
}

enum WidgetDirection {
  vertical("vertical"),
  horizontal("horizontal");

  final String direction;
  const WidgetDirection(this.direction);
}
