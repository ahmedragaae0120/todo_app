import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/layout/home/home_screen.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/layout/home/widgets/editTasksheet.dart';
import 'package:todo_app/layout/intro/intro_screen.dart';
import 'package:todo_app/layout/login/login_screen.dart';
import 'package:todo_app/layout/register/register_screen.dart';
import 'package:todo_app/layout/splach/splach_screen.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authprovider()),
        ChangeNotifierProvider(create: (context) => homeProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations', // مسار ملفات الترجمة
        fallbackLocale: const Locale('en'),
        child: const todoApp(),
      ),
    ),
  );
}

class todoApp extends StatelessWidget {
  const todoApp({super.key});
  @override
  Widget build(BuildContext context) {
    homeProvider providerHome = Provider.of<homeProvider>(context);
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      theme: appTheme.darkTheme,
      darkTheme: appTheme.darkTheme,
      // themeMode: providerHome.dropdownMode == "dark"
      //     ? ThemeMode.dark
      //     : ThemeMode.light,
      themeMode: providerHome.dropdownMode == "Light"
          ? ThemeMode.light
          : ThemeMode.dark,
      routes: {
        loginScreen.route_name: (context) => const loginScreen(),
        registerScreen.route_name: (context) => const registerScreen(),
        homeSreen.route_name: (context) => const homeSreen(),
        editTasksheet.route_name: (context) => editTasksheet(),
        splachScreen.route_name: (context) => const splachScreen(),
        IntroScreen.route_name: (context) => const IntroScreen(),
      },
      initialRoute: splachScreen.route_name,
    );
  }
}
