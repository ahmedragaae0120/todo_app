import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/login/login_screen.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';

class homeSreen extends StatelessWidget {
  static const String route_name = "homeSreen";
  const homeSreen({super.key});

  @override
  Widget build(BuildContext context) {
    authprovider provider = Provider.of<authprovider>(context);
    homeProvider providerHome = Provider.of<homeProvider>(context);
    return Scaffold(
        backgroundColor: Color(0xffdfecdb),
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
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
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
        ));
  }
}
