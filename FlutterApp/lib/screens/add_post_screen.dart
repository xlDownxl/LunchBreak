import 'package:flutter/material.dart';
import '../widgets/add_post_screen_widgets/add_screen_title_picture_widget.dart';
import '../widgets/add_post_screen_widgets/add_screen_bottom_bar.dart';
import '../models/board_post.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/board_posts.dart';
import '../widgets/google_maps.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = "/new_post";

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  var _form = GlobalKey<FormState>();
  bool showMemberPicker = false;
  var posts;
  BoardPost newPost;
  bool init = true;
  bool _editMode =
      false; //TODO Set all initial values to newPost.value + set all values to "" isntead of null in constructor

  @override
  void didChangeDependencies() {
    if (init) {
      posts = Provider.of<BoardPosts>(context);
      var postId = ModalRoute.of(context).settings.arguments;
      if (postId != null) {
        _editMode = true;
        newPost = Provider.of<BoardPosts>(context).findById(postId);
      } else {
        _editMode = false;
        newPost = BoardPost();
        newPost.owner = Provider.of<User>(context).id;
      }
      init = false;
    }
    super.didChangeDependencies();
  }

  void createEvent() {
    if (_form.currentState.validate()) {
      _form.currentState.save();

      if (newPost.imageUrl == null) {
        //TODO show error that no image selected
        return;
      } else if (newPost.date == null) {
        //TODO show error that no Date selected
        return;
      } else {
        posts.createPost(newPost, Provider.of<User>(context).id);
        Navigator.pop(context, {"created": true, "postId": newPost.id});
      }
    } else {}
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

    return ChangeNotifierProvider.value(
      value: newPost,
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Container(
              height: deviceHeight,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    height: deviceHeight * 0.5,
                    //fit: FlexFit.tight,
                    child: TitlePictureWidget(),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: GoogleMaps(),
                    height: deviceHeight * 0.35,
                  ),
                  //color: Theme.of(context).primaryColor,
                  /*padding: EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                          child: Text(
                        "Map coming Soon!",
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    height: deviceHeight * 0.35,
                  ),*/
                  Container(
                    //color: Theme.of(context).primaryColor,
                    height: deviceHeight * 0.1,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border(
                            top: BorderSide(
                                color: Theme.of(context).accentColor))),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: AddScreenBottomBar(_editMode, createEvent),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
