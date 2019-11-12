import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';

class DetailSettingPicker extends StatefulWidget {
  DetailSettingPicker();

  @override
  _DetailSettingPickerState createState() => _DetailSettingPickerState();
}

class _DetailSettingPickerState extends State<DetailSettingPicker> {
  int _value = 5;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                "lol",
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
    );
  }
}
