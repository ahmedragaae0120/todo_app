import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/home_screen.dart';
import 'package:todo_app/layout/intro/intro_screen.dart';
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
      const Duration(
        seconds: 3,
      ),
      () {
        cheekAutologin();
      },
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: SvgPicture.asset("assets/images/splach logo.svg")),
    );
  }

  cheekAutologin() async {
    authprovider provider = Provider.of<authprovider>(context, listen: false);
    if (provider.isfirebaseAuthUser()) {
      await provider.retriveDatabaseUserData();
      Navigator.pushReplacementNamed(context, homeSreen.route_name);
    } else {
      Navigator.pushReplacementNamed(context, IntroScreen.route_name);
    }
  }
}
