import 'package:flutter/cupertino.dart';
import 'package:workflow_manager/base/utils/common_function.dart';

class SharedSeparatorWidget extends StatelessWidget {
  Color backgroundColor;
  EdgeInsetsGeometry margin;
  double height;

  SharedSeparatorWidget(
      {Key key,
      Color backgroundColor,
      EdgeInsetsGeometry margin,
      this.height: 12})
      : super(key: key) {
    this.backgroundColor = backgroundColor ?? getColor("EFEFF5");
    this.margin = margin ?? EdgeInsets.symmetric(vertical: 12);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: backgroundColor,
      height: height,
    );
  }
}
