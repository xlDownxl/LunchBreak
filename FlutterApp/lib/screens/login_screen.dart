import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'board_screen.dart';
import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  var username;
  var password;
  var email;
  final _formKey = GlobalKey<FormState>();

  Future register() {
    if (username == null) {
      throw StepState.error;
    }
    if (username == "") {
      throw StepState.error;
    }
    setState(() {
      _isLoading = true;
    }); //TODO give possibility of a normal name
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((result) {
      return setupUserInFirebase(context).then((_) {
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
  }

  Future setupUserInFirebase(context) async {
    var user = await FirebaseAuth.instance.currentUser();

    Provider.of<User>(context, listen: false).id = user.uid;
    Provider.of<User>(context, listen: false).username = username;

    return FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.uid)
        .set({
      "email": user.email,
      "id": user.uid,
      "username": username,
    }).then((_) {
      return Provider.of<BoardPosts>(context, listen: false)
          .connectToFirebase(Provider.of<User>(context, listen: false).id);
    });
  }

  Future login() {
    setState(() {
      _isLoading = true;
    }); //TODO give possibility of a normal name
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((_) async {
      var user = await FirebaseAuth.instance.currentUser();

      await FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(user.uid)
          .once()
          .then((snapshot) {
        var username = snapshot.value["username"];
        var userProvider = Provider.of<User>(context, listen: false);
        userProvider.username = username;
        userProvider.id = user.uid;
      });

      await Provider.of<BoardPosts>(context, listen: false)
          .connectToFirebase(Provider.of<User>(context, listen: false).id);
    }).then((_) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacementNamed(context, BoardScreen.routeName);
    }).catchError((error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                _formKey.currentState.save();
                register();
              },
              child: Text("Register"),
              color: Theme.of(context).primaryColor,
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
            FlatButton(
              onPressed: () {
                _formKey.currentState.save();
                login();
              },
              child: Text("Login"),
              color: Theme.of(context).primaryColor,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "email",
                    ),
                    initialValue: "lo2lkek@gmd.de",
                    onSaved: (value) {
                      email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "password"),
                    initialValue: "123456",
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "username",
                    ),
                    initialValue: "damnboy",
                    onSaved: (value) {
                      username = value;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
