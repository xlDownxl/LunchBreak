import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class User with ChangeNotifier {
  String username;
  String email;
  String id;
  String image;
  FirebaseUser fbUser;

  void setUsername(String username) async {
    await FirebaseDatabase.instance
        .reference()
        .child("User_Data")
        .child(id)
        .set({"username": username}).then((_) async {
      await FirebaseDatabase.instance
          .reference()
          .child("Users")
          .update({id:username}).then((_){
        this.username = username;
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
    image = await FirebaseStorage.instance.ref().child("User_Data").child(id).child("profile_pic").getDownloadURL();
    
  return FirebaseDatabase.instance
      .reference()
      .child("User_Data")
      .child(fbUser.uid)
      .once()
      .then((snapshot) {
    id = fbUser.uid;
    email = fbUser.email;
  });
  }
}
