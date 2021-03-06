
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BoardPost with ChangeNotifier {
  String id;
  String _title;
  String _fee;
  String _description;
  String _language; //TODO build language Enum
  int _memberLimit;
  String _location;
  List _users;
  //String _ownerId;
  bool _favorite;
  String _owner; //
  DateTime _date;
  bool _participating;
  String _imageUrl;

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
      "imageUrl": _imageUrl,
    };
  }

  BoardPost.fromMap(Map snapshot, userId) {
    id = snapshot['id'] ?? '';
    _title = snapshot['title'] ?? '';
    _location = snapshot['location'] ?? '';
    _fee = snapshot['fee'] ?? '';

    _description = snapshot['description'] ?? '';
    _memberLimit = snapshot['memberLimit'] ?? 5;
    _users = snapshot["participants"] ?? []; //TODO load array
    _imageUrl = snapshot['imageUrl'] ?? '';
    _language = snapshot['language'] ?? '';
    _favorite = false;
    _owner = snapshot['owner'] ?? '';
    _date = DateTime.fromMillisecondsSinceEpoch(
        snapshot["date"]);
    _participating =
        false;
  }

  void toggleFavorite(userId) async {
    if (!_favorite) {
    Firestore.instance.collection("User_Data").document(userId).updateData({"favorites":FieldValue.arrayUnion([this.id])});
    } else {
      Firestore.instance.collection("User_Data").document(userId).updateData(
          {"favorites": FieldValue.arrayRemove([this.id])});
    }

    /*
    if (!_favorite) {
      FirebaseDatabase.instance
          .reference()
          .child("User_Data")
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
          .child("User_Data")
          .child(userId)
          .child("favorites")
          .child(this.id)
          .remove();
      this._favorite = false;
      notifyListeners();
    }
    */
    notifyListeners();
  }

  void toggleParticipating(userId) {
    if (!_participating) {
      Firestore.instance.collection("User_Data").document(userId).updateData({"participations":FieldValue.arrayUnion([this.id])});
      Firestore.instance.collection("Posts").document(id).updateData({"participants":FieldValue.arrayUnion([userId])});
    /*  FirebaseDatabase.instance
          .reference()
          .child("User_Data")
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
*/
      _participating = true;
      notifyListeners();
    } else {
      Firestore.instance.collection("User_Data").document(userId).updateData({"participations":FieldValue.arrayRemove([this.id])});
      Firestore.instance.collection("Posts").document(id).updateData({"participants":FieldValue.arrayRemove([userId])});
    /*  FirebaseDatabase.instance
          .reference()
          .child("User_Data")
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
          */

      _participating = false;
      notifyListeners();
    }
    notifyListeners();
  }

  BoardPost() {
    this._favorite = false;
    //this._date = DateTime.now();
    this._participating = true;
    this.memberLimit = 5;
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

  String get fee => _fee;

  set fee(String value) {
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

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  bool get participating => _participating;

  set participating(bool value) {
    _participating = value;
  }

  List get users => _users;

  set users(List value) {
    _users = value;
  }
}
