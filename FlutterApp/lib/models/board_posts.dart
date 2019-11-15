import 'board_post.dart';
import 'user.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoardPosts with ChangeNotifier {
  List<BoardPost> _items = [BoardPost.getExample()];
  List _participations = [];

  List<BoardPost> items() {
    return _items;
  }

  List<BoardPost> favorites() {
    return _items.where((post) {
      return post.favorite == true;
    }).toList();
  }

  List<BoardPost> participating() {
    return _items.where((post) {
      return post.participating || post.owner;
    }).toList();
  }

  Future connectToFirebase(userId) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Users")
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

    return FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .once()
        .then((snapshot) {
      if (snapshot.value != null) {
        snapshot.value.forEach((key, value) async {
          print(key);
          print(value);

          BoardPost newPost = BoardPost.fromMap(value, userId);
          await FirebaseDatabase.instance
              .reference()
              .child("Users")
              .child(userId)
              .child("ownedPosts")
              .once()
              .then((snapshot) {
            if (snapshot.value != null) {
              snapshot.value.forEach((key, value) {
                if (key == newPost.id) {
                  newPost.owner = true;
                }
              });
            }
          });
          await FirebaseDatabase.instance
              .reference()
              .child("Users")
              .child(userId)
              .child("favorites")
              .once()
              .then((snapshot) {
            if (snapshot.value != null) {
              snapshot.value.forEach((key, value) {
                if (key == newPost.id) {
                  newPost.favorite = true;
                }
              });
            }
          });
          if (_participations.contains(newPost.id)) {
            newPost.participating = true;
          }
          _items.add(newPost);
          notifyListeners();
        });
      }
    }).catchError((error) {
      print("error" + error);
    });
  }

  //TODO WRITE FAVORITES TO DATABASE

  void createPost(post, String creator) {
    var ref = FirebaseDatabase.instance.reference().child("Posts").push();
    post.id = ref.key;
    post.date = DateTime.now(); //TODO datumseingabe
    ref.set(post.toJson()).then((_) {
      FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(creator)
          .child("ownedPosts")
          .set({post.id: post.title}).then((_) {
        post.owner = true;
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
            .child("Users")
            .child(creator)
            .child("participations")
            .update({
          post.id: post.dateInDatabaseFormat,
        });
      });
    }).catchError((error) => print(error));
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
    var ref = FirebaseDatabase.instance.reference();

    await ref.child("Posts").child(postId).remove().then((_) {
      _items.removeWhere((post) {
        return post.id == postId;
      });
    }).catchError((error) {
      print(error);
    });
    notifyListeners();
  }
}
