import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'screens/board_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/friend_list_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/new_post_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Alarm',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.redAccent,
        fontFamily: 'Lato',
      ),
      home: LoginScreen(),
      routes: {
        BoardScreen.routeName: (ctx) => BoardScreen(),
        FeedScreen.routeName: (ctx) => FeedScreen(),
        FriendListScreen.routeName: (ctx) => FriendListScreen(),
        PostDetailScreen.routeName: (ctx) => PostDetailScreen(),
        NewPostScreen.routeName: (ctx) => NewPostScreen(),
      },
    );
  }
}
