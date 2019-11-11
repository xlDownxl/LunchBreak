import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  static const routeName = "/new_post_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Post")),
      body: Center(
        child: Text("post form"),
      ),
    );
  }
}
