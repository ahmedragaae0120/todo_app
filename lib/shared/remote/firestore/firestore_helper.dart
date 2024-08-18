import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/settings_model.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/model/user_model.dart';

class firestoreHelper {
  static CollectionReference<userModel> getUsersCollecions() {
    var reference = FirebaseFirestore.instance.collection("User").withConverter(
      fromFirestore: (snapshot, options) {
        Map<String, dynamic>? data = snapshot.data();
        return userModel.fromFirestore(data ?? {});
      },
      toFirestore: (userModel, options) {
        return userModel.toFirestore();
      },
    );
    return reference;
  }

  static Future<void> AddUser(
      {required String email,
      required String fullname,
      required String userid}) async {
    var document = getUsersCollecions().doc(userid);
    await document.set(userModel(fullName: fullname, email: email, id: userid));
  }

  static Future<userModel?> getUser(String Userid) async {
    var document = getUsersCollecions().doc(Userid);
    var snapshot = await document.get();
    userModel? user = snapshot.data();
    return user;
  }

  static CollectionReference<task> getTaskCollecions(String userid) {
    var tasksCollection =
        getUsersCollecions().doc(userid).collection("tasks").withConverter(
              fromFirestore: (snapshot, options) =>
                  task.fromFirestore(snapshot.data() ?? {}),
              toFirestore: (task, options) => task.toFirestore(),
            );
    return tasksCollection;
  }

  static Future<void> AddNewTask(
      {required task task, required String userid}) async {
    var reference = getTaskCollecions(userid);
    var taskDocument = reference.doc();
    task.id = taskDocument.id;
    await taskDocument.set(task);
  }

  // static Future<List<task>> getAllTasks(String userid) async {
  //   var taskQuery = await getTaskCollecions(userid).get();
  //   List<task> tasksList =
  //       taskQuery.docs.map((snapshot) => snapshot.data()).toList();
  //   return tasksList;
  // }

  static Stream<List<task>> ListenToTasks(
      {required String userid, required int date}) async* {
    Stream<QuerySnapshot<task>> taskQueryStrem =
        getTaskCollecions(userid).where("date", isEqualTo: date).snapshots();
    Stream<List<task>> tasksStream = taskQueryStrem.map((querySnapshot) =>
        querySnapshot.docs.map((Document) => Document.data()).toList());
    yield* tasksStream;
  }

  static Stream<List<task>> ListenToAllTasks({required String userid}) async* {
    Stream<QuerySnapshot<task>> taskQueryStrem = getTaskCollecions(userid)
        .where("isDone", isEqualTo: false)
        .where("date",
            isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day)
                .millisecondsSinceEpoch)
        .snapshots();
    Stream<List<task>> tasksStream = taskQueryStrem.map((querySnapshot) =>
        querySnapshot.docs.map((Document) => Document.data()).toList());
    yield* tasksStream;
  }

  static Stream<List<task>> ListenToCompletedTasks(
      {required String userid}) async* {
    Stream<QuerySnapshot<task>> taskQueryStrem =
        getTaskCollecions(userid).where("isDone", isEqualTo: true).snapshots();
    Stream<List<task>> tasksStream = taskQueryStrem.map((querySnapshot) =>
        querySnapshot.docs.map((Document) => Document.data()).toList());
    yield* tasksStream;
  }

  static Stream<List<task>> ListenToHistoryTasks(
      {required String userid}) async* {
    Stream<QuerySnapshot<task>> taskQueryStrem = getTaskCollecions(userid)
        .where("date",
            isLessThan: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .millisecondsSinceEpoch)
        .snapshots();
    Stream<List<task>> tasksStream = taskQueryStrem.map((querySnapshot) =>
        querySnapshot.docs.map((Document) => Document.data()).toList());
    yield* tasksStream;
  }

  static Future<void> deleteTask(
      {required String userid, required String taskID}) async {
    await getTaskCollecions(userid).doc(taskID).delete();
  }

  static Future<void> editTask({
    required String userid,
    required String taskID,
    required String selectedEditTask,
    String? Title,
    String? descripTion,
  }) async {
    await getTaskCollecions(userid)
        .doc(taskID)
        .update({selectedEditTask: Title ?? descripTion});
  }

  static Future<void> getIsdone(
      {required String userid,
      required String taskID,
      required bool newValue}) async {
    await getTaskCollecions(userid).doc(taskID).update({"isDone": newValue});
  }

  static CollectionReference<settingsModel> getSettingsCollecions(
      String userid) {
    var SettingsCollection = getUsersCollecions()
        .doc(userid)
        .collection("Settings")
        .withConverter(
          fromFirestore: (snapshot, options) =>
              settingsModel.fromFirestore(snapshot.data() ?? {}),
          toFirestore: (settingsModel, options) => settingsModel.toFirestore(),
        );
    return SettingsCollection;
  }

  static Future<void> AddSettingsUser(
      {required settingsModel SettingsUser, required String userid}) async {
    var settingsDocument = getSettingsCollecions(userid).doc();
    settingsModel.settingsID = settingsDocument.id;
    await settingsDocument.set(SettingsUser);
  }

  static Future<void> editSettings(
      {required String userid,
      required String settingsId,
      required settingsModel settingsUser}) async {
    await getSettingsCollecions(userid)
        .doc(settingsId)
        .update(settingsUser.toFirestore());
  }

  static Future<int> getAllSettings(String userid) async {
    var settingsQuery = await getSettingsCollecions(userid).get();
    List<settingsModel> settingsList =
        settingsQuery.docs.map((snapshot) => snapshot.data()).toList();
    return settingsList.length;
  }
}
