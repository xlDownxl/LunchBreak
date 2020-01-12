import 'board_post.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BoardPosts with ChangeNotifier {
  List<BoardPost> _items = [];

  List<BoardPost> items() {
    return _items;
  }

  void addPost(post) {
    _items.add(post);
  }

  List<BoardPost> favorites() {
    return _items.where((post) {
      return post.favorite == true;
    }).toList();
  }

  List<BoardPost> getDate(DateTime date) {
    return _items.where((post) {
      if (post.date.year == date.year &&
          post.date.month == date.month &&
          post.date.day == date.day) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<BoardPost> participating(userId) {
    return _items.where((post) {
      return post.participating || post.owner == userId;
    }).toList();
  }

  Future<void> connectToFirebase(userId) async {
    _items = [];
    var _participations = [];
    var _ownedPosts = [];
    var _favorites = [];

    Firestore.instance.collection("User_Data").document(userId).get().then((userData){
      var partPosts=userData.data["participations"];
      if (partPosts != null) {
        partPosts.forEach((key, value) {
          _participations.add(key);
        });
      }
      var _oPosts=userData.data["ownedPosts"];
      if (_oPosts != null) {
        _oPosts.forEach((key, value) {
          _ownedPosts.add(key);
        });
      }
      var _favs=userData.data["favorites"];
      if (_favs.value != null) {
        _favs.value.forEach((key, value) {
          _favorites.add(key);
        });
      }

    });

   /* FirebaseDatabase.instance //TODO catch errors
        .reference()
        .child("User_Data")
        .child(userId)
        .child("participations")
        .once()
        .then((posts) {
      if (posts.value != null) {
        posts.value.forEach((key, value) {
          _participations.add(key);
        });
      }
    });

    FirebaseDatabase.instance
        .reference()
        .child("User_Data")
        .child(userId)
        .child("ownedPosts")
        .once()
        .then((snapshot) {
      if (snapshot.value != null) {
        snapshot.value.forEach((key, value) {
          _ownedPosts.add(key);
        });
      }
    });

    FirebaseDatabase.instance
        .reference()
        .child("User_Data")
        .child(userId)
        .child("favorites")
        .once()
        .then((snapshot) {
      if (snapshot.value != null) {
        snapshot.value.forEach((key, value) {
          _favorites.add(key);
        });
      }
    });*/
    //var now = DateTime.now();


    await Firestore.instance.collection("Posts").getDocuments().then((posts){
      if(posts.documents!=null){
        posts.documents.forEach((document){
          //var value=document.data
          BoardPost newPost = BoardPost.fromMap(document.data, userId);

          if (_participations.contains(newPost.id)) {
            newPost.participating = true;
          }
          if (_favorites.contains(newPost.id)) {
            newPost.favorite = true;
          }
          _items.add(newPost);
        });
      }
    });
    /*
    var snapshot = await FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .orderByChild("date")
        .startAt(DateTime(now.year, now.month, now.day).millisecondsSinceEpoch)
        .once();

    /*var snapshot =
        await FirebaseDatabase.instance.reference().child("Posts").once();
*/
    if (snapshot.value != null) {
      snapshot.value.forEach((key, value) async {
        BoardPost newPost = BoardPost.fromMap(value, userId);

        /* if (_ownedPosts.contains(newPost.id)) {
          newPost.owner = true;
        } */
        if (_participations.contains(newPost.id)) {
          newPost.participating = true;
        }
        if (_favorites.contains(newPost.id)) {
          newPost.favorite = true;
        }
        _items.add(newPost);
      });
    }*/
    notifyListeners();
  }

  void createPost(post, String creator) {

    var doc =Firestore.instance.collection("Posts").document();
    post.id = doc.documentID;
    doc.setData(post.toJson()).then((_) {
      _items.add(post);
      notifyListeners();
      doc.updateData({"participants":FieldValue.arrayUnion([creator])});
      Firestore.instance.collection("User_Data").document(creator).updateData({"participations":FieldValue.arrayUnion([post.id])});
    });

   /* var ref = FirebaseDatabase.instance.reference().child("Posts").push();
    post.id = ref.key;
    ref.set(post.toJson()).then((_) {
      _items.add(post);
      notifyListeners();

      FirebaseDatabase.instance //add urself to the participants
          .reference()
          .child("Posts")
          .child(post.id)
          .child("participants")
          .update({
        creator: 1,
      });

      FirebaseDatabase
          .instance //add the event to ur own events in which u participate
          .reference()
          .child("User_Data")
          .child(creator)
          .child("participations")
          .update({
        post.id: post.dateInDatabaseFormat,
      });
    }).catchError((error) => print(error));
    */
  }

  BoardPost findById(String id) {
    try {
      return _items.firstWhere((post) {
        return post.id == id;
      });
    } catch (error) {
      print("no item with this ID");
      throw DiagnosticLevel.error;
    }
  }

  void removePost(String postId) async {
    Firestore.instance.collection("Posts").document(postId).delete().then((_){
      _items.removeWhere((post) {
        return post.id == postId;
      });
    });
    /*
    var ref = FirebaseDatabase.instance.reference();

    await ref.child("Posts").child(postId).remove().then((_) {
      _items.removeWhere((post) {
        return post.id == postId;
      });
    }).catchError((error) {
      print(error);
    });*/
    notifyListeners();
  }
}
