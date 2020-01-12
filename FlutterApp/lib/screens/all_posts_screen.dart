import 'package:flutter/material.dart';
import 'package:FST.LunchApp/widgets/board_post_widgets/board_post_grid_element.dart';
import '../models/board_posts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AllPostsScreen extends StatefulWidget {
  final deviceHeight;

  AllPostsScreen(this.deviceHeight);

  @override
  _AllPostsScreenState createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  @override
  Widget build(BuildContext context) {
    var currentDate = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(10.0),
      height: widget.deviceHeight,
      child: ListView.separated(
        separatorBuilder: (ctx, index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  DateFormat.MMMMd().format(
                    currentDate.add(
                      Duration(
                        days: index,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Divider(
                  color: Theme.of(context).accentColor,
                  thickness: 2,
                  height: 5,
                ),
              ),
            ),
          ],
        ),
        itemCount: 4,
        itemBuilder: (ctx, index) => index == 0
            ? Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Today",
                            //"Mai 24",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Divider(
                            color: Theme.of(context).accentColor,
                            thickness: 2,
                            height: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            80, // Set as you want or you can remove it also.
                        maxHeight: double.infinity,
                      ),
                      child: Container(
                        child: GridView(
                          primary: false,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          children: <Widget>[
                            ...Provider.of<BoardPosts>(context)
                                .getDate(
                                    DateTime.now().add(Duration(days: index)))
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
                ],
              )
            : Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 80, // Set as you want or you can remove it also.
                    maxHeight: double.infinity,
                  ),
                  child: Container(
                    child: GridView(
                      primary: false,
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
