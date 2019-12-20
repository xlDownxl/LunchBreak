          import 'package:flutter/material.dart';
import 'add_post_screen.dart';
import 'feed_screen.dart';
import 'all_posts_screen.dart';
import 'today_posts_Screen.dart';
import 'board_my_posts_screen.dart';
import 'favorite_screen.dart';
import '../design/socicon_icons.dart';
import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import '../widgets/kf_drawer.dart';
import 'package:after_layout/after_layout.dart';                                              
import 'package:rflutter_alert/rflutter_alert.dart';


          class BoardScreen extends KFDrawerContent {
  static const routeName = "/home";

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen>
    with AfterLayoutMixin<BoardScreen> {
  int _selectedPageIndex = 0;
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  List<Widget> _children(deviceHeight) => [
        TodayPostsScreen(deviceHeight),
        AllPostsScreen(deviceHeight),
        BoardMyPostsScreen(deviceHeight),
        FavoriteScreen(deviceHeight),
      ];

  var titles = ["Today's Events", "Calendar", "My Events", "Favorites"];

  var init = true;
  var userId;
  var user;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (user.username == null) {
      _displayDialog(context);
    }
  }

  Future _displayDialog(BuildContext context) async {
    Alert(
        style: AlertStyle(
          isOverlayTapDismiss: false,
          isCloseButton: false,
        ),
        context: context,
        title: "Welcome to FST Lunch",
        content: Column(
          children: <Widget>[
            Text("Please Enter your Name!"),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (val) {
                  if (val.isNotEmpty) {
                    return null;
                  } else {
                    return "Please type your Name";
                  }
                },
                onSaved: (val) {
                  user.setUsername(val);
                },
                decoration: InputDecoration(hintText: "Name"), //maybe add icon
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.of(context).pop();
              }
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }



  @override
  void didChangeDependencies() {
    if (init) {
      user = Provider.of<User>(context);
      userId = user.id;
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
      title: Text(titles[_selectedPageIndex]),
      actions: <Widget>[
        Material(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: widget.onMenuPressed,
          ),
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

    return Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.5, 0.7, 0.9],
        colors: [
        Colors.yellow[800],
        Colors.orange[700],
        Colors.orange[600],
        Colors.red[400],
        ],),
        ),
      child: Scaffold(
        key: _scaffoldstate,
        appBar: appBar,
        backgroundColor: Colors.transparent,
        body: Consumer<User>(
          child: mainPage,
          builder: (_, user, child) {
            return child;
          },
        ),
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
