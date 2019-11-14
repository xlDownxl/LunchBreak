import 'package:flutter/material.dart';
import '../models/board_post.dart';
import '../widgets/board_post_element.dart';
import '../models/board_posts.dart';
import '../models/board_post.dart';
import 'package:provider/provider.dart';

class BoardBaseScreen extends StatefulWidget {
  final deviceHeight;

  BoardBaseScreen(this.deviceHeight);

  @override
  _BoardBaseScreenState createState() => _BoardBaseScreenState();
}

class _BoardBaseScreenState extends State<BoardBaseScreen> {
  @override
  Widget build(BuildContext context) {
    //final List<BoardPost> postList = [BoardPost(), BoardPost(), BoardPost()];

    List<BoardPost> postList = Provider.of<BoardPosts>(context).items();

    return Container(
      height: widget.deviceHeight,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: postList.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          child: BoardPostGridElement(postList[i].id),
          value: postList[i],
        ),
        //TODO hier ansetzen
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
