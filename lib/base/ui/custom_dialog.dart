import 'package:flutter/material.dart';

class CustomDialogWidget {
  BuildContext buildContext;
  Widget customWidget;
  bool isClickOutWidget = false;

  CustomDialogWidget(this.buildContext, this.customWidget,
      {this.isClickOutWidget});

  Future<void> show() {
    return showGeneralDialog(
      context: buildContext,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.black45,
          body: isClickOutWidget == null || !isClickOutWidget
              ? Center(
                  child: Wrap(
                    children: [customWidget],
                  ),
                )
              : InkWell(
                  onTap: () {
                    if (isClickOutWidget) Navigator.of(buildContext).pop();
                  },
                  child: Center(
                    child: Wrap(
                      children: [customWidget],
                    ),
                  ),
                ),
        );
      },
      barrierDismissible: false,
      barrierLabel:
          MaterialLocalizations.of(buildContext).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
