import 'package:flutter/material.dart';

class TagLabelWidget extends StatelessWidget {

  String text = "";

  Color textColor = Colors.black26;

  Color bgColor = Colors.white;

  Color borderColor = Colors.green;

  double fontSize = 12;

  TagLabelWidget({@required this.text, this.textColor, this.bgColor, this.borderColor, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
        child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize))
    );
  }
}
