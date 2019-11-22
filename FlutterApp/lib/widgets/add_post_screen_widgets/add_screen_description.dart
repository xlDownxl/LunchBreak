import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';

class AddScreenDescription extends StatelessWidget {
  final descriptionFocus;
  AddScreenDescription(this.descriptionFocus);

  @override
  Widget build(BuildContext context) {
    var newPost = Provider.of<BoardPost>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 0, left: 10, right: 10),
      child: LayoutBuilder(
        builder: (_, constraints) => Stack(
          children: [
            Image.asset(
              "assets/icons/bubble.png",
              width: 300,
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
              child: TextFormField(
                onSaved: (val) {
                  newPost.description = val;
                },
                onEditingComplete: () {
                  descriptionFocus.unfocus();
                },
                focusNode: descriptionFocus,
                maxLines: 5,
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).accentColor),
                decoration:
                    InputDecoration.collapsed(hintText: "Enter a Description"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
