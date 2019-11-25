import 'package:flutter/material.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PostDetailText extends StatelessWidget {
  //final post;
  PostDetailText();

  @override
  Widget build(BuildContext context) {
    var post = Provider.of<BoardPost>(context);

    const backgroundColor = Color(0xffFFF1DE);

    return Container(
      padding: EdgeInsets.only(left: 14, bottom: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: ShapeDecoration(
                color: backgroundColor,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.white),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              child: FittedBox(
                child: Text(
                  "Event Title",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: FittedBox(
              child: Text(
                "Burger event",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (ctx, constraints) => Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4),
                    width: constraints.maxWidth * 0.3,
                    decoration: ShapeDecoration(
                      color: backgroundColor,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    //margin: EdgeInsets.only(right: 10),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 22,
                          //backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    width: constraints.maxWidth * 0.7,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        DateFormat.MMMMd().format(
                          post.date,
                        ),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (ctx, constraints) => Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4),
                    width: constraints.maxWidth * 0.25,
                    decoration: ShapeDecoration(
                      color: backgroundColor,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    //margin: EdgeInsets.only(right: 10),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Fee",
                        style: TextStyle(
                          fontSize: 22,
                          //backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 14),
                    width: constraints.maxWidth * 0.75,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        post.fee,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (ctx, constraints) => Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4),
                    width: constraints.maxWidth * 0.5,
                    decoration: ShapeDecoration(
                      color: backgroundColor,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    //margin: EdgeInsets.only(right: 10),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Capacity",
                        style: TextStyle(
                          fontSize: 22,
                          //backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    width: constraints.maxWidth * 0.5,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        post.memberLimit.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: ShapeDecoration(
                color: backgroundColor,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.white),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              child: FittedBox(
                child: Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: FittedBox(
              child: Text(
                post.location,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
