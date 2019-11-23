import 'package:flutter/material.dart';
import '../models/board_post.dart';
import 'package:FST.LunchApp/widgets/board_post_widgets/board_post_grid_element.dart';
import '../models/board_posts.dart';
import '../models/board_post.dart';
import 'package:provider/provider.dart';

class AllPostsScreen extends StatefulWidget {
  final deviceHeight;

  AllPostsScreen(this.deviceHeight);

  @override
  _AllPostsScreenState createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  @override
  Widget build(BuildContext context) {
    //final List<BoardPost> postList = [BoardPost(), BoardPost(), BoardPost()];
    var currentDate = DateTime.now();
    List<List<BoardPost>> postLists = [];

    for (var i = 0; i < 3; i++) {
      postLists.add(Provider.of<BoardPosts>(context).getDate(currentDate));
      currentDate = currentDate.add(Duration(days: 1));
    }
    //postList = Provider.of<BoardPosts>(context).getDate(currentDate);

    return Container(
      padding: const EdgeInsets.all(10.0),
      height: widget.deviceHeight,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  child: BoardPostGridElement(),
                  value: postLists[0][index],
                );
              },
              childCount: postLists[0].length,
            ),
          ),
          SliverList(
            key: UniqueKey(),
            delegate: SliverChildListDelegate(
              [
                Divider(
                  thickness: 3,
                  color: Colors.black,
                )
              ],
            ),
          ),
          SliverGrid(
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  child: BoardPostGridElement(),
                  value: postLists[1][index],
                );
              },
              childCount: postLists[1].length,
            ),
          ),
          SliverList(
            key: UniqueKey(),
            delegate: SliverChildListDelegate(
              [
                Divider(
                  thickness: 3,
                  color: Colors.black,
                )
              ],
            ),
          ),
          SliverGrid(
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  child: BoardPostGridElement(),
                  value: postLists[2][index],
                );
              },
              childCount: postLists[2].length,
            ),
          ),
          SliverList(
            key: UniqueKey(),
            delegate: SliverChildListDelegate(
              [
                Divider(
                  thickness: 3,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
