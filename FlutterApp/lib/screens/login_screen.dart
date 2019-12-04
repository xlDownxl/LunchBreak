import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_login/flutter_login.dart';
import '../widgets/kf_drawer.dart';

import 'drawer_screen.dart';

class LoginPage extends KFDrawerContent {
  static const routeName = "/login";

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var fbUser;
  var init = true;

  Future setupUserInFirebase(context) async {
    var user = await FirebaseAuth.instance.currentUser();
    Provider.of<User>(context, listen: false).id = user.uid;
    Provider.of<User>(context, listen: false).email = user.email;

    return FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.uid)
        .set({
      "email": user.email,
      "id": user.uid,
    }).then((_) {
      return Provider.of<BoardPosts>(context, listen: false)
          .connectToFirebase(Provider.of<User>(context, listen: false).id);
    });
  }

  Future<String> _login(LoginData data) async {
    var code = await Future.any(
      [
        _loginUser(data),
        Future.delayed(
          const Duration(seconds: 8),
        ),
      ],
    );
    switch (code) {
      case "ERROR_INVALID_EMAIL":
        return "Invalid Email";
      case "ERROR_USER_NOT_FOUND":
        return "User note found";
      case "ERROR_INVALID_EMAIL":
        return "Invalid Email";
      case "ERROR_WRONG_PASSWORD":
        return "Wrong Passord";
      case "success":
        return null;
      default:
        return "Invalid Inputs";
    }
  }

  Future<String> _loginUser(data) async {
    var userProvider = Provider.of<User>(context, listen: false);

    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: data.name, password: data.password)
        .then((_) async {
      fbUser = await FirebaseAuth.instance.currentUser();

      await FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(fbUser.uid)
          .once()
          .then((snapshot) {
        userProvider.id = fbUser.uid;
        userProvider.email = fbUser.email;
        //userProvider.token = token;
      });

      await Provider.of<BoardPosts>(context, listen: false)
          .connectToFirebase(Provider.of<User>(context, listen: false).id);

      return "success";
    }).catchError((error) => error.code);
    //});
  }

  Future<String> _register(LoginData data) async {
    var code = await _registerUser(data);
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "Email already taken";
      case "ERROR_INVALID_EMAIL":
        return "Invalid Email";
      case "ERROR_WEAK_PASSWORD":
        return "Password should be min. 6 Char.";
      case "success":
        return null;
      default:
        return "Invalid Input";
    }
  }

  Future<String> _registerUser(data) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: data.name, password: data.password)
        .then((_) async {
      //Provider.of<User>(context, listen: false).isNew = true;
      await setupUserInFirebase(context);
      return "success";
    }).catchError((error) => error.code);
  }

  Future<String> _recoverPassword(String name) async {
    print('Name: $name');
    return Future.delayed(Duration(seconds: 1)).then((_) {
      return "Not implemented yet";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterLogin(
        title: 'FST!Lunch',
        //logo: 'assets/images/Download.jpeg',
        onLogin: _login,
        onSignup: _register,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => DrawerScreen(),
            ),
          );
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
