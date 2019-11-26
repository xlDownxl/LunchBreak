import 'package:flutter/material.dart';
import '../../design/balloon_new_icons.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';

class PostDetailBottomBar extends StatelessWidget {
  final Function joinEvent;
  PostDetailBottomBar(this.joinEvent);

  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
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
                    "Back",
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
                    flex: 2,
                    child: Icon(
                      BalloonNew.balloonicon,
                      size: 40,
                    ),
                    fit: FlexFit.loose,
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      child: FittedBox(
                        child: !post.participating
                            ? Text(
                                "Join",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "Leave",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                joinEvent();
              },
            ),
          ),
        ),
      ],
    );
  }
}
