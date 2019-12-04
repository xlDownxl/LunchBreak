import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/board_post.dart';
import '../../models/user.dart';
import '../../design/balloon_new_icons.dart';

class GridItemJoinButton extends StatelessWidget {
  final postId;
  GridItemJoinButton(this.postId);

  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.red)),
          color: Theme.of(context).primaryColor,
          elevation: 2,
          onPressed: () {
            post.toggleParticipating(Provider.of<User>(context).id);
            /*showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return SimpleDialog(
                    title: Text("Joined ${post.title}!"),
                  );
                });*/
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: EdgeInsets.only(right: 4),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        BalloonNew.balloonicon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 2,
                    ),
                    child: FittedBox(
                      child: !post.participating
                          ? Text(
                              "JOIN",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "LEAVE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
