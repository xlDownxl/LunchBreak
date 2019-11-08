import 'package:flutter/material.dart';
import '../screens/post_detail_screen.dart';

class BoardPostGridElement extends StatefulWidget {
  @override
  _BoardPostGridElementState createState() => _BoardPostGridElementState();
}

class _BoardPostGridElementState extends State<BoardPostGridElement> {
  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(PostDetailScreen.routeName);
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
                              Container(
                                child: FittedBox(
                                  child: GestureDetector(
                                    child: favorite
                                        ? Icon(Icons.star)
                                        : Icon(Icons.star_border),
                                    onTap: () {
                                      setState(() {
                                        favorite = !favorite;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  "https://cdn.vox-cdn.com/thumbor/J1ap801pIkP2IehiUyTPFgxKljc=/0x260:1440x1440/1200x800/filters:focal(632x830:862x1060)/cdn.vox-cdn.com/uploads/chorus_image/image/63960957/BK_ImpossibleWhopper_Post1.0.jpg")))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(left: 3),
                            //margin: EdgeInsets.only(bottom: 5),
                            constraints: BoxConstraints.expand(),
                            child: Card(
                              color: Theme.of(context).accentColor,
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 1, right: 3, left: 3, bottom: 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(
                                        "English Lunch",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Colors.black,
                                      height: 10,
                                    ),
                                    Text(
                                      "Where:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    FittedBox(
                                      child: Text("Burger King"),
                                      fit: BoxFit.fill,
                                    ),
                                    Divider(
                                      height: 5,
                                    ),
                                    Text(
                                      "Fee",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("500 Yen")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        PostDetailScreen.routeName,
                      );
                      //arguments: product.id,);
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 8, top: 3, right: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20))),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 300,
                              constraints: BoxConstraints.expand(),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "More",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: 200,
                              child: FlatButton(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    "Join",
                                    style: TextStyle(fontSize: 30),
                                  ),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
