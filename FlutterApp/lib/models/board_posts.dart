import 'board_post.dart';
import 'user.dart';
import 'package:flutter/foundation.dart';

class BoardPosts with ChangeNotifier {
  List<BoardPost> _items = [BoardPost.getExample()];

  List<BoardPost> items() {
    return _items;
  }

  Future<void> connectToFirebase() {
    return Future.delayed(Duration(milliseconds: 0));
  }

  void addPost(post) {
    _items.add(post);
  }

  BoardPost findById(String id) {
    return _items.firstWhere((post) {
      return post.id == id;
    });
  }

  void removePost(String postId) {}
}
