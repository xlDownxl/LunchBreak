import 'package:flutter/material.dart';

class PictureChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all()),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                "https://www.gannett-cdn.com/presto/2019/08/01/USAT/94f76657-241d-4eff-b654-9ad772fdd23f-impossiblewhopper.jpg?auto=webp&crop=705,397,x1,y205&format=pjpg&width=1200",
              );
            },
            child: ClipRRect(
              child: Image.network(
                "https://www.gannett-cdn.com/presto/2019/08/01/USAT/94f76657-241d-4eff-b654-9ad772fdd23f-impossiblewhopper.jpg?auto=webp&crop=705,397,x1,y205&format=pjpg&width=1200",
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all()),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context,
                  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/190208-delish-ramen-horizontal-093-1550096715.jpg?crop=1xw:0.9995002498750624xh;center,top&resize=480:*");
            },
            child: ClipRRect(
              child: Image.network(
                  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/190208-delish-ramen-horizontal-093-1550096715.jpg?crop=1xw:0.9995002498750624xh;center,top&resize=480:*"),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
