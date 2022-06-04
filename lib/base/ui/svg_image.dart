import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SVGImage extends StatelessWidget {
  String svgName;
  Function onTap;
  double size;

  SVGImage({@required this.svgName, this.onTap, this.size});

  _icon() {
    return SvgPicture.asset(
      'assets/svgs/$svgName.svg',
      semanticsLabel: svgName,
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
            child: _icon(),
          )
        : _icon();
  }
}
