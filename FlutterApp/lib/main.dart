import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/board_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/friend_list_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/add_post_screen.dart';
import 'models/board_posts.dart';
import 'models/user.dart';
import 'screens/login_screen.dart';
import 'utils/class_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/drawer_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  ClassBuilder.registerClasses();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = User();
  FirebaseUser fbUser;

  @override
  void initState() {
    print("kek");
    getUser().then((fbuser) {
      if (fbuser != null) {
        print("fbuser not null");
        user.email = fbuser.email;
        user.id = fbuser.uid;
        Firestore.instance.collection("User_Data").document(fbUser.uid).get().then((snap){
          user.username = snap.data["username"];
        });
      }
    });

    super.initState();
  }

  Future<FirebaseUser> getUser() async {
    return await auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => BoardPosts(),
        ),
        ChangeNotifierProvider.value(
          value: user,
        ),
      ],
      child: MaterialApp(
        title: 'Stock Alarm',
        theme: ThemeData(
          primaryColor: Color(0xffff6c00),
          accentColor: Color(0xff707070),
          fontFamily: 'Verdana',
        ),
        home: fbUser == null ? LoginPage() : DrawerScreen(),
        routes: {
          LoginPage.routeName: (ctx) => LoginPage(),
          BoardScreen.routeName: (ctx) => BoardScreen(),
          FeedScreen.routeName: (ctx) => FeedScreen(),
          FriendList.routeName: (ctx) => FriendList(),
          PostDetailScreen.routeName: (ctx) => PostDetailScreen(),
          NewPostScreen.routeName: (ctx) => NewPostScreen(),
        },
      ),
    );
  }
}
