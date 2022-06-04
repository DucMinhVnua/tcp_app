import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/base/utils/common_function.dart';

class SharedStatusWidget extends StatelessWidget {
  Color backgroundColor;
  Color textColor;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;
  String text;
  GestureTapCallback onTap;

  Color getTextColor(int status) {
    switch (status) {
      case 0:
        return getColor('#222222'); // chưa xác định
      case 1:
        return getColor('#222222'); // nháp
      case 2:
      case 5:
        return getColor('#FFA90A'); //chờ duyệt
      case 3:
        return getColor('#FF2E1F'); // từ chôi -  không duyệt
      case 4:
        return getColor('#1D76C7'); // chờ xác định thay đổi
      case 6:
        return getColor('#20AC5F'); // đã duyệt
      default:
        return getColor('#222222'); // đặt bừa
    }
  }

  Color getBackgroundColor(int status) {
    switch (status) {
      case 0:
        return getColor('#F4F5F5'); // chưa xác định
      case 1:
        return getColor('#F4F5F5'); // nháp
      case 2:
      case 5:
        return getColor('#FFF8EB'); //chờ duyệt
      case 3:
        return getColor('#FFECEB'); // từ chôi -  không duyệt
      case 4:
        return getColor('#E3F2FB'); // chờ xác định thay đổi
      case 6:
        return getColor('#EEFCF4'); // đã duyệt
      default:
        return getColor('#F4F5F5'); // đặt bừa
    }
  }

  SharedStatusWidget(
      {Key key,
      this.backgroundColor = Colors.blue,
      this.textColor = Colors.black,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      this.text,
      this.margin,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(200))),
        padding: padding,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
