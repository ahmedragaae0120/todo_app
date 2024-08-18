class task {
  String? id;
  String? title;
  String? descripion;
  int? date;
  bool? isDone;
  int? priority;
  String? time;
  task({
     this.title,
     this.descripion,
     this.date,
    this.id,
    this.isDone = false,
    this.priority = 10,
     this.time,
  });
  task.fromFirestore(Map<String, dynamic> data) {
    id = data["id"];
    title = data["title"];
    descripion = data["descripion"];
    date = data["date"];
    isDone = data["isDone"];
    priority = data["priority"];
    time = data["time"];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "descripion": descripion,
      "date": date,
      "isDone": isDone,
      "priority": priority,
      "time": time,
    };
  }
}
