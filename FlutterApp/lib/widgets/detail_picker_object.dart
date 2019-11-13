import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DetailPicker extends StatefulWidget {
  final title;
  final initialValue;
  final minValue;
  final maxValue;

  DetailPicker(this.title, this.initialValue, this.minValue, this.maxValue);

  @override
  _DetailPickerState createState() => _DetailPickerState();
}

class _DetailPickerState extends State<DetailPicker> {
  int _value;
  bool showMemberPicker = false;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

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
