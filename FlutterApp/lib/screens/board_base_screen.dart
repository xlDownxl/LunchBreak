import 'package:flutter/material.dart';
import '../models/board_post.dart';
import '../widgets/board_post_element.dart';

class BoardBaseScreen extends StatefulWidget {
  final deviceHeight;

  BoardBaseScreen(this.deviceHeight);

  @override
  _BoardBaseScreenState createState() => _BoardBaseScreenState();
}

class _BoardBaseScreenState extends State<BoardBaseScreen> {
  @override
  Widget build(BuildContext context) {
    final List<BoardPost> postList = [BoardPost(), BoardPost(), BoardPost()];

    return Container(
      height: widget.deviceHeight,
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
    );
  }
}
