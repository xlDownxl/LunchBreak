import 'package:flutter/material.dart';
import '../widgets/add_post_screen_widgets/add_screen_title_picture_widget.dart';
import '../widgets/add_post_screen_widgets/add_screen_bottom_bar.dart';
import '../widgets/add_post_screen_widgets/add_screen_information_pickers.dart';
import '../widgets/add_post_screen_widgets/add_screen_description.dart';
import '../models/board_post.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = "/new_post";

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  var _form = GlobalKey<FormState>();
  bool showMemberPicker = false;

  BoardPost newPost;
  bool init = true;

  @override
  void didChangeDependencies() {
    if (init) {
      newPost = BoardPost(Provider.of<User>(context).id);
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Add Event"),
      actions: <Widget>[],
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    String ownerId = Provider.of<User>(context).id;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: deviceHeight,
          child: Column(
            children: <Widget>[
              Form(
                key: _form,
                child: Container(
                  height: deviceHeight * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15),
                          height: deviceHeight * 0.4,
                          //fit: FlexFit.tight,
                          child: TitlePictureWidget(newPost),
                        ),
                        Container(
                          height: deviceHeight * 0.2,
                          padding: EdgeInsets.only(bottom: 20),
                          //constraints: BoxConstraints.expand(),
                          child: AddScreenDescription(newPost),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.05,
                        ),
                        AddScreenInformationPicker(newPost),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                height: deviceHeight * 0.1,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AddScreenBottomBar(_form, newPost),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
