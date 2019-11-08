import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  static const routeName = "/feed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed Screen")),
      body: Center(
        child: Text("feed"),
      ),
    );
  }
}
