import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String username;
  String email;
  String id;

  User() {
    this.username = "clown";
  }
}
