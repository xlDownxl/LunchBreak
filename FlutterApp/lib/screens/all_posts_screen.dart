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

    /* for (var i = 0; i < 3; i++) {
      postLists.add(Provider.of<BoardPosts>(context).getDate(currentDate));
      currentDate = currentDate.add(Duration(days: 1));
    }*/
    //var postList = Provider.of<BoardPosts>(context).items();

    return Container(
      padding: const EdgeInsets.all(10.0),
      height: widget.deviceHeight,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: 4,
        itemBuilder: (ctx, index) => Container(
          child: IgnorePointer(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 80, // Set as you want or you can remove it also.
                maxHeight: double.infinity,
              ),
              child: Container(
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: <Widget>[
                    ...Provider.of<BoardPosts>(context)
                        .getDate(DateTime.now().add(Duration(days: index)))
                        .map((post) => ChangeNotifierProvider.value(
                              child: BoardPostGridElement(),
                              value: post,
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      /*CustomScrollView(
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
      ),*/
    );
  }
}
