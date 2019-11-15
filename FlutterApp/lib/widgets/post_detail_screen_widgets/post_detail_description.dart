import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';

class PostDetailDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      constraints: BoxConstraints.expand(),
      child: Bubble(
        margin: BubbleEdges.only(top: 14),
        //nipOffset: 50,
        nipHeight: 30,
        nipWidth: 10,
        //alignment: Alignment.topLeft,
        nip: BubbleNip.leftTop,
        child: Text(post.description),
      ),
    );
  }
}
