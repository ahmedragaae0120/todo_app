import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class authprovider extends ChangeNotifier {
  User? firebaseAuthUser;
  userModel? databaseUser;
  void setUsers(
      {required User? newfirebaseAuthUser,
      required userModel? newdatabaseUser}) {
    firebaseAuthUser = newfirebaseAuthUser;
    databaseUser = newdatabaseUser;
  }

  bool isfirebaseAuthUser() {
    if (FirebaseAuth.instance.currentUser == null) return false;
    firebaseAuthUser = FirebaseAuth.instance.currentUser;
    return true;
  }

  Future<void> retriveDatabaseUserData() async {
    try {
      databaseUser = await firestoreHelper.getUser(firebaseAuthUser!.uid);
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout()async {
    firebaseAuthUser = null;
    databaseUser = null;
    return await FirebaseAuth.instance.signOut();
  }
}
