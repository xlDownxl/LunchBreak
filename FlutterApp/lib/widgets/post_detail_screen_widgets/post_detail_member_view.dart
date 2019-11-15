import 'package:flutter/material.dart';
import 'participant_avatar.dart';

class PostDetailMemberView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "People in this Event",
          style: TextStyle(
            //fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(
          height: 5,
          color: Colors.black,
        ),
        Flexible(
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(bottom: 20),
            children: <Widget>[
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
              SizedBox(
                width: 5,
              ),
              ParticipantAvatar(),
            ],
          ),
        ),
      ],
    );
  }
}
