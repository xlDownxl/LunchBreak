import 'package:flutter/material.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';

class PostDetailFavoriteIcon extends StatefulWidget {
  @override
  _PostDetailFavoriteIconState createState() => _PostDetailFavoriteIconState();
}

class _PostDetailFavoriteIconState extends State<PostDetailFavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);
    return Container(
      child: FittedBox(
        child: GestureDetector(
          child: post.favorite ? Icon(Icons.star) : Icon(Icons.star_border),
          onTap: () {
            setState(() {
              post.toggleFavorite(Provider.of<User>(context).id);
            });
          },
        ),
      ),
    );
  }
}
