import 'package:flutter/material.dart';

class GoogleMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Text(
              "Map coming soon!",
            ),
          ),
        );
      },
    );
  }
}
