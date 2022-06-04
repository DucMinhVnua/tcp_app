
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/styles.dart';

class CustomOneButtonDialog extends StatefulWidget {
  final BuildContext context;
  final String title;
  final Widget content;
  final String txtBtn;
  final Function onTapBtn;

  CustomOneButtonDialog({
    this.context,
    this.title,
    this.content,
    this.txtBtn,
    this.onTapBtn,
  });

  @override
  State<StatefulWidget> createState() => _CustomOneButtonDialog();
}

class _CustomOneButtonDialog extends State<CustomOneButtonDialog>{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      content: Container(
        width: 335.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: kMediumBlackTextStyle,
              ),
            ),
            Divider(
              thickness: 1.0,
              color: kGrey1,
            ),
            widget.content
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      widget.txtBtn,
                      style: kDefaultTextStyle.copyWith(
                          color: Colors.white
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(kBlue1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: kBlue1)
                          )
                      )
                  ),
                  onPressed: widget.onTapBtn,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

}

