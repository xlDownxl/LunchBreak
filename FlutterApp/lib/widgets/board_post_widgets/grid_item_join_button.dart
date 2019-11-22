import 'package:flutter/material.dart';
import '../../screens/post_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';
import '../../models/user.dart';
import '../../design/balloon_new_icons.dart';

class GridItemJoinButton extends StatelessWidget {
  final postId;
  GridItemJoinButton(this.postId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          PostDetailScreen.routeName,
          arguments: postId,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.red)),
            color: Theme.of(context).primaryColor,
            elevation: 2,
            onPressed: () {},
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
                      padding: EdgeInsets.only(left: 2),
                      child: Text(
                        "JOIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
