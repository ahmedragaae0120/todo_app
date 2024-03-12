import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/taps/list_tab.dart';
import 'package:todo_app/layout/home/taps/settings_tab.dart';
import 'package:todo_app/layout/home/widgets/addTaskSheet.dart';
import 'package:todo_app/layout/login/login_screen.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/shared/dialog_utlis.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class homeSreen extends StatefulWidget {
  static const String route_name = "homeSreen";
  const homeSreen({super.key});

  @override
  State<homeSreen> createState() => _homeSreenState();
}

class _homeSreenState extends State<homeSreen> {
  List<Widget> tabs = [listTab(), settingsTab()];
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    authprovider provider = Provider.of<authprovider>(context);
    homeProvider providerHome = Provider.of<homeProvider>(context);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await provider.logout();
              Navigator.pushReplacementNamed(context, loginScreen.route_name);
            },
            icon: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.onPrimary)),
        title: Text("To Do List"),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: keyboardIsOpened
          ? null
          : FloatingActionButton(
              onPressed: () {
                showAddTaskBottomSheet();
                if ((formkey.currentState?.validate() ?? false) &&
                    providerHome.SelectedDate != null) {
                  firestoreHelper.AddNewTask(
                      task: task(
                        title: titleController.text,
                        descripion: descriptionController.text,
                        date: providerHome.SelectedDate!.millisecondsSinceEpoch,
                      ),
                      userid: provider.firebaseAuthUser!.uid);
                  dialogUtils.showMessage(
                    context: context,
                    message: "task added Successfuly",
                    positiveText: "ok",
                    positiveButton: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );
                }
                // providerHome.isTextfiledIsEmpty ? print("pop") : print("add");
              },
              shape: StadiumBorder(
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 4)),
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: BottomNavigationBar(
          onTap: (value) {
            providerHome.changeCurrentIndex(value);
          },
          currentIndex: providerHome.currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: "",
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

  void showAddTaskBottomSheet() {
    scafoldKey.currentState?.showBottomSheet(
      (context) => addTaskSheet(
        descriptionController: descriptionController,
        titleController: titleController,
        formkey: formkey,
      ),
    );
  }
}
