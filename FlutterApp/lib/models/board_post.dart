import 'user.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class BoardPost with ChangeNotifier {
  String id;
  String _title;
  double _fee;
  String _description;
  String _language; //TODO build language Enum
  int _memberLimit;
  String _location;
  List<User> _users;
  String _ownerId;
  bool _favorite;

  bool get favorite => _favorite;

  set favorite(bool value) {
    _favorite = value;
  }

  BoardPost(String ownerId) {
    this.id = DateTime.now().toString();
    this._ownerId = ownerId;
    this._favorite = false;
  }

  BoardPost.getExample() {
    this.id = "idexample";
    this._title = "Example Title";
    this._fee = 500;
    this._description =
        "This is a example description. This is a example description. This is a example description.";
    this._language = "English";
    this._location = "Room 3000";
    this._memberLimit = 5;
    this.ownerId = "owner1id";
    this._users = [];
    this._favorite = false;
  }

  String toString() {
    return "Title: $_title, Location: $location, Fee: $fee";
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  double get fee => _fee;

  set fee(double value) {
    _fee = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get ownerId => _ownerId;

  set ownerId(String value) {
    _ownerId = value;
  }

  String get language => _language;

  set language(String value) {
    _language = value;
  }

  int get memberLimit => _memberLimit;

  set memberLimit(int value) {
    _memberLimit = value;
  }

  List<User> get users => _users;

  set users(List<User> value) {
    _users = value;
  }
}
