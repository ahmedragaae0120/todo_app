import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/home_screen.dart';
import 'package:todo_app/layout/login/login_screen.dart';
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
  const registerScreen({super.key});

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 100.h),
                const Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 25.h),
                Text(
                  "Full Name",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                  textAlign: TextAlign.start,
                ),
                customTextfiled(
                  hintText: 'Enter your Full name',
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
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 25.h),
                Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                  textAlign: TextAlign.start,
                ),
                customTextfiled(
                  hintText: "Enter your Email",
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
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 25.h),
                Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                  textAlign: TextAlign.start,
                ),
                customTextfiled(
                  hintText: "Enter your Password",
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
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 25.h),
                Text(
                  "Confirm Password",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                  textAlign: TextAlign.start,
                ),
                customTextfiled(
                  hintText: "Enter your Confirm Password",
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
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: () {
                    createNewUser();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(300.w, 48.h),
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  child: Text("Register",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      )),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, loginScreen.route_name),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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
