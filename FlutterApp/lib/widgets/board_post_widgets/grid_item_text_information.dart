import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';

class GridItemTextInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);

    return Container(
      padding: EdgeInsets.only(left: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  //fit: BoxFit.fill,
                  child: FittedBox(
                    child: Text(
                      post.location,
                      //post.location,
                      style: TextStyle(
                        color: Color(0xff707070),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    child: Text(
                      post.fee,
                      style: TextStyle(
                        color: Color(0xff707070),
                      ),
                    ),
                  ),
                  //fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    "More",
                    style: TextStyle(
                      color: Color(0xff707070),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(
                    Icons.arrow_right,
                    color: Color(0xff707070),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
