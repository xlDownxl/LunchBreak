import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'board_screen.dart';
import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_login/flutter_login.dart';
import '../widgets/kf_drawer.dart';
import '../utils/class_builder.dart';
import 'drawer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends KFDrawerContent {
  static const routeName = "/login";

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var fbUser;

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
    var code = await _loginUser(data);
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

  Future<String> _loginHelper() async {
    await FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(fbUser.uid)
        .once()
        .then((snapshot) {
      var userProvider = Provider.of<User>(context, listen: false);
      userProvider.id = fbUser.uid;
      userProvider.email = fbUser.email;
    });

    await Provider.of<BoardPosts>(context, listen: false)
        .connectToFirebase(Provider.of<User>(context, listen: false).id);

    return "success";
  }

  Future<String> _loginUser(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loadToken = prefs.getString('token') ?? "";
    var li =
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRhOWEzMGI5ZThkYTMxNjY2YTY3NTRkZWZlZDQxNzQzZjJlN2FlZWEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZnN0LWx1bmNoYXBwIiwiYXVkIjoiZnN0LWx1bmNoYXBwIiwiYXV0aF90aW1lIjoxNTc0OTQyMDE3LCJ1c2VyX2lkIjoiVFJOaURSNlV0ak12bmRxa2lKc3JkTElFZjAwMyIsInN1YiI6IlRSTmlEUjZVdGpNdm5kcWtpSnNyZExJRWYwMDMiLCJpYXQiOjE1NzQ5NDIwMTcsImV4cCI6MTU3NDk0NTYxNywiZW1haWwiOiJsb2xrZWtAbG9sa2VrLmRlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImxvbGtla0Bsb2xrZWsuZGUiXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.l7l7eXZNUlO3VFkbDjqkR2My-4GcgoOF2I5S2t1nJL4grsh5UDvZTImCZJWgRYvaRj4UZuZLw8JkrupdAcga7R7qUXsmLJW859etbE7rKD7AM3GqnvfpmUp2sTcLAX0sVKvIcB_RVNXG992Y2MtmPnnRa5HKGuEVacJH0vSdd5AfjYgKEwVjOl8PQhRxH7eUzH4B0SK3QMzRYWC-bI8qADbDZCt6Oegy5nG5FeVIvORw7OlABcN-1dZIYi68ERn0PR5yMFvN9-Gw8khbEwyVH6V-TskIc3fOU-bgq_ReKkc99Rx9jS8x3MKAxWHQmoxmV2cCmi6BgQ0su-v9qe7ktQ";
    return FirebaseAuth.instance
        .signInWithCustomToken(token: loadToken)
        .then((he) async {
      fbUser = await FirebaseAuth.instance.currentUser();
      await FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(fbUser.uid)
          .once()
          .then((snapshot) {
        var userProvider = Provider.of<User>(context, listen: false);
        userProvider.id = fbUser.uid;
        userProvider.email = fbUser.email;
      });

      await Provider.of<BoardPosts>(context, listen: false)
          .connectToFirebase(Provider.of<User>(context, listen: false).id);

      return "success";
    }).catchError((_) {
      return FirebaseAuth.instance
          .signInWithEmailAndPassword(email: data.name, password: data.password)
          .then((_) async {
        fbUser = await FirebaseAuth.instance.currentUser();
        var token = await fbUser.getIdToken();
        await prefs.setString('token', token.token);
        await FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(fbUser.uid)
            .once()
            .then((snapshot) {
          var userProvider = Provider.of<User>(context, listen: false);
          userProvider.id = fbUser.uid;
          userProvider.email = fbUser.email;
        });

        await Provider.of<BoardPosts>(context, listen: false)
            .connectToFirebase(Provider.of<User>(context, listen: false).id);

        return "success";
      }).catchError((error) => error.code);
    });
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
    await Future.delayed(Duration(seconds: 1)).then((_) {
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
