import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/utils/palette.dart';

class SaveButton extends StatelessWidget {
  static const button_type_default = 0;
  static const button_type_cancel = 1;
  static const button_type_round = 3;
  GestureTapCallback onTap;
  String title;
  EdgeInsets margin;
  var color;
  double borderRadius;
  var textColor;
  bool isDontUpperCaseTitle = false;
  int buttonType = button_type_default;
  bool isWrapContent;

  SaveButton(
      {this.onTap,
      this.title = "Lưu",
      this.margin,
      this.color,
      this.textColor,
      this.isWrapContent: false,
      this.borderRadius,
      this.isDontUpperCaseTitle = false,
      this.buttonType: button_type_default}) {
    // if (textColor == null) {
    //   if (buttonType == button_type_default)
    //     textColor = Colors.white;
    //   else if (buttonType == button_type_cancel)
    //     textColor = Palette.color222222;
    //   else if (buttonType == button_type_round) {
    //     textColor = Palette.textButtonRound;
    //   }
    // }
    // if (color == null) {
    //   if (buttonType == button_type_default)
    //     color = Palette.blueButtonColor;
    //   else if (buttonType == button_type_cancel)
    //     color = Colors.transparent;
    //   else if (buttonType == button_type_round) {
    //     color = Palette.backgroundButtonRound;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    borderRadius =
        borderRadius == null ?? buttonType == button_type_round ? 8 : 200;
    return InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: isWrapContent ? null : 1,
              child: Container(
                  alignment: Alignment.center,
                  height: 48,
                  padding:
                      EdgeInsets.symmetric(horizontal: isWrapContent ? 24 : 0),
                  margin: margin ?? EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: color ?? "0094DC".toColor(),
                      borderRadius:
                          BorderRadius.all(Radius.circular(borderRadius))),
                  child: Text(
                      isDontUpperCaseTitle ? title : title.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textColor ?? Colors.white))),
            ),
          ],
        ));
  }
}
