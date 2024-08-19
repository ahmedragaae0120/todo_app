import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layout/login/login_screen.dart';
import 'package:todo_app/layout/register/register_screen.dart';

class IntroScreen extends StatelessWidget {
  static const String route_name = "IntroScreen";
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Image> slides = [
      Image.asset("assets/images/slide 1.png"),
      Image.asset("assets/images/slide 2.png"),
      Image.asset('assets/images/slide 3.png'),
    ];
    return Scaffold(
      body: AnimatedIntroduction(
        slides: const [
          SingleIntroScreen(
              title: "Manage your tasks",
              description:
                  "You can easily manage all of your daily tasks in DoMe for free",
              imageAsset: "assets/images/slide 1.png"),
          SingleIntroScreen(
              title: "Create daily routine",
              description:
                  "In Uptodo  you can create your personalized routine to stay productive",
              imageAsset: "assets/images/slide 2.png"),
          SingleIntroScreen(
              title: "Orgonaize your tasks",
              description:
                  "You can organize your daily tasks by adding your tasks into separate categories",
              imageAsset: "assets/images/slide 3.png"),
        ],
        onDone: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Welcome(),
              ));
        },
        containerBg: Colors.black,
        activeDotColor: Colors.white,
        inactiveDotColor: Theme.of(context).colorScheme.onPrimary,
        footerBgColor: Colors.black,
        indicatorType: IndicatorType.line,
        isFullScreen: false,
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 70),
          const Text(
            "Welcome to UpTodo",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 26),
          Center(
            child: Text(
              '''Please login to your account or create 
              new account to continue''',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              maxLines: 2,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, loginScreen.route_name);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 48),
                backgroundColor: Theme.of(context).colorScheme.secondary),
            child: Text("Login",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                )),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, registerScreen.route_name);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 48),
                side:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
                backgroundColor: Colors.transparent),
            child: Text("Create account",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                )),
          ),
        ],
      ),
    );
  }
}
