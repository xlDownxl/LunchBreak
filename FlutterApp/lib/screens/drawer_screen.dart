import 'package:flutter/material.dart';

import 'board_screen.dart';
import '../widgets/kf_drawer.dart';
import '../utils/class_builder.dart';
import 'friend_list_screen.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'dart:math';
import 'feed_screen.dart';
import 'settings_screen.dart';
import 'package:FST.LunchApp/design/socicon_icons.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class DrawerScreen extends StatefulWidget {
  static const routeName = "/drawer";
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with TickerProviderStateMixin {
  KFDrawerController _drawerController;
  File _image;
  bool _loadingImage=false;
  var user;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      _image=image;
      uploadFile();
    });
  }

  Future uploadFile() async {
    setState(() {
      _loadingImage=true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref().child("User_Data").child(Provider.of<User>(context,listen: false).id)
        .child('profile_pic');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _loadingImage=false;
        user.image = fileURL;
      });
    });
  }

  @override
  void initState() {

    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('BoardScreen'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            maxLines: 3,
          ),
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          page: BoardScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Friends',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          icon: Icon(Socicon.hearing, color: Colors.white),
          page: FriendList(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Feed',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          icon: Icon(Icons.calendar_today, color: Colors.white),
          page: FeedScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'SETTINGS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          page: Settings(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    user=Provider.of<User>(context);
    return  Container(
        decoration: BoxDecoration(
    ),
    child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: KFDrawer(
            menuPadding: EdgeInsets.all(10.0),
            controller: _drawerController,
            header: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Settings.routeName);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: LayoutBuilder(
                    builder: (_, constraints) => Container(
                      width: constraints.maxWidth * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              chooseFile();
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.5,
                              child: Stack(
                                children:[
                                  Center(
                                    child: LayoutBuilder(
                                    builder: (_, constraints) => user.image!=null?
                                     CircleAvatar(
                                      radius: min(constraints.maxHeight,  constraints.maxWidth)/2,

                                      backgroundImage:
                                                 NetworkImage(user.image),
                                      backgroundColor: Colors.transparent,
                                       ):Container(color: Colors.amber,),

                                ),
                                  ),
                                 Center(child: _loadingImage? CircularProgressIndicator(
                                   backgroundColor: Theme.of(context).primaryColor,
                                 ):Container()),
                              ],
                              )
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.05,),
                          Container(
                            height: constraints.maxHeight * 0.45,
                            child: Consumer<User>(
                              builder: (_, user, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: FittedBox(
                                        child: Text(
                                          //user.username,
                                          user.username!=null?user.username:" ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Flexible(
                                      child: SizedBox(),
                                    ),
                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                          user.email,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              child: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            footer: KFDrawerItem(
              text: Text(
                'SIGN OUT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              icon: Icon(
                Icons.input,
                color: Colors.white,
              ),
              onPressed: () {
                user
                    .resetUser()
                    .then((val) {
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                });
              },
            ),
            decoration: BoxDecoration(
                ),
          ),
        ),
      ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar();
  }

  @override
  Size get preferredSize => Size.fromHeight(0);
}
