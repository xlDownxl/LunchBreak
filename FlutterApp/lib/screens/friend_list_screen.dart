import 'package:flutter/material.dart';

class FriendListScreen extends StatelessWidget {
  static const routeName = "/friend_list";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Friend List")),
      body: Center(
        child: Text("friends"),
      ),
    );
  }
}
