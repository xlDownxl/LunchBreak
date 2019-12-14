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
import 'package:path/path.dart' as Path;
import 'package:firebase_database/firebase_database.dart';

class DrawerScreen extends StatefulWidget {
  static const routeName = "/drawer";

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with TickerProviderStateMixin {
  KFDrawerController _drawerController;
  File _image;
  String _uploadedFileURL;
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: KFDrawer(
//        borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
            menuPadding: EdgeInsets.all(10.0),
//        scrollable: true,
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
                                 _loadingImage? CircularProgressIndicator():Container(),
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
                                          "username",
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
                Provider.of<User>(context, listen: false)
                    .resetUser()
                    .then((val) {
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                });
              },
            ),
            decoration: BoxDecoration(

                /*gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(255, 255, 255, 1.0),
                  Color.fromRGBO(44, 72, 171, 1.0)
                ],
                tileMode: TileMode.repeated,
              ),*/

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
