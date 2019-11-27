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
    return SafeArea(
        child: Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        child: Column(
          children: <Widget>[
            Text("Friends"),
            Material(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: widget.onMenuPressed,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
