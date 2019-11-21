import 'package:flutter/material.dart';
import 'package:FST.LunchApp/deprecated/deprecated_login_screen.dart';
import 'package:provider/provider.dart';
import 'screens/board_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/friend_list_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/add_post_screen.dart';
import 'models/board_posts.dart';
import 'models/user.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'models/board_post.dart';

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
          primaryColor: Color(0xffff6c00),
          accentColor: Color(0xff707070),
          fontFamily: 'Verdana',
        ),
        home: LoginPage(),
        routes: {
          BoardScreen.routeName: (ctx) => BoardScreen(),
          FeedScreen.routeName: (ctx) => FeedScreen(),
          FriendListScreen.routeName: (ctx) => FriendListScreen(),
          PostDetailScreen.routeName: (ctx) {
            return PostDetailScreen();
          },
          NewPostScreen.routeName: (ctx) => NewPostScreen(),
        },
      ),
    );
  }
}
