import 'package:flutter/material.dart';
import '../models/board_post.dart';
import 'package:FST.LunchApp/widgets/board_post_widgets/board_post_grid_element.dart';
import '../models/board_posts.dart';

import 'package:provider/provider.dart';

class TodayPostsScreen extends StatelessWidget {
  final deviceHeight;

  TodayPostsScreen(this.deviceHeight);

  @override
  Widget build(BuildContext context) {
    //final List<BoardPost> postList = [BoardPost(), BoardPost(), BoardPost()];

    List<BoardPost> postList =
        Provider.of<BoardPosts>(context).getDate(DateTime.now());

    return Container(
      height: deviceHeight,
      child: postList.length > 0
          ? GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: postList.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                child: BoardPostGridElement(),
                value: postList[i],
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            )
          : Center(
              child: Text("No Events today"),
            ),
    );
  }
}
