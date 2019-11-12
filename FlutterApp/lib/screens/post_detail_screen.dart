import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import '../widgets/participant_avatar.dart';

import '../design/balloon_new_icons.dart';

class PostDetailScreen extends StatefulWidget {
  static const routeName = "/post_detail";

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Post Details"),
      actions: <Widget>[
        IconButton(
          icon: _favorite ? Icon(Icons.star) : Icon(Icons.star_border),
          onPressed: () {
            setState(() {
              _favorite = !_favorite;
            });
          },
        ),
      ],
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    //TODO think about showing owner

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: deviceHeight * 0.9,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  //fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://cdn.vox-cdn.com/thumbor/J1ap801pIkP2IehiUyTPFgxKljc=/0x260:1440x1440/1200x800/filters:focal(632x830:862x1060)/cdn.vox-cdn.com/uploads/chorus_image/image/63960957/BK_ImpossibleWhopper_Post1.0.jpg")))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 14, bottom: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  "English Lunch",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              /* Divider(
                                thickness: 2,
                                color: Colors.black,
                                height: 10,
                              ),*/
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FittedBox(
                                    child: Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Room 3000",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        //decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FittedBox(
                                    child: Text(
                                      "Fee",
                                      style: TextStyle(
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "100 Yen",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        //decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*  Divider(
                  height: 1,
                  //thickness: 1,
                  color: Colors.black,
                ), */
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    constraints: BoxConstraints.expand(),
                    child: Bubble(
                      margin: BubbleEdges.only(top: 14),
                      //nipOffset: 50,
                      nipHeight: 30,
                      nipWidth: 10,
                      //alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text("Message"),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "People in this Event",
                        style: TextStyle(
                          //fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      Flexible(
                        child: ListView(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(bottom: 20),
                          children: <Widget>[
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                            SizedBox(
                              width: 5,
                            ),
                            ParticipantAvatar(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  //fit: FlexFit.loose,
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text("Items"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              //margin: EdgeInsets.all(20),
                              width: constraints.maxWidth * 0.5,
                              color: Colors.grey,
                              height: deviceHeight * 0.3,
                              child: Text("map"),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            height: deviceHeight * 0.1,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
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
            ),
          ),
        ],
      ),
    );
  }
}
