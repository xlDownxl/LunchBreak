import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import '../design/balloon_new_icons.dart';
import '../widgets/detail_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import '../widgets/title_picture_widget.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = "/new_post";

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  bool _favorite = false;

  var _form = GlobalKey();
  int _value = 5;
  bool showMemberPicker = false;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Add Event"),
      actions: <Widget>[],
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: deviceHeight,
        child: Column(
          children: <Widget>[
            Container(
              height: deviceHeight * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: deviceHeight * 0.3,
                      //fit: FlexFit.tight,
                      child: TitlePictureWidget(),
                    ),
                    Container(
                      height: deviceHeight * 0.2,
                      padding: EdgeInsets.only(bottom: 20),
                      //constraints: BoxConstraints.expand(),
                      child: Bubble(
                        margin: BubbleEdges.only(top: 14),
                        //nipOffset: 50,
                        nipHeight: 30,
                        nipWidth: 10,
                        //alignment: Alignment.topLeft,
                        nip: BubbleNip.leftTop,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter a Description",
                          ),
                          maxLines: 5,
                        ),
                      ),
                    ),
                    DetailPicker(),
                    DetailPicker(),
                  ],
                ),
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
                          "Cancel",
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
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 1),
                      //shape: CircleBorder(side: BorderSide(style: BorderStyle.solid)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.only(right: 4),
                              child: FittedBox(
                                child: Text(
                                  "Create",
                                  style: TextStyle(fontSize: 30),
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Icon(BalloonNew.balloonicon),
                            fit: FlexFit.loose,
                          ),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: Text(
                                    "Created the Event"), // TODO Snackbar saying "send invitations" as a link
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
      ),
    );
  }
}
