import 'package:flutter/material.dart';
import '../screens/post_detail_screen.dart';

class BoardPostGridElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              PostDetailScreen.routeName,
            );
            //arguments: product.id,);
            print("getapt");
          },
          child: Container(
            color: Theme.of(context).primaryColor,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Text("gridtilebar"),
          title: Text(
            "title",
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      title: Text("Joined the Event"),
                    );
                  });
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
