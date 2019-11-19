import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'board_screen.dart';
import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _activeButton = false;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool _isLoading = false;

  var password;
  var email;
  var emailError = "";
  var passwordError = "";

  final _formKey = GlobalKey<FormState>();

  void validateInput() {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      setState(() {
        _activeButton = true;
      });
    } else {
      setState(() {
        _activeButton = false;
      });
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    passwordController.addListener(() {
      validateInput();
    });
    emailController.addListener(() {
      validateInput();
    });
    super.initState();
  }

  Future register() {
    setState(() {
      emailError = "";
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
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          emailError = "Invalid Email";
          break;
        case "ERROR_WEAK_PASSWORD":
          passwordError = "Password hould have min. 6 Char.";
          break;
        default:
          emailError = "Invalid Input";
      }
    }); //TODO handle error
  }

  Future setupUserInFirebase(context) async {
    var user = await FirebaseAuth.instance.currentUser();

    Provider.of<User>(context, listen: false).id = user.uid;
    //Provider.of<User>(context, listen: false).username = username;

    return FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.uid)
        .set({
      "email": user.email,
      "id": user.uid,
      //"username": username,
    }).then((_) {
      return Provider.of<BoardPosts>(context, listen: false)
          .connectToFirebase(Provider.of<User>(context, listen: false).id);
    });
  }

  Future login() {
    setState(() {
      _isLoading = true;
      emailError = "";
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
        //var username = snapshot.value["username"];
        var userProvider = Provider.of<User>(context, listen: false);
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
      print(error.toString() + "in error in login");
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          emailError = "Invalid Email";
          break;
        case "ERROR_USER_NOT_FOUND":
          emailError = "User note found";
          break;
        case "ERROR_INVALID_EMAIL":
          emailError = "Invalid Email";
          break;
        case "ERROR_WRONG_PASSWORD":
          passwordError = "Wrong Passord";
          break;
        default:
          emailError = "Invalid Inputs";
          break;
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final emailWidget = Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15),
      child: TextFormField(
        autofocus: false,
        // initialValue: 'some password',
        style: TextStyle(color: Theme.of(context).accentColor),
        controller: emailController,
        textInputAction: TextInputAction.next,
        onSaved: (value) {
          email = value;
        },
        validator: (val) =>
            !EmailValidator.validate(val, true) ? 'Not a valid email.' : null,

        decoration: InputDecoration(
          errorText: emailError,
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(
              width: 10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 4,
                color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );

    final passwordWidget = Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15),
      child: TextFormField(
        autofocus: false,
        // initialValue: 'some password',
        obscureText: true,
        validator: (val) =>
            val.length < 4 ? 'Password should have min. 6 Chars.' : null,
        controller: passwordController,
        textInputAction: TextInputAction.done,
        onSaved: (value) {
          password = value;
        },
        decoration: InputDecoration(
          errorText: passwordError,
          errorStyle: TextStyle(color: Colors.red),
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 4,
                color: Theme.of(context).primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(style: BorderStyle.solid, width: 10),
          ),
        ),
      ),
    );

    final loginButton = Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.3),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: !_activeButton
              ? BorderSide(color: Theme.of(context).accentColor, width: 1)
              : BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
        onPressed: () {
          _formKey.currentState.validate();
          _formKey.currentState.save();
          login();
          //Navigator.of(context).pushNamed(BoardScreen.routeName);
        },
        padding: EdgeInsets.all(12),
        color: _activeButton ? Theme.of(context).primaryColor : Colors.white,
        child: Text(
          'Log In',
          style: TextStyle(
            color:
                !_activeButton ? Theme.of(context).accentColor : Colors.white,
          ),
        ),
      ),
    );

    final signUpButton = Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.3),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Theme.of(context).accentColor, width: 1),
        ),
        onPressed: () {
          _formKey.currentState.save();
          register();
          //Navigator.of(context).pushNamed(BoardScreen.routeName);
        },
        elevation: 0,
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Sign In',
            style: TextStyle(
              color: Theme.of(context).accentColor,
            )),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      onPressed: () {},
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("FST!Lunch"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        //color: Theme.of(context).primaryColor,
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                //logo,
                SizedBox(height: 48.0),
                emailWidget,
                SizedBox(height: 8.0),
                passwordWidget,
                SizedBox(height: 24.0),
                loginButton,
                forgotLabel,
                SizedBox(
                  height: 48,
                ),
                signUpButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
