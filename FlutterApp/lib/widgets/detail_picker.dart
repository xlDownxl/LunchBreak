import 'package:flutter/material.dart';
import 'detail_setting.dart';
import 'detail_setting_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class DetailPicker {
  int _value = 5;
  bool showMemberPicker = false;

  List<Widget> lol(BuildContext context) {
    return [
      Container(
        height: 200,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showMemberPicker = !showMemberPicker;
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    "Membernumber",
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
      ),
      Divider(
        color: Colors.grey,
      ),
      showMemberPicker
          ? Expanded(
              child: Container(
                child: NumberPicker.integer(
                    initialValue: _value,
                    minValue: 1,
                    maxValue: 100,
                    onChanged: (newValue) {
                      _value = newValue;
                    }),
              ),
            )
          : Container(),
      showMemberPicker
          ? Divider(
              color: Colors.grey,
            )
          : Container(),
      //Expanded(
      // fit: FlexFit.tight,
      //child: DetailSettingPicker(),
      //),
    ];
  }
}
