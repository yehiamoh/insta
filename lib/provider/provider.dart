import 'package:flutter/material.dart';
import 'package:insta_app/firestore/firestore.dart';
import 'package:insta_app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? userData;
  UserModel? get getUser {
    return userData;
  }

  void fetchUser() async {
    UserModel user = await FireStoreMethod().userDetailes();
    userData = user;
    notifyListeners();
  }
}
