import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/layout/home/home_screen.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/login/login_screen.dart';
import 'package:todo_app/layout/register/register_screen.dart';
import 'package:todo_app/layout/splach/splach_screen.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => authprovider(),
      child: const todoApp(),
    ),
  );
}

class todoApp extends StatelessWidget {
  const todoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: ThemeMode.light,
      routes: {
        loginScreen.route_name: (context) => loginScreen(),
        registerScreen.route_name: (context) => registerScreen(),
        homeSreen.route_name: (context) => ChangeNotifierProvider(
              create: (context) => homeProvider(),
              child: homeSreen(),
            ),
        splachScreen.route_name: (context) => splachScreen(),
      },
      initialRoute: splachScreen.route_name,
    );
  }
}
