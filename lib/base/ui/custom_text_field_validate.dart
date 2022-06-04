import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/base/utils/palette.dart';

class TextFieldValidate extends StatefulWidget {
  EdgeInsetsGeometry padding;
  String title;
  String hint;
  var controller = TextEditingController();
  int maxLine;
  int maxLength;
  TextInputType keyboardType;
  bool isShowValidate;
  bool isEnabled; // false: không dc nhấn, true là dc nhấn

  bool isPrefixIcon;
  IconData iconPrefix;
  bool isSuffixIcon;
  IconData iconSuffix;
  FilteringTextInputFormatter inputFormatters;

  final void Function() onClickDone;
  final void Function() onChange;

  TextFieldValidate(
      {this.padding,
      this.title,
      this.hint,
      this.controller,
      this.isShowValidate = false,
      this.maxLine,
      this.maxLength,
      this.keyboardType,
      this.isPrefixIcon = false,
      this.iconPrefix,
      this.isSuffixIcon = false,
      this.isEnabled = true,
      this.iconSuffix,
      this.onClickDone,
      this.onChange,
      this.inputFormatters});

  @override
  _TextFieldValidateState createState() => _TextFieldValidateState();
}

class _TextFieldValidateState extends State<TextFieldValidate> {
  bool isColorTitle = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.all(0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.title ?? '',
                style: TextStyle(
                    color: !isColorTitle ? getColor("#555555") : Colors.blue,
                    fontSize: 12),
              ),
              Text(
                widget.isShowValidate ? '*' : '',
                style: TextStyle(color: Colors.red, fontSize: 12),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Focus(
              onFocusChange: (value) {
                setState(() {
                  isColorTitle = !isColorTitle;
                });
              },
              child: TextField(
                  inputFormatters: widget.inputFormatters == null
                      ? null
                      : [widget.inputFormatters],
                  enabled: widget.isEnabled,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    if (widget.onClickDone != null) widget.onClickDone();
                  },
                  onChanged: (value) {
                    if (widget.onChange != null) widget.onChange();
                  },
                  controller: widget.controller,
                  maxLines: widget.maxLine,
                  maxLength: widget.maxLength,
                  keyboardType: widget.keyboardType,
                  style: TextStyle(
                      color:
                          widget.isEnabled ? getColor('#555555') : Colors.grey,
                      fontSize: 14),
                  decoration: InputDecoration(
                      hintText: widget.hint,
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Palette.borderEditText.toColor())),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      labelStyle:
                          TextStyle(color: getColor('#555555'), fontSize: 14),
                      isDense: true,
                      suffixIconConstraints: BoxConstraints(
                          maxHeight: 20,
                          maxWidth: 20,
                          minWidth: 20,
                          minHeight: 20),
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: 20,
                          maxWidth: 20,
                          minWidth: 20,
                          minHeight: 20),
                      suffixStyle: TextStyle(),
                      contentPadding: EdgeInsets.only(top: 5.0, bottom: 5),
                      suffixIcon: widget.isSuffixIcon
                          ? Visibility(
                              child: Icon(
                                widget.iconSuffix ?? null,
                              ),
                            )
                          : null,
                      prefixIcon: widget.isPrefixIcon
                          ? Icon(
                              widget.iconPrefix ?? null,
                            )
                          : null)),
            ),
          )
        ],
      ),
    );
  }
}
