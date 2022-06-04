import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';

class NotificationDialog extends StatelessWidget {
  final String iconName;
  final String content;

  NotificationDialog({
    this.iconName,
    this.content
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: EdgeInsets.symmetric(vertical: 20.0),
      content: Container(
        width: 260.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgImage(
                svgName: this.iconName,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Text(
                  this.content,
                  textAlign: TextAlign.center,
                  style: kDefaultTextStyle.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context, String iconName, String content) {
    showDialog(
      context: context,
      builder: (context) => NotificationDialog(iconName: iconName, content: content),
      barrierDismissible: true,
    );
  }
}
