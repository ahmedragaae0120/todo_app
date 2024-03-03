import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/home_screen.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/shared/FirebaseAuthErorrCodes.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/dialog_utlis.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';
import 'package:todo_app/shared/reusable_commponets/custom_text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';

class registerScreen extends StatefulWidget {
  static const String route_name = "registerScreen";
  registerScreen({super.key});

  @override
  State<registerScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<registerScreen> {
  bool isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
              "register",
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
                    lable: 'full name',
                    keyboard: TextInputType.emailAddress,
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field can't be empty";
                      }
                      if (value.length > 30) {
                        return "The name exceeded the allowed limit";
                      }
                      return null;
                    },
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
                  customTextfiled(
                    lable: 'Confirm password',
                    keyboard: TextInputType.visiblePassword,
                    controller: confirmPasswordController,
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
                      if (value != passwordController.text) {
                        return "confirm password should be equal password  ";
                      } // to do
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      createNewUser();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text("Register",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void createNewUser() async {
    authprovider provider = Provider.of<authprovider>(context, listen: false);
    if (formKey.currentState?.validate() ?? false) {
      dialogUtils.show_loaing_dialog(context);
      try {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await firestoreHelper.AddUser(
            email: emailController.text,
            fullname: fullNameController.text,
            userid: credential.user!.uid);
        dialogUtils.hide_loaing_dialog(context);
        dialogUtils.showMessage(
          context: context,
          message: "Register successed id: ${credential.user?.uid}",
          positiveText: "ok",
          positiveButton: () {
            provider.setUsers(
                newfirebaseAuthUser: credential.user,
                newdatabaseUser: userModel(
                    fullName: fullNameController.text,
                    email: emailController.text,
                    id: credential.user!.uid));
            dialogUtils.hide_loaing_dialog(context);
            Navigator.pushNamedAndRemoveUntil(
                context, homeSreen.route_name, (route) => false);
          },
        );
      } on FirebaseAuthException catch (e) {
        dialogUtils.hide_loaing_dialog(context);
        if (e.code == FirebaseAuthErorrCodes.weak_password) {
          print('weak password');
          dialogUtils.showMessage(
            context: context,
            message: 'weak password',
            positiveText: "ok",
            positiveButton: () => dialogUtils.hide_loaing_dialog(context),
          );
        } else if (e.code == FirebaseAuthErorrCodes.email_already_in_use) {
          print('The account already exists for that email.');
          dialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            positiveText: "ok",
            positiveButton: () => dialogUtils.hide_loaing_dialog(context),
          );
        }
      } catch (e) {
        dialogUtils.hide_loaing_dialog(context);
        print(e);
        dialogUtils.showMessage(
          context: context,
          message: e.toString(),
          positiveText: "ok",
          positiveButton: () => dialogUtils.hide_loaing_dialog(context),
        );
      }
    }
  }
}
