import 'package:flutter/material.dart';

class SelectedSortWidget extends StatefulWidget {
  String? selectedSort;
  SelectedSortWidget({super.key, this.selectedSort});

  @override
  State<SelectedSortWidget> createState() => _SelectedSortWidgetState();
}

class _SelectedSortWidgetState extends State<SelectedSortWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary),
          child: DropdownMenu(
            dropdownMenuEntries: [
              DropdownMenuEntry(
                  value: "All",
                  label: "All",
                  style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onSecondary),
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onSecondary))),
              DropdownMenuEntry(
                  value: "Today",
                  label: "Today",
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onSecondary))),
              DropdownMenuEntry(
                  value: "this week",
                  label: "this week",
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onSecondary))),
              DropdownMenuEntry(
                  value: "this month",
                  label: "this month",
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onSecondary))),
            ],
            initialSelection: widget.selectedSort,
            onSelected: (value) {
              setState(() {
                widget.selectedSort = value;
              });
            },
            menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary)),
            textStyle:
                TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            trailingIcon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
