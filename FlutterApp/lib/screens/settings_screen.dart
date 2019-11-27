import 'package:flutter/material.dart';
import '../widgets/kf_drawer.dart';

class Settings extends KFDrawerContent {
  static const routeName = "/settings";
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        child: Column(
          children: <Widget>[
            Text("User Settings"),
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
