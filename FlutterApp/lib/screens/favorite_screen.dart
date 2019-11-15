import 'package:flutter/material.dart';
import 'package:FST.LunchApp/widgets/board_post_widgets/board_post_grid_element.dart';
import '../models/board_posts.dart';
import '../models/board_post.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  final deviceHeight;

  FavoriteScreen(this.deviceHeight);

  @override
  Widget build(BuildContext context) {
    //final List<BoardPost> postList = [BoardPost(), BoardPost(), BoardPost()];

    List<BoardPost> postList = Provider.of<BoardPosts>(context).favorites();

    return Container(
      height: deviceHeight,
      child: GridView.builder(
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
      ),
    );
  }
}
