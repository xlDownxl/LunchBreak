import 'package:flutter/material.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';

class PostDetailText extends StatelessWidget {
  //final post;
  PostDetailText();

  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);

    return Container(
      padding: EdgeInsets.only(left: 14, bottom: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FittedBox(
            child: Text(
              post.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          /* Divider(
                                thickness: 2,
                                color: Colors.black,
                                height: 10,
                              ),*/
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                child: Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  post.location,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    //decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                child: Text(
                  "Fee",
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  post.fee.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    //decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
