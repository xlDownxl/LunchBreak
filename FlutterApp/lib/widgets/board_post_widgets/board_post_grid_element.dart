import 'package:flutter/material.dart';
import '../../screens/post_detail_screen.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';

import 'grid_item_join_button.dart';
import 'grid_item_text_information.dart';
import 'grid_item_image.dart';
import 'grid_item_favorite_icon.dart';

class BoardPostGridElement extends StatefulWidget {
  @override
  _BoardPostGridElementState createState() => _BoardPostGridElementState();
}

class _BoardPostGridElementState extends State<BoardPostGridElement> {
  var post;

  @override
  Widget build(BuildContext context) {
    post = Provider.of<BoardPost>(context);
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFFF1DE),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      padding: EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(PostDetailScreen.routeName, arguments: post.id);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.18,
                  child: LayoutBuilder(
                    builder: (ctx, constraints) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: constraints.maxWidth * 0.2,
                          child: GridItemFavoriteIcon(),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: 3,
                            left: 1,
                            top: 2,
                          ),
                          child: FittedBox(
                            child: Text(
                              post.title,
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          width: constraints.maxWidth * 0.8,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.59,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: GridItemImage(),
                      ),
                      Flexible(
                        child: GridItemTextInformation(),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.23,
                  child: GridItemJoinButton(
                    post.id,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
