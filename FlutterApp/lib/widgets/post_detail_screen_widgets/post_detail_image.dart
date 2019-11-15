import 'package:flutter/material.dart';

class PostDetailImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://cdn.vox-cdn.com/thumbor/J1ap801pIkP2IehiUyTPFgxKljc=/0x260:1440x1440/1200x800/filters:focal(632x830:862x1060)/cdn.vox-cdn.com/uploads/chorus_image/image/63960957/BK_ImpossibleWhopper_Post1.0.jpg")))),
    );
  }
}
