import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class User with ChangeNotifier {
  String username;
  String email;
  String id;

  void setUsername(String username) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(id)
        .set({"username": username}).then((_) {
      this.username = username;
    }).catchError((error) => print(error));
  }

  Future resetUser() {
    return FirebaseAuth.instance.signOut().then((result) {
      this.username = null;
      this.email = null;
      this.id = null;
    });
  }
}
