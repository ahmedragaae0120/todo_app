class task {
  String? id;
  String? title;
  String? descripion;
  int? date;
  bool? isDone;
  task(
      {required this.title,
      required this.descripion,
      required this.date,
      this.id,
      this.isDone = false});
  task.fromFirestore(Map<String, dynamic> data) {
    id = data["id"];
    title = data["title"];
    descripion = data["descripion"];
    date = data["date"];
    isDone = data["isDone"];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "descripion": descripion,
      "date": date,
      "isDone": isDone,
    };
  }
}
