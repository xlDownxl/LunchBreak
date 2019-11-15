import 'package:flutter/material.dart';
import 'package:FST.LunchApp/widgets/add_post_screen_widgets/detail_picker_number.dart';
import 'package:FST.LunchApp/widgets/add_post_screen_widgets/language_picker.dart';
import '../../models/board_post.dart';
import 'package:provider/provider.dart';

class AddScreenInformationPicker extends StatelessWidget {
  BoardPost newPost;
  AddScreenInformationPicker(this.newPost);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            DetailPickerNumber("Member Number", 5, 1, 100, newPost),
            LanguagePicker(newPost),
          ],
        ),
      ),
    );
  }
}
