import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/taps/calendarTap/calendar_tab.dart';
import 'package:todo_app/layout/home/taps/historyTab/history_tab.dart';
import 'package:todo_app/layout/home/taps/indexTab/index_tab.dart';
import 'package:todo_app/layout/home/taps/settingTap/settings_tab.dart';
import 'package:todo_app/layout/home/widgets/addTaskSheet.dart';
import 'package:todo_app/model/settings_model.dart';

import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class homeSreen extends StatefulWidget {
  static const String route_name = "homeSreen";
  const homeSreen({super.key});

  @override
  State<homeSreen> createState() => _homeSreenState();
}

class _homeSreenState extends State<homeSreen> {
  List<Widget> tabs = [
    const IndexTab(),
    const listTab(),
    const HistoryTab(),
    const settingsTab(),
  ];
  List<String> tabsName = [
    "Index",
    "Calendar",
    "History",
    "Profile",
  ];

  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  // TextEditingController titleController = TextEditingController();

  // TextEditingController descriptionController = TextEditingController();

  // GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    HomeProvider providerHome = Provider.of<HomeProvider>(context);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    cheekIsDocSettings();

    return Scaffold(
      appBar: AppBar(
        title: Text(providerHome.tabName),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
        actions: const [],
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: keyboardIsOpened
          ? null
          : FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                showAddTaskBottomSheet();
                // if ((formkey.currentState?.validate() ?? false) &&
                //     providerHome.SelectedDate != null) {
                //   firestoreHelper.AddNewTask(
                //       task: task(
                //         title: titleController.text,
                //         descripion: descriptionController.text,
                //         date: providerHome.SelectedDate!.millisecondsSinceEpoch,
                //       ),
                //       userid: provider.firebaseAuthUser!.uid);
                //   dialogUtils.showMessage(
                //     context: context,
                //     message: "task added Successfuly",
                //     positiveText: "ok",
                //     positiveButton: () {
                //       Navigator.pop(context);
                //       Navigator.pop(context);
                //     },
                //   );
                // }
                // providerHome.isTextfiledIsEmpty ? print("pop") : print("add");
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              )),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        notchMargin: 7,
        child: BottomNavigationBar(
          fixedColor: Colors.white,
          onTap: (value) {
            providerHome.changeCurrentIndex(value);
            providerHome.changeTabName(tabsName[value].tr());
          },
          currentIndex: providerHome.currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.other_houses_rounded,
              ),
              label: "Index".tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_month_outlined),
              label: "Calendar".tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.access_time),
              label: "Focuse".tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_outlined),
              label: "Profile".tr(),
            ),
          ],
        ),
      ),
      body: Scaffold(
        key: scafoldKey,
        body: tabs[providerHome.currentIndex],
      ),
    );
  }

  void cheekIsDocSettings() async {
    authprovider provider = Provider.of<authprovider>(context, listen: false);
    var cheekIsDocSettings =
        await firestoreHelper.getAllSettings(provider.firebaseAuthUser!.uid);
    if (cheekIsDocSettings < 1) {
      firestoreHelper.AddSettingsUser(
          userid: provider.firebaseAuthUser!.uid,
          SettingsUser: settingsModel());
    }
  }

  void showAddTaskBottomSheet() {
    scafoldKey.currentState?.showBottomSheet(
      (context) => const addTaskSheet(),
    );
  }
}
