import 'package:flutter/material.dart';

class ItemsAndMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text("Items"),
              ),
            ),
            Expanded(
              child: Container(
                //margin: EdgeInsets.all(20),
                width: constraints.maxWidth * 0.5,
                color: Colors.grey,
                //height: deviceHeight * 0.3,
                child: Text("map"),
              ),
            ),
          ],
        );
      },
    );
  }
}
