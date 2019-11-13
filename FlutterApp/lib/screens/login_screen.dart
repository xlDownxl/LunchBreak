import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'board_screen.dart';
import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        //TODO Loading Circle
                        email: "lol@fefe.de",
                        password: "1234567")
                    .then((result) {
                  Provider.of<User>(context, listen: false).id =
                      "id1"; //TODO give possibility of a normal name
                  Provider.of<BoardPosts>(context, listen: false)
                      .connectToFirebase()
                      .then((value) {
                    setState(() {
                      _isLoading = false;
                    });

                    Navigator.pushNamed(context, BoardScreen.routeName);
                  });
                }).catchError((error) {
                  setState(() {
                    _isLoading = false;
                  });
                  print(error);
                }); //TODO handle error
              },
              child: Text("Login"),
              color: Theme.of(context).primaryColor,
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
