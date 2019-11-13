import 'package:flutter/material.dart';
import '../design/balloon_new_icons.dart';
import 'package:provider/provider.dart';
import '../models/board_post.dart';
import '../models/board_posts.dart';

class AddScreenBottomBar extends StatefulWidget {
  final form;
  AddScreenBottomBar(this.form);

  @override
  _AddScreenBottomBarState createState() => _AddScreenBottomBarState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _AddScreenBottomBarState extends State<AddScreenBottomBar> {
  var posts;
  var newPost;
  void createEvent() {
    widget.form.currentState.save();
    newPost = Provider.of<BoardPost>(context, listen: false);
    print(newPost.toString());
    print(newPost.language);
    print(newPost.memberLimit);
    print(newPost.description);
    posts.addPost(newPost);
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel?'),
          content:
              const Text('If you go back all Data will be lost. Continue?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('CONTINUE'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    posts = Provider.of<BoardPosts>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: InkWell(
            onTap: () {
              _asyncConfirmDialog(context).then((result) {
                if (result == ConfirmAction.ACCEPT) {
                  Navigator.pop(context);
                }
              });
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back),
                Text(
                  "Cancel",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: SizedBox(),
          fit: FlexFit.tight,
        ),
        Flexible(
          child: OutlineButton(
            //shape: RoundedRectangleBorder(
            //  borderRadius: BorderRadius.circular(30.0)),
            //highlightColor: Colors.black,
            shape: StadiumBorder(),
            textColor: Colors.blue,

            borderSide: BorderSide(
                color: Colors.blue, style: BorderStyle.solid, width: 1),
            //shape: CircleBorder(side: BorderSide(style: BorderStyle.solid)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(right: 4),
                    child: FittedBox(
                      child: Text(
                        "Create",
                        style: TextStyle(fontSize: 30),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Icon(BalloonNew.balloonicon),
                  fit: FlexFit.loose,
                ),
              ],
            ),
            onPressed: () {
              createEvent(); //check firebase id generierung -> wenn push was macht dann die id generierung in createvent
              //auslagern damit nur id kreiert wird wenn der kreieren button gedrückt wird
              Navigator.pop(context, {"created": true, "postId": newPost.id});
            },
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
