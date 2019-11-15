import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../models/board_post.dart';

class GridItemFavoriteIcon extends StatefulWidget {
  @override
  _GridItemFavoriteIconState createState() => _GridItemFavoriteIconState();
}

class _GridItemFavoriteIconState extends State<GridItemFavoriteIcon> {
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
