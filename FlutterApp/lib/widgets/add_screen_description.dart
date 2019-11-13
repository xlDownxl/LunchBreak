import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';
import '../models/board_post.dart';

class AddScreenDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newPost = Provider.of<BoardPost>(context, listen: false);
    return Bubble(
      margin: BubbleEdges.only(top: 14),
      //nipOffset: 50,
      nipHeight: 30,
      nipWidth: 10,
      //alignment: Alignment.topLeft,
      nip: BubbleNip.leftTop,
      child: TextFormField(
        onSaved: (value) {
          newPost.description = value;
        },
        decoration: InputDecoration(
          labelText: "Enter a Description",
        ),
        maxLines: 5,
      ),
    );
  }
}
