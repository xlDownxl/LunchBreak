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
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
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
