import 'user.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

class BoardPost with ChangeNotifier {
  String id;
  String _title;
  double _fee;
  String _description;
  String _language; //TODO build language Enum
  int _memberLimit;
  String _location;
  List<User> _users;
  //String _ownerId;
  bool _favorite;
  String _owner; //
  DateTime _date;
  bool _participating;

  toJson() {
    return {
      "id": id,
      "title": _title,
      "fee": _fee,
      "description": _description,
      "language": _language,
      "memberLimit": memberLimit,
      "location": _location,
      "users": {},
      "date": dateInDatabaseFormat,
      "owner": _owner,
    };
  }

  BoardPost.fromMap(Map snapshot, userId) {
    id = snapshot['id'] ?? '';
    _title = snapshot['title'] ?? '';
    _location = snapshot['location'] ?? '';
    _fee = snapshot['fee'].toDouble() ?? '';
    _description = snapshot['description'] ?? '';
    _memberLimit = snapshot['memberLimit'] ?? '';
    _users = [];
    _language = snapshot['language'] ?? '';
    _favorite = false;
    _owner = snapshot['owner'] ?? '';
    _date = DateTime.now(); //TODO implement time
    _participating =
        false; //TODO logic that takes the participated event key list from firebase and puts the right
  } //participating attributes to true
  //also the logic for changing it to true and in the database by click
  //TODO cancel button und back arrows überarbeiten

  void toggleFavorite(userId) async {
    if (!_favorite) {
      FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(userId)
          .child("favorites")
          .update({
        this.id: this.title,
      });
      _favorite = true;
      notifyListeners();
    } else {
      FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(userId)
          .child("favorites")
          .child(this.id)
          .remove();
      this._favorite = false;
      notifyListeners();
    }
  }

  void toggleParticipating(userId) {
    if (!_participating) {
      FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(userId)
          .child("participations")
          .update({
        this.id: this.dateInDatabaseFormat,
      });
      FirebaseDatabase.instance
          .reference()
          .child("Posts")
          .child(id)
          .child("participants")
          .update({
        userId: 1,
      });

      _participating = true;
    } else {
      FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(userId)
          .child("participations")
          .child(this.id)
          .remove();
      FirebaseDatabase.instance
          .reference()
          .child("Posts")
          .child(id)
          .child("participants")
          .child(userId)
          .remove();

      _participating = false;
    }
  }

  BoardPost() {
    this._favorite = false;
    this._date = DateTime.now();
    this._participating = true;
    this.memberLimit = 5;
  }

  BoardPost.getExample() {
    this._participating = true;
    //this.id = "idexample";
    this._title = "Example Title";
    this._fee = 500;
    this._description =
        "This is a example description. This is a example description. This is a example description.";
    this._language = "English";
    this._location = "Room 3000";
    this._memberLimit = 5;
    this._owner = "me";
    this._users = [];
    this._favorite = false;
    this._participating = false;
    this.date = DateTime.now();
  }

  int get dateInDatabaseFormat {
    return _date.millisecondsSinceEpoch;
  }

  bool get favorite => _favorite;

  set favorite(bool value) {
    _favorite = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  } //TODO handle owner at writing post

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

  String get owner => _owner;

  set owner(String value) {
    _owner = value;
  }

  String get language => _language;

  set language(String value) {
    _language = value;
  }

  int get memberLimit => _memberLimit;

  set memberLimit(int value) {
    _memberLimit = value;
  }

  bool get participating => _participating;

  set participating(bool value) {
    _participating = value;
  }

  List<User> get users => _users;

  set users(List<User> value) {
    _users = value;
  }
}
