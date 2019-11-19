import 'package:flutter/material.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';

class TitlePictureWidget extends StatefulWidget {
  TitlePictureWidget();

  @override
  _TitlePictureWidgetState createState() => _TitlePictureWidgetState();
}

class _TitlePictureWidgetState extends State<TitlePictureWidget> {
  bool _uploadedPicture = false;

  @override
  Widget build(BuildContext context) {
    var newPost = Provider.of<BoardPost>(context);
    return Row(
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
                      width: 1, color: Colors.black, style: BorderStyle.solid)
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
          //TODO use constraints to size title, location and fee input
          child: Container(
            padding: EdgeInsets.only(left: 14, bottom: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      child: Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: newPost.title,
                      onSaved: (value) {
                        print(value);
                        newPost.title = value;
                      },
                    ),
                  ],
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
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: newPost.location,
                      onSaved: (value) {
                        print(value);
                        newPost.location = value;
                      },
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
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue:
                          newPost.fee == null ? "" : newPost.fee.toString(),
                      onSaved: (value) {
                        print(value);
                        newPost.fee = double.parse(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
