import 'package:flutter/material.dart';

const links = [
  "assets/images/pic1.jpeg",
  "assets/images/pic2.jpeg",
  "assets/images/pic3.jpeg",
  "assets/images/pic4.jpeg",
  "assets/images/pic5.png",
  "assets/images/pic6.jpeg",
  "assets/images/pic7.jpeg",
  "assets/images/pic8.jpeg",
  "assets/images/pic9.jpeg",
];

class PictureChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFFF1DE),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: GridView(
        key: UniqueKey(),
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: <Widget>[
          ...links.map((link) {
            return Container(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, link);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    link,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
