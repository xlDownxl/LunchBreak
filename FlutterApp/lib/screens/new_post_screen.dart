import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_picker/flutter_picker.dart';
import '../design/balloon_new_icons.dart';
import '../widgets/detail_picker.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = "/new_post";

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  bool _favorite = false;
  bool _uploadedPicture = false;
  var _form = GlobalKey();

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    //fit: FlexFit.tight,
                    child: Form(
                      key: _form,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _uploadedPicture = !_uploadedPicture;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: !_uploadedPicture
                                    ? Border.all(
                                        width: 1,
                                        color: Colors.black,
                                        style: BorderStyle.solid)
                                    : null,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: _uploadedPicture
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            "https://cdn.vox-cdn.com/thumbor/J1ap801pIkP2IehiUyTPFgxKljc=/0x260:1440x1440/1200x800/filters:focal(632x830:862x1060)/cdn.vox-cdn.com/uploads/chorus_image/image/63960957/BK_ImpossibleWhopper_Post1.0.jpg",
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text("Tap here to add a picture!"),
                                    ),
                            ),
                          )),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 14, bottom: 20, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FittedBox(
                                        child: Text(
                                          "Title",
                                          style: TextStyle(
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                      TextFormField(),
                                    ],
                                  ),
                                  /* Divider(
                                    thickness: 2,
                                    color: Colors.black,
                                    height: 10,
                                  ),*/
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FittedBox(
                                        child: Text(
                                          "Location",
                                          style: TextStyle(
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                      TextFormField(),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FittedBox(
                                        child: Text(
                                          "Fee",
                                          style: TextStyle(
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                      TextFormField(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*  Divider(
                    height: 1,
                    //thickness: 1,
                    color: Colors.black,
                  ), */
                  Container(
                    height: 200,
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
                  ...DetailPicker().lol(context),
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
