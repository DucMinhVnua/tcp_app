
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/common/constants.dart';

class CustomTwoButtonDialog extends StatefulWidget {
  final BuildContext context;
  final Widget title;
  final Widget content;
  final String txtNegativeBtn;
  final String txtPositiveBtn;
  final Function onTapNegativeBtn;
  final Function onTapPositiveBtn;
  final bool showTitleDivider;

  CustomTwoButtonDialog({
    this.context,
    this.title,
    this.content,
    this.txtPositiveBtn,
    this.onTapPositiveBtn,
    this.txtNegativeBtn,
    this.onTapNegativeBtn,
    this.showTitleDivider = true
  });


  @override
  State<StatefulWidget> createState() => _CustomTwoButtonDialog();
}

class _CustomTwoButtonDialog extends State<CustomTwoButtonDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      content: Container(
        width: 335.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.title,
              Visibility(
                visible: widget.showTitleDivider,
                child: Divider(
                  thickness: 1.0,
                  color: kGrey1,
                ),
              ),
              widget.content
            ],
          ),
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
                      widget.txtNegativeBtn,
                      style: kDefaultTextStyle.copyWith(color: kBlue1),
                    ),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: kBlue1)
                          )
                      )
                  ),
                  onPressed: widget.onTapNegativeBtn,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      widget.txtPositiveBtn,
                      style: kDefaultTextStyle.copyWith(color: Colors.white),
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
                  onPressed: widget.onTapPositiveBtn,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
