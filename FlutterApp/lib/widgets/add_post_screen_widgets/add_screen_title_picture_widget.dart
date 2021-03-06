import 'package:flutter/material.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';
import 'package:FST.LunchApp/design/meal_icons_icons.dart';
import 'add_screen_description.dart';
import 'package:intl/intl.dart';
import 'picture_choice.dart';

class TitlePictureWidget extends StatefulWidget {
  @override
  _TitlePictureWidgetState createState() => _TitlePictureWidgetState();
}

class _TitlePictureWidgetState extends State<TitlePictureWidget> {
  DateTime _selectedDate;
  var init = true;
  var _selectedFee;
  var _feeColor;
  var _calendarFocus = false;
  var _calendarIconFocus = false;
  var image;

  var titleFocus;
  var capactiyFocus;
  var locationFocus;
  var descriptionFocus;

  @override
  void initState() {
    titleFocus = FocusNode();
    capactiyFocus = FocusNode();
    locationFocus = FocusNode();
    descriptionFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    capactiyFocus.dispose();
    locationFocus.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }

  void presentDatePicker(newPost) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(
          days: 10,
        ),
      ),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedData;
        _feeColor = Theme.of(context).primaryColor;
        _calendarFocus = false;
      });
      newPost.date = _selectedDate;
    });
  }

  @override
  void didChangeDependencies() {
    if (init) {
      _feeColor = Theme.of(context).accentColor;
      init = false;
    }
    super.didChangeDependencies();
  }

  void _choosePicture(BuildContext ctx, newPost) async {
    var imageUrl = await showModalBottomSheet(
      context: ctx,
      // backgroundColor: Color(0xffFFF1DE),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: Colors.black, width: 2, style: BorderStyle.solid),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      builder: (_) {
        return PictureChoice();
      },
    );
    setState(() {
      image = imageUrl;
      newPost.imageUrl = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var newPost = Provider.of<BoardPost>(context);

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () => _choosePicture(context, newPost),
                    child: image != null
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(image),
                                ),
                              ),
                            ),
                          )
                        : Icon(
                            MealIcons.aggga,
                            color: Colors.grey,
                            size: 128,
                          ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: AddScreenDescription(descriptionFocus),
                    padding: EdgeInsets.only(top: 10),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 14, bottom: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Event Title",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      focusNode: titleFocus,
                      validator: (val) {
                        if (val.isNotEmpty) {
                          return null;
                        } else {
                          return "Please Enter a Title";
                        }
                      },
                      autofocus: true,
                      onFieldSubmitted: (val) {
                        setState(() {
                          _calendarFocus = true;
                          _calendarIconFocus = true;
                        });
                        titleFocus.unfocus();
                      },
                      style: TextStyle(color: Theme.of(context).accentColor),
                      textInputAction: TextInputAction.next,
                      onSaved: (val) {
                        newPost.title = val;
                      },
                      decoration: InputDecoration(
                        //errorText: "",
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(
                            width: 10,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 4,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: (_selectedDate == null)
                              ? Text(
                                  "When ?",
                                  style: TextStyle(
                                    color: _calendarFocus
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              : Text(
                                  DateFormat("MMM dd").format(_selectedDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          fit: FlexFit.tight,
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _calendarIconFocus = true;
                                _calendarFocus = true;
                                presentDatePicker(newPost);
                              });
                            },
                            child: Icon(
                              Icons.calendar_today,
                              size: 35,
                              color: _calendarIconFocus
                                  ? Theme.of(context).primaryColor
                                  : Colors.black,
                            ),
                          ),
                          fit: FlexFit.tight,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.blueGrey),
                          color: _feeColor),
                      child: Center(
                        child: DropdownButtonFormField(

                          onSaved: (val) {
                            newPost.fee = val;
                          },
                          validator: (val) {
                            if (val != null) {
                              return null;
                            } else {
                              return "Enter Fee";
                            }
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: "Choose Fee",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          items: ["0-500 Yen", "500-1000 Yen", "1000+ Yen"]
                              .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedFee = val;
                              _feeColor = Colors.white;
                              FocusScope.of(context).requestFocus(capactiyFocus);
                            });
                          },
                          value: _selectedFee,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "Capacity",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (val) {
                            FocusScope.of(context).requestFocus(locationFocus);
                          },
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                          textInputAction: TextInputAction.next,
                          onSaved: (val) {
                            newPost.memberLimit = int.parse(val);
                          },
                          validator: (val) {
                            if (val.isNotEmpty) {
                              try {
                                int.parse(val);
                                return null;
                              } on Exception catch (_) {
                                return "Not a Number";
                              }
                            } else {
                              return "Enter Capacity";
                            }
                          },
                          focusNode: capactiyFocus,
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            hintText: "00",
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                width: 10,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  width: 4,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      "Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      onFieldSubmitted: (val) {
                        FocusScope.of(context).requestFocus(descriptionFocus);
                      },
                      validator: (val) {
                        if (val.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter a Location";
                        }
                      },
                      style: TextStyle(color: Theme.of(context).accentColor),
                      textInputAction: TextInputAction.next,
                      onSaved: (val) {
                        newPost.location = val;
                      },
                      focusNode: locationFocus,
                      decoration: InputDecoration(
                        errorMaxLines: 2,
                        errorStyle: TextStyle(fontSize: 10),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(
                            width: 10,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 4,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
