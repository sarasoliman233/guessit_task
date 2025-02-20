
import 'dart:convert';
Users usersFromMap(String str) => Users.fromMap(json.decode(str));
String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? usrId;
  final String email;
  late final String userPassword;

  Users({
      this.usrId,
    required this.email,
    required this.userPassword,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    usrId: json["usrId"],
    email: json["email"],
    userPassword: json["userPassword"],
  );

  Map<String, dynamic> toMap() => {
    "usrId": usrId,
    "email": email,
    "userPassword": userPassword,
  };
}
