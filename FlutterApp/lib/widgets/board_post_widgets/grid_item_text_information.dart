import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';

class GridItemTextInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);

    return Container(
      padding: EdgeInsets.only(left: 3),
      //margin: EdgeInsets.only(bottom: 5),
      constraints: BoxConstraints.expand(),
      child: Card(
        color: Theme.of(context).accentColor,
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 1, right: 3, left: 3, bottom: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  post.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
                height: 10,
              ),
              Text(
                "Where:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              FittedBox(
                child: Text(post.location),
                fit: BoxFit.fill,
              ),
              Divider(
                height: 5,
              ),
              Text(
                "Fee",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(post.fee.toString())
            ],
          ),
        ),
      ),
    );
  }
}
