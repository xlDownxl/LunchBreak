import 'package:flutter/material.dart';

class DetailSetting extends StatefulWidget {
  final String title;
  final List<String> options;
  final String defaultValue;

  DetailSetting(this.title, this.options, this.defaultValue);

  @override
  _DetailSettingState createState() => _DetailSettingState();
}

class _DetailSettingState extends State<DetailSetting> {
  var _currentValue;
  @override
  void initState() {
    _currentValue = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: SizedBox(),
        ),
        Flexible(
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return DropdownButton(
                /* hint: Container(
                  width: constraints.maxWidth - 24, //24 = arrow size
                  child: FittedBox(
                    child: const Text(""),
                    fit: BoxFit.fill,
                  ),
                ), */
                value: _currentValue,
                items: widget.options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _currentValue = newValue;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
