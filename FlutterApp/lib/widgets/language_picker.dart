import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/board_post.dart';

class LanguagePicker extends StatefulWidget {
  @override
  _LanguagePickerState createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  var _val = "English";
  var options = ["English", "Japanese"];

  @override
  Widget build(BuildContext context) {
    var newPost = Provider.of<BoardPost>(context, listen: false);
    newPost.language = _val;
    return Container(
      padding: EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return DropdownButton(
            hint: Container(
              width: constraints.maxWidth - 24, //24 = arrow size
              child: FittedBox(
                child: const Text("Choose a Stocksymbol"),
                fit: BoxFit.fill,
              ),
            ),
            value: _val,
            items: options.map((String symbol) {
              return DropdownMenuItem<String>(
                value: symbol,
                child: Text(symbol),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _val = newValue;
                newPost.location = _val;
              });
            },
          );
        },
      ),
    );
    ;
  }
}