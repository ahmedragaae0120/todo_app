import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/login/login_screen.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';

class homeSreen extends StatelessWidget {
  static const String route_name = "homeSreen";
  const homeSreen({super.key});

  @override
  Widget build(BuildContext context) {
    authprovider provider = Provider.of<authprovider>(context);
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
    );
  }
}
