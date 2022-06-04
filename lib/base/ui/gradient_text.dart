import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
    this.fontSize = 32,
    this.fontWeight = FontWeight.bold,
  });

  final FontWeight fontWeight;
  final String text;
  final double fontSize;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
