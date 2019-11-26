import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';
import '../widgets/post_detail_screen_widgets/post_detail_image.dart';
import '../widgets/post_detail_screen_widgets/post_detail_text.dart';
import '../widgets/post_detail_screen_widgets/post_detail_description.dart';
import '../widgets/post_detail_screen_widgets/post_detail_member_view.dart';
import '../widgets/google_maps.dart';
import '../widgets/post_detail_screen_widgets/post_detail_bottom_bar.dart';
import 'add_post_screen.dart';
import '../models/board_post.dart';

class PostDetailScreen extends StatefulWidget {
  static const routeName = "/post_detail";

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool _editMode = false;
  BoardPost post;

  void joinEvent() async {
    post.toggleParticipating(Provider.of<User>(context).id);
    Navigator.pop(context,
        {"id": post.id, "title": post.title, "action": post.participating});
    //TODO Snackbar
  }

  @override
  Widget build(BuildContext context) {
    var userId = Provider.of<User>(context, listen: false).id;
    final postId = ModalRoute.of(context).settings.arguments as String;
    post = Provider.of<BoardPosts>(context).findById(postId);

    var appBar = AppBar(
      title: Text("Post Details"),
      actions: <Widget>[
        IconButton(
          icon: post.favorite ? Icon(Icons.star) : Icon(Icons.star_border),
          onPressed: () {
            setState(() {
              post.toggleFavorite(Provider.of<User>(context).id);
            });
          },
        ),
        IconButton(
          icon: post.owner == userId
              ? Icon(Icons.edit)
              : Opacity(
                  child: Icon(Icons.edit),
                  opacity: 0.2,
                ),
          onPressed: () {
            if (post.owner == userId) {
              setState(() {
                Navigator.pushNamed(context, NewPostScreen.routeName,
                    arguments: post.id);
              });
            }
          },
        ),
        IconButton(
          icon: post.owner == userId
              ? Icon(Icons.delete)
              : Opacity(
                  child: Icon(Icons.delete),
                  opacity: 0.2,
                ),
          onPressed: () {
            setState(() {
              if (post.owner == userId) {
                Provider.of<BoardPosts>(context).removePost(postId);
                Navigator.pop(context);
              }
            });
          },
        ),
      ],
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    //TODO think about showing owner
    return ChangeNotifierProvider.value(
      value: post,
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: <Widget>[
            Container(
              height: deviceHeight * 0.9,
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child: Row(children: <Widget>[
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                child: PostDetailImage(),
                              ),
                              Expanded(
                                child: Container(
                                  child: PostDetailDescription(),
                                  padding: EdgeInsets.all(10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(child: PostDetailText()),
                      ]),
                    ),
                    flex: 3,
                  ),
                  Flexible(
                    child: Container(
                      child: PostDetailMemberView(),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      child: GoogleMaps(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: deviceHeight * 0.1,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: PostDetailBottomBar(joinEvent),
            ),
          ],
        ),
      ),
    );
  }
}
