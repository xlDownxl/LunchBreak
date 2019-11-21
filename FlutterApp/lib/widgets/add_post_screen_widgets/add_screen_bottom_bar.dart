import 'package:flutter/material.dart';
import '../../design/balloon_new_icons.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';
import '../../models/board_posts.dart';
import '../../models/user.dart';

class AddScreenBottomBar extends StatefulWidget {
  final Function createEvent;
  bool _editMode;
  AddScreenBottomBar(this._editMode, this.createEvent);

  @override
  _AddScreenBottomBarState createState() => _AddScreenBottomBarState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _AddScreenBottomBarState extends State<AddScreenBottomBar> {
  var posts;
  var newPost;

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
    newPost = Provider.of<BoardPost>(context);
    posts = Provider.of<BoardPosts>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: InkWell(
            onTap: () {
              _asyncConfirmDialog(context).then((result) {
                if (result == ConfirmAction.ACCEPT) {
                  Navigator.pop(context);
                }
              });
            },
            child: FittedBox(
              fit: BoxFit.fill,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Cancel",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: SizedBox(),
          fit: FlexFit.tight,
        ),
        Flexible(
          flex: 4,
          child: Container(
            padding: EdgeInsets.only(bottom: 10, top: 2),
            child: RaisedButton(
              shape: StadiumBorder(),
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      child: FittedBox(
                        child: !widget._editMode
                            ? Text(
                                "Create",
                                style: TextStyle(fontSize: 26),
                              )
                            : Text(
                                "Save",
                                style: TextStyle(fontSize: 30),
                              ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Icon(
                      BalloonNew.balloonicon,
                      size: 40,
                    ),
                    fit: FlexFit.loose,
                  ),
                ],
              ),
              onPressed: () {
                if (!widget._editMode) {
                  widget.createEvent();
                } else {
                  // TODO Update Event
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
