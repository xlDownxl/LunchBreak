import 'package:flutter/material.dart';

class ItemsAndMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          color: Theme.of(context).primaryColor,
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
