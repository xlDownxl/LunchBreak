import 'package:flutter/material.dart';
import '../../screens/post_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';
import '../../models/user.dart';

class GridItemBottomBar extends StatelessWidget {
  final postId;
  GridItemBottomBar(this.postId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          PostDetailScreen.routeName, arguments: postId, //TODO pass post ID !!
        );
        //arguments: product.id,);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 8, top: 3, right: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                height: 300,
                constraints: BoxConstraints.expand(),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "More",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 200,
                child: FlatButton(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      "Join",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  onPressed: () {
                    var post = Provider.of<BoardPost>(context);
                    post.toggleParticipating(Provider.of<User>(context).id);
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return SimpleDialog(
                            title: Text("Joined ${post.title}!"),
                          );
                        });
                  },
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
