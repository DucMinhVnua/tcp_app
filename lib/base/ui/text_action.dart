import 'package:flutter/material.dart';

class TextAction extends StatelessWidget {
  void Function() onTap;
  String title;
  Color color;
  double fontSize = 12;

  TextAction({@required this.onTap, @required this.title, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Text(title, style: TextStyle(color: color, fontSize: fontSize)),
    );
  }
}
