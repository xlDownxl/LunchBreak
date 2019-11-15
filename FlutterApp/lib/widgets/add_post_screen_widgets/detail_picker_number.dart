import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import '../../models/board_post.dart';

class DetailPickerNumber extends StatefulWidget {
  final title;

  final minValue;
  final maxValue;
  var newPost;

  DetailPickerNumber(this.title, this.minValue, this.maxValue, this.newPost);

  @override
  _DetailPickerNumberState createState() => _DetailPickerNumberState();
}

class _DetailPickerNumberState extends State<DetailPickerNumber> {
  int _value;
  bool showMemberPicker = false;

  @override
  void initState() {
    _value = widget.newPost.memberLimit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.newPost.memberLimit = _value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              showMemberPicker = !showMemberPicker;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 18, bottom: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: SizedBox(),
                ),
                Flexible(
                  child: Text(_value.toString()),
                ),
              ],
            ),
          ),
        ),
        showMemberPicker
            ? Container(
                child: NumberPicker.integer(
                    initialValue: _value,
                    minValue: widget.minValue,
                    maxValue: widget.maxValue,
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue;
                        widget.newPost.memberLimit = _value;
                      });
                    }),
              )
            : Container(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
