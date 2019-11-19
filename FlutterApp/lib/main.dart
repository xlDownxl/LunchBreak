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
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(122, 122, 122, .1),
      100: Color.fromRGBO(122, 122, 122, .2),
      200: Color.fromRGBO(122, 122, 122, .3),
      300: Color.fromRGBO(122, 122, 122, .4),
      400: Color.fromRGBO(122, 122, 1229, .5),
      500: Color.fromRGBO(122, 122, 122, .6),
      600: Color.fromRGBO(122, 122, 122, .7),
      700: Color.fromRGBO(122, 122, 122, .8),
      800: Color.fromRGBO(122, 122, 122, .9),
      900: Color.fromRGBO(122, 122, 122, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

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
