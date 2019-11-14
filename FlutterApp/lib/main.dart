import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'screens/board_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/friend_list_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/new_post_screen.dart';
import 'models/board_posts.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => BoardPosts(),
        ),
        ChangeNotifierProvider(
          builder: (_) => User(),
        ),
      ],
      child: MaterialApp(
        title: 'Stock Alarm',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.redAccent,
          fontFamily: 'Verdana',
        ),
        home: LoginScreen(),
        routes: {
          BoardScreen.routeName: (ctx) => BoardScreen(),
          FeedScreen.routeName: (ctx) => FeedScreen(),
          FriendListScreen.routeName: (ctx) => FriendListScreen(),
          PostDetailScreen.routeName: (ctx) => PostDetailScreen(),
          NewPostScreen.routeName: (ctx) => NewPostScreen(),
        },
      ),
    );
  }
}
