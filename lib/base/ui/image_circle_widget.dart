import 'package:flutter/material.dart';

class ImageAssetCircleWidget extends StatelessWidget {
  String image;
  Color color;
  double height, width;

  ImageAssetCircleWidget({this.image, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        color: color ?? Colors.white,
      ),
      child: Image.asset(
        image,
        height: height ?? 24,
        width: width ?? 24,
      ),
    );
  }
}
