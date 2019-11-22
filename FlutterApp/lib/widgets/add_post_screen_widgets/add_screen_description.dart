import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';
import '../speech_bubble.dart';

class AddScreenDescription extends StatefulWidget {
  final FocusNode descriptionFocus;
  AddScreenDescription(this.descriptionFocus);

  @override
  _AddScreenDescriptionState createState() => _AddScreenDescriptionState();
}

class _AddScreenDescriptionState extends State<AddScreenDescription> {
  Color borderColor = Colors.black;

  @override
  void initState() {
    widget.descriptionFocus.addListener(() {
      if (widget.descriptionFocus.hasFocus) {
        setState(() {
          borderColor = Colors.red;
        });
      } else {
        setState(() {
          borderColor = Colors.black;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newPost = Provider.of<BoardPost>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 0, left: 10, right: 10),
      child: LayoutBuilder(
        builder: (_, constraints) => SpeechBubble(
          color: Colors.white,
          borderColor: borderColor,
          nipHeight: 15,
          nipLocation: NipLocation.TOP,
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          borderRadius: 40,
          padding: EdgeInsets.all(20),
          child: TextFormField(
            onSaved: (val) {
              newPost.description = val;
            },
            onEditingComplete: () {
              widget.descriptionFocus.unfocus();
            },
            focusNode: widget.descriptionFocus,
            maxLines: 5,
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).accentColor),
            decoration:
                InputDecoration.collapsed(hintText: "Enter a Description"),
          ),
        ),

        /* Stack(
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
        ),*/
      ),
    );
  }
}
