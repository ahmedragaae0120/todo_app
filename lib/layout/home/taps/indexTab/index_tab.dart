import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/taps/indexTab/widgets/all_tasks_stream.dart';
import 'package:todo_app/layout/home/taps/indexTab/widgets/all_completed_tasks_stream.dart';
import 'package:todo_app/layout/home/taps/indexTab/widgets/selected_Sort_widget.dart';

class IndexTab extends StatefulWidget {
  const IndexTab({super.key});

  @override
  State<IndexTab> createState() => _IndexTabState();
}

class _IndexTabState extends State<IndexTab> {
  String? selectedSort = "All";

  @override
  Widget build(BuildContext context) {
    homeProvider providerHome = Provider.of<homeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          providerHome.listOfAllTasksIsEmpty
              ? const SliverToBoxAdapter(child: SizedBox())
              : SelectedSortWidget(
                  selectedSort: selectedSort,
                ),
          const AllTasksStream(),
          providerHome.listOfCompletedTasksIsEmpty
              ? const SliverToBoxAdapter(child: SizedBox())
              : SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: SizedBox(
                        width: 170,
                        child: ListTile(
                          title: Text(
                            "Completed",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          const AllCompletedTasksStream(),
        ],
      ),
    );
  }
}
