import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DetailPicker extends StatefulWidget {
  @override
  _DetailPickerState createState() => _DetailPickerState();
}

class _DetailPickerState extends State<DetailPicker> {
  int _value = 5;
  var showMemberPicker = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: deviceHeight * 0.4,
      child: Column(
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
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "aktiv",
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
                      minValue: 1,
                      maxValue: 100,
                      onChanged: (newValue) {
                        setState(() {
                          _value = newValue;
                        });
                      }),
                )
              : Container(),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
