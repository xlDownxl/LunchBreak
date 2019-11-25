import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';

class PostDetailImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: LayoutBuilder(
        builder: (ctx, constraints) => Container(
          padding: EdgeInsets.all(10),
          width: constraints.maxHeight,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                post.imageUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
