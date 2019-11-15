import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/board_posts.dart';
import '../models/user.dart';
import '../widgets/post_detail_screen_widgets/post_detail_image.dart';
import '../widgets/post_detail_screen_widgets/post_detail_text.dart';
import '../widgets/post_detail_screen_widgets/post_detail_description.dart';
import '../widgets/post_detail_screen_widgets/post_detail_member_view.dart';
import '../widgets/post_detail_screen_widgets/items_and_map.dart';
import '../widgets/post_detail_screen_widgets/post_detail_bottom_bar.dart';

class PostDetailScreen extends StatefulWidget {
  static const routeName = "/post_detail";

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool _editMode = false;
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context).settings.arguments as String;
    final post = Provider.of<BoardPosts>(context).findById(postId);

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
          icon: post.owner
              ? Icon(Icons.edit)
              : Opacity(
                  child: Icon(Icons.edit),
                  opacity: 0.2,
                ),
          onPressed: () {
            setState(() {
              _editMode = true;
            });
          },
        ),
        IconButton(
          icon: post.owner
              ? Icon(Icons.delete)
              : Opacity(
                  child: Icon(Icons.delete),
                  opacity: 0.2,
                ),
          onPressed: () {
            setState(() {
              Provider.of<BoardPosts>(context).removePost(postId);
              Navigator.pop(context);
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
              width: double.infinity,
              height: deviceHeight * 0.9,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: PostDetailImage(),
                        ),
                        Expanded(
                          child: PostDetailText(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PostDetailDescription(),
                  ),
                  Flexible(
                    child: PostDetailMemberView(),
                  ),
                  Flexible(
                    //fit: FlexFit.loose,
                    child: ItemsAndMap(),
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: deviceHeight * 0.1,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: PostDetailBottomBar(),
            ),
          ],
        ),
      ),
    );
  }
}
