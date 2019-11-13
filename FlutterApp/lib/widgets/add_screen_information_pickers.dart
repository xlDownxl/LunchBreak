import 'package:flutter/material.dart';
import '../widgets/detail_picker_number.dart';
import '../widgets/language_picker.dart';
import '../models/board_post.dart';
import 'package:provider/provider.dart';

class AddScreenInformationPicker extends StatelessWidget {
  final BoardPost newPost;
  AddScreenInformationPicker(this.newPost);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            DetailPickerNumber("Member Number", 5, 1, 100),
            LanguagePicker(),
          ],
        ),
      ),
    );
  }
}
