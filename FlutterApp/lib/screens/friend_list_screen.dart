import 'package:flutter/material.dart';
import '../widgets/kf_drawer.dart';

class FriendList extends KFDrawerContent {
  static const routeName = "/friends";
  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Friend List"),
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
