import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  static const routeName = "/post_detail";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Details")),
      body: Center(
        child: Text("post"),
      ),
    );
  }
}
