import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/board_post_element.dart';
import 'new_post_screen.dart';
import 'feed_screen.dart';
import '../models/board_post.dart';
import 'friend_list_screen.dart';

class BoardScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  var init = true;
  var userId;
  //final _firebaseMessaging = FirebaseMessaging();

  final List<BoardPost> postList = [BoardPost(), BoardPost(), BoardPost()];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      userId = user.uid;
    });
    super.initState();
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
      setupPushNotifications();
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Stock Alarm'),
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

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: deviceHeight,
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: postList.length,
          itemBuilder: (ctx, i) => BoardPostGridElement(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, NewPostScreen.routeName);
          }),
      bottomNavigationBar: BottomNavigationBar(
        //onTap: () {}, // new
        //currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Today'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('My Events'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Created Events'),
          ),
        ],
      ),
    );
  }
}
