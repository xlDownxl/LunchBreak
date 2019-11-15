import 'package:flutter/material.dart';

class ParticipantAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(70),
        child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/4/45/Bob_Mensch.jpg"),
      ),
    );
  }
}
