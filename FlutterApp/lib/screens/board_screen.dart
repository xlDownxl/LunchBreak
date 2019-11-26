import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FST.LunchApp/widgets/board_post_widgets/board_post_grid_element.dart';
import 'add_post_screen.dart';
import 'feed_screen.dart';
import '../models/board_post.dart';
import 'friend_list_screen.dart';
import 'all_posts_screen.dart';
import 'today_posts_Screen.dart';
import 'board_my_posts_screen.dart';
import 'favorite_screen.dart';
import '../design/socicon_icons.dart';
import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';
import 'package:flutter/services.dart';

class BoardScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  int _selectedPageIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  List<Widget> _children(deviceHeight) => [
        TodayPostsScreen(deviceHeight),
        AllPostsScreen(deviceHeight),
        BoardMyPostsScreen(deviceHeight),
        FavoriteScreen(deviceHeight),
      ];

  var init = true;
  var userId;

  @override
  void initState() {
    handleAppLifecycleState();
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void setupPushNotifications() {
    /*  _firebaseMessaging.configure(
      // ignore: missing_return
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text("ALARM"),
              );
            });
      },
      // ignore: missing_return
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      // ignore: missing_return
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );*/
  }

  @override
  void didChangeDependencies() {
    if (init) {
      userId = Provider.of<User>(context).id;
      setupPushNotifications();
      init = false;
    }
    super.didChangeDependencies();
  }

  Future navigateToSubPage(context) async {
    var created = await Navigator.pushNamed(context, NewPostScreen.routeName)
        as Map<String, Object>;
    if (created != null) {
      if (created["created"]) {
        _scaffoldstate.currentState.showSnackBar(
          SnackBar(
            content: Text(
              'Added new Event!',
            ),
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                Provider.of<BoardPosts>(context, listen: false)
                    .removePost(created["postId"]);
              },
            ),
          ),
        );
      }
    }
  }

  Future<void> _update() async {
    await Provider.of<BoardPosts>(context).connectToFirebase(userId);
  }

  void handleAppLifecycleState() {
    AppLifecycleState _lastLifecyleState;
    // ignore: missing_return
    SystemChannels.lifecycle.setMessageHandler((msg) {
      print('SystemChannels> $msg');
      switch (msg) {
        case "AppLifecycleState.resumed":
          _lastLifecyleState = AppLifecycleState.resumed;
          print(_lastLifecyleState);
          _update();
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Events'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more),
          onPressed: () {
            Navigator.pushNamed(context, FeedScreen.routeName);
          },
        ),
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamed(context, FriendListScreen.routeName);
          },
        ),
      ],
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final List<Widget> children = _children(deviceHeight);

    return Scaffold(
      key: _scaffoldstate,
      appBar: appBar,
      body: RefreshIndicator(
        child: children[_selectedPageIndex],
        onRefresh: _update,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            navigateToSubPage(context); //TODO
          }),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        elevation: 10,
        iconSize: 26,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Today'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Socicon.bullhorn),
            title: Text('Overview'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Socicon.bullhorn),
            title: Text('My Events'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
