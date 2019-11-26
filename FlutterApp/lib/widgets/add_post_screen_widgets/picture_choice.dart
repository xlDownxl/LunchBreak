import 'package:flutter/material.dart';

const links = [
  "https://www.gannett-cdn.com/presto/2019/08/01/USAT/94f76657-241d-4eff-b654-9ad772fdd23f-impossiblewhopper.jpg?auto=webp&crop=705,397,x1,y205&format=pjpg&width=1200",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/190208-delish-ramen-horizontal-093-1550096715.jpg?crop=1xw:0.9995002498750624xh;center,top&resize=480:*",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/190208-delish-ramen-horizontal-093-1550096715.jpg?crop=1xw:0.9995002498750624xh;center,top&resize=480:*",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/190208-delish-ramen-horizontal-093-1550096715.jpg?crop=1xw:0.9995002498750624xh;center,top&resize=480:*",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/190208-delish-ramen-horizontal-093-1550096715.jpg?crop=1xw:0.9995002498750624xh;center,top&resize=480:*",
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
                  child: Image.network(
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
