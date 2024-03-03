
class userModel {
  String? fullName;
  String? email;
  String? id;
  userModel({required this.fullName, required this.email, required this.id});
  userModel.fromFirestore(Map<String,dynamic> data) {
    id = data["id"];
    fullName = data["fullname"];
    email = data["email"];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "email": email,
      "fullname": fullName,
    };
  }
}
