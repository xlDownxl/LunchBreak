import 'package:flutter/material.dart';
import 'add_post_screen.dart';
import 'feed_screen.dart';
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
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import '../widgets/kf_drawer.dart';
import 'package:FST.LunchApp/utils/class_builder.dart';

class BoardScreen extends KFDrawerContent {
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
  KFDrawerController _drawerController;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    if (init) {
      userId = Provider.of<User>(context).id;
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

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Events'),
      actions: <Widget>[
        SafeArea(
          child: Material(
            shadowColor: Colors.transparent,
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: widget.onMenuPressed,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.more),
          onPressed: () {
            Navigator.pushNamed(context, FeedScreen.routeName);
          },
        ),
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            //Navigator.pushNamed(context, FriendListScreen.routeName);
          },
        ),
      ],
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final List<Widget> children = _children(deviceHeight);

    Widget mainPage = RefreshIndicator(
      child: children[_selectedPageIndex],
      onRefresh: _update,
    );

    return SafeArea(
      child: Scaffold(
        key: _scaffoldstate,
        appBar: appBar,
        body: mainPage,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              navigateToSubPage(context); //TODO
            }),
        bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          activeColor: Theme.of(context).primaryColor,
          items: [
            TitledNavigationBarItem(
              icon: Icons.home,
              title: 'Today',
            ),
            TitledNavigationBarItem(
              icon: Icons.calendar_today,
              title: 'Calendar',
            ),
            TitledNavigationBarItem(
              icon: Socicon.bullhorn,
              title: 'My Events',
            ),
            TitledNavigationBarItem(
              icon: Icons.star,
              title: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
