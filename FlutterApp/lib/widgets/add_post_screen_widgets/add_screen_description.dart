import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';

class AddScreenDescription extends StatelessWidget {
  var newPost;
  AddScreenDescription(this.newPost);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(top: 14),
      //nipOffset: 50,
      nipHeight: 30,
      nipWidth: 10,
      //alignment: Alignment.topLeft,
      nip: BubbleNip.leftTop,
      child: TextFormField(
        initialValue: newPost.description,
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
