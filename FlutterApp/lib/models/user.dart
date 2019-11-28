import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User with ChangeNotifier {
  String username;
  String email;
  String id;

  User() {}

  void setUsername(String username) {
    
    FirebaseAuth.instance.signOut().then((_)=>this.username = username;);
    //TODO FIREBASE
  }

  Future resetUser() {
    return FirebaseAuth.instance.signOut().then((result) {
      this.username = null;
      this.email = null;
      this.id = null;
    });
  }
}
