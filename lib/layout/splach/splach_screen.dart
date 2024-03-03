import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/home_screen.dart';
import 'package:todo_app/layout/login/login_screen.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';

class splachScreen extends StatefulWidget {
  static const String route_name = "splachScreen";
  const splachScreen({super.key});

  @override
  State<splachScreen> createState() => _splachScreenState();
}

class _splachScreenState extends State<splachScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(
        seconds: 3,
      ),
      () {
        cheekAutologin();
      },
    );
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash.png"), fit: BoxFit.fill)),

      child: Scaffold(backgroundColor: Colors.transparent,),
    );
  }

  cheekAutologin() async {
    authprovider provider = Provider.of<authprovider>(context, listen: false);
    if (provider.isfirebaseAuthUser()) {
      await provider.retriveDatabaseUserData();
      Navigator.pushReplacementNamed(context, homeSreen.route_name);
    } else {
      Navigator.pushReplacementNamed(context, loginScreen.route_name);
    }
  }
}
