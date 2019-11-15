import 'package:flutter/material.dart';
import '../../screens/post_detail_screen.dart';

class GridItemBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          PostDetailScreen.routeName,
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
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Text("Joined the Event"),
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
