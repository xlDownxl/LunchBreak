import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

class PostDetailDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: SpeechBubble(
        //nipOffset: 50,
        //nipHeight: 30,
        nipLocation: NipLocation.TOP,
        color: Colors.white,
        borderRadius: 20,
        width: 100,
        height: 100,

        //alignment: Alignment.topLeft,

        child: Text(post.description),
      ),
    );
  }
}
