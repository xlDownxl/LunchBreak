import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  static const routeName = "/new_post_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NEw Post")),
      body: Center(
        child: Text("post form"),
      ),
    );
  }
}
