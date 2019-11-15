import 'package:flutter/material.dart';
import '../../design/balloon_new_icons.dart';

class PostDetailBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: Row(
            children: <Widget>[
              Icon(Icons.arrow_back),
              Text(
                "Back",
                style: TextStyle(fontSize: 24),
              ),
            ],
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
                FittedBox(
                  child: Text(
                    "Join",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(BalloonNew.balloonicon),
              ],
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
      ],
    );
  }
}
