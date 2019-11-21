import 'package:flutter/material.dart';
import '../../screens/post_detail_screen.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';

import 'grid_item_bottom_bar.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(PostDetailScreen.routeName, arguments: post.id);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.8,
                  child: Container(
                    padding: EdgeInsets.all(7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GridItemFavoriteIcon(),
                              Expanded(
                                child: GridItemImage(),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: GridItemTextInformation(),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.2,
                  child: GridItemBottomBar(post.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
