import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';

class GridItemImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);
    return LayoutBuilder(
      builder: (ctx, constraints) => Container(
        margin: EdgeInsets.only(right: 5),
        height: constraints.maxWidth * 0.85,
        width: constraints.maxWidth * 0.85,
        decoration: BoxDecoration(
          border: Border.all(),
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(post.imageUrl),
          ),
        ),
      ),
    );
  }
}
