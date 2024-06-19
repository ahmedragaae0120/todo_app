class settingsModel {
  String? theme;
  String? language;
  String? settingsid;
  static String? settingsID;
  settingsModel({this.language = "en", this.theme = "Light", this.settingsid});
  settingsModel.fromFirestore(Map<String, dynamic> data) {
    theme = data["theme"];
    language = data["language"];
    settingsID = data["settingsID"];
  }

  Map<String, dynamic> toFirestore() {
    return {"theme": theme, "language": language, "settingsID": settingsID};
  }
}
