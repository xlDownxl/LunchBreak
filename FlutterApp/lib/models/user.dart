import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User with ChangeNotifier {
  String username;
  String email;
  String id;
  String image;
  FirebaseUser fbUser;

  void setUsername(String username) async {
    await Firestore.instance.collection("User_Data").document(id).updateData({"username": username}).then((_) async {
      await Firestore.instance.collection("Users").document("Usernames").setData({id:username}).then((_){
        this.username = username;
        notifyListeners();
      });
    }).catchError((error) => print(error));
  }

  Future resetUser() {
    return FirebaseAuth.instance.signOut().then((result) {
      this.username = null;
      this.email = null;
      this.id = null;
    });
  }

  Future getUserFromDB()async{
    fbUser = await FirebaseAuth.instance.currentUser();
    id = fbUser.uid;

    image = await FirebaseStorage.instance.ref().child("User_Data").child(id).child("profile_pic").getDownloadURL();

    return Firestore.instance.collection("User_Data").document(fbUser.uid).get().then((user){
      email = user.data["email"] ??"";
      username = user.data["username"] ??"";
      notifyListeners();
    });
  }

  Future loginUser(data) async{
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: data.name, password: data.password)
        .then((_) async {
      getUserFromDB();
    }).catchError((error) => error.code);
  }
}
