import 'package:flutter/material.dart';
import '../widgets/kf_drawer.dart';

class FeedScreen extends KFDrawerContent {
  static const routeName = "/feed";

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Activity Feed"),
          actions: <Widget>[
            Material(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: widget.onMenuPressed,
              ),
            ),
          ],
        ),
        body: Center(
          child: Text("Coming Soon!"),
        ));
  }
}
