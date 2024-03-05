import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String email, password, userName, userImage, uId;
  final List followers;
  final List following;
  UserModel(
      {required this.email,
      required this.password,
      required this.userName,
      required this.userImage,
      required this.uId,
      required this.followers,
      required this.following});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
      userName: json["user_name"],
      userImage: json["user_image"],
      uId: json["user_id"],
      followers: json["followers"] ?? [],
      following: json["following"] ?? [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "user_name": userName,
      "user_image": userImage,
      "user_id": uId,
      "followers": followers,
      "following": following,
    };
  }

  static convertSnapTomodel(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot["email"],
      password: snapshot["password"],
      userName: snapshot["user_name"],
      userImage: snapshot["user_image"],
      uId: snapshot["user_id"],
      followers: snapshot["followers"] ?? [],
      following: snapshot["following"] ?? [],
    );
  }
}
