import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<List<task>> getAllTasks(String userid) async {
    var taskQuery = await getTaskCollecions(userid).get();
    List<task> tasksList =
        taskQuery.docs.map((snapshot) => snapshot.data()).toList();
    return tasksList;
  }

  static Stream<List<task>> ListenToTasks(
      {required String userid, required int date}) async* {
    Stream<QuerySnapshot<task>> taskQueryStrem =
        getTaskCollecions(userid).where("date", isEqualTo: date).snapshots();
    Stream<List<task>> tasksStream = taskQueryStrem.map((querySnapshot) =>
        querySnapshot.docs.map((Document) => Document.data()).toList());
    yield* tasksStream;
  }

  static Future<void> deleteTask(
      {required String userid, required String taskID}) async {
    await getTaskCollecions(userid).doc(taskID).delete();
  }

  static Future<void> editTask(
      {required String userid,
      required String taskID,
      required task task}) async {
    await getTaskCollecions(userid).doc(taskID).update(task.toFirestore());
  }

  static Future<void> getIsdone(
      {required String userid,
      required String taskID,
      required bool newValue}) async {
    await getTaskCollecions(userid).doc(taskID).update({"isDone": newValue});
  }
}
