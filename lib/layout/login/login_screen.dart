import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/home_screen.dart';
import 'package:todo_app/layout/register/register_screen.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/shared/FirebaseAuthErorrCodes.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/dialog_utlis.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';
import 'package:todo_app/shared/reusable_commponets/custom_text_filed.dart';

class loginScreen extends StatefulWidget {
  static const String route_name = "loginScreen";
  loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/SIGNIN1.jpg"),
          fit: BoxFit.fill,
        )),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome back!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  customTextfiled(
                    lable: 'Email',
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field can't be empty";
                      }
                      if (!RegExp(constants.emailregex).hasMatch(value)) {
                        return "Enter valid Email";
                      }
                      return null;
                    },
                  ),
                  customTextfiled(
                    lable: 'password',
                    keyboard: TextInputType.visiblePassword,
                    controller: passwordController,
                    ObscureText: isObscure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field can't be empty";
                      }
                      if (value.length < 8) {
                        return "password should is 8 char";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text("Login",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                        )),
                  ),
                  TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, registerScreen.route_name),
                      child: Text("or Create My Account"))
                ],
              ),
            ),
          ),
        ));
  }

  void login() async {
    authprovider provider = Provider.of<authprovider>(context,listen: false);
    if (formKey.currentState?.validate() ?? false) {
      dialogUtils.show_loaing_dialog(context);
      try {
        UserCredential credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        userModel? user = await firestoreHelper.getUser(credential.user!.uid);
        provider.setUsers(
            newfirebaseAuthUser: credential.user,
            newdatabaseUser: user);
        dialogUtils.hide_loaing_dialog(context);
        Navigator.pushNamedAndRemoveUntil(
            context, homeSreen.route_name, (route) => false);
        print("user id: ${credential.user?.uid}");
      } on FirebaseAuthException catch (e) {
        dialogUtils.hide_loaing_dialog(context);
        if (e.code == FirebaseAuthErorrCodes.usernotfound) {
          print('No user found for that email.');
          dialogUtils.showMessage(
              context: context,
              message: "No user found for that email.",
              positiveText: "ok",
              positiveButton: () => dialogUtils.hide_loaing_dialog(context));
        } else if (e.code == FirebaseAuthErorrCodes.wrongPassword) {
          print('Wrong password.');
          dialogUtils.showMessage(
              context: context,
              message: "Wrong password.",
              positiveText: "ok",
              positiveButton: () => dialogUtils.hide_loaing_dialog(context));
        }
      }
    }
  }
}
