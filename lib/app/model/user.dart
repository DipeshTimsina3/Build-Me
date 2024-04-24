// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final String? userId;
  final String? email;
  final String? phone;
  final String? fullName;
  final String? role;

  User({
    this.userId,
    this.email,
    this.phone,
    this.fullName,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        email: json["email"],
        fullName: json["full_name"],
        phone: json["Phone"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "full_name": fullName,
        "Phone": phone,
        "role": role,
      };
}
