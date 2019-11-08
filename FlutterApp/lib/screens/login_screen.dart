import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'board_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: FlatButton(
          onPressed: () {
            FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: "lol@fefe.de", password: "1234567");

            Navigator.pushNamed(context, BoardScreen.routeName);
          },
          child: Text("Login"),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
