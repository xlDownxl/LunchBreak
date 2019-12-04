import 'package:flutter/material.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';
import '../speech_bubble.dart';

class PostDetailDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);
    return LayoutBuilder(
      builder: (ctx, constraints) => Container(
        padding: EdgeInsets.only(bottom: 20),
        child: SpeechBubble(
          borderColor: Colors.black,
          color: Colors.white,
          borderWidth: 1,
          nipHeight: 15,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          nipLocation: NipLocation.TOP,
          borderRadius: 40,
          padding: EdgeInsets.all(20),
          child: Text(post.description),
        ),
      ),
    );
  }
}
