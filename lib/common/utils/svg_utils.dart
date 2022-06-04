import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final String svgName;
  final Function onTap;
  final double size;
  final Color color;

  SvgImage({@required this.svgName, this.onTap, this.size, this.color});

  _icon() {
    return SvgPicture.asset(
      'assets/icons/$svgName.svg',
      semanticsLabel: svgName,
      width: size,
      height: size,
    );
  }

  _iconWithColor() {
    return SvgPicture.asset(
      'assets/icons/$svgName.svg',
      semanticsLabel: svgName,
      color: color,
      width: size,
      height: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return (onTap != null)
        ? InkWell(
            onTap: () {
              onTap();
            },
            child: color != null ? _iconWithColor() : _icon(),
          )
        : color != null
            ? _iconWithColor()
            : _icon();
  }
}
