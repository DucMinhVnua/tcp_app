import 'package:flutter/material.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/base/extension/string.dart';

Future<bool> showConfirmDialog(
    BuildContext context, String content, Function() onAccept,
    {Function() onCancel, String cancelText, String acceptText}) async {
  ConfirmDialogFunction confirmDialogFunction = ConfirmDialogFunction(
      context: context,
      content: content,
      onAccept: onAccept,
      onCancel: onCancel,
      cancelTitle: cancelText,
      acceptTitle: acceptText);
  return await confirmDialogFunction.showConfirmDialog();
}

class ConfirmDialogFunction {
  BuildContext context;
  String content;
  String acceptTitle;
  String cancelTitle;
  Widget widgetContent;

  Function() onAccept;
  Function() onCancel;
  String title;

  ConfirmDialogFunction(
      {@required this.context,
      this.content,
      this.widgetContent,
      this.onCancel,
      this.onAccept,
      this.title,
      this.cancelTitle,
      this.acceptTitle});

  Future<bool> showConfirmDialog() async {
    Widget cancelButton = FlatButton(
      child: Text(
        cancelTitle ?? "Hủy",
        style: TextStyle(color:Colors.grey),
      ),
      onPressed: () {
        if (onCancel != null) onCancel();
        Navigator.of(context).pop(false);
      },
    );

    Widget continueButton = FlatButton(
      child: Text(acceptTitle ?? "Đồng ý", style: TextStyle(color:Colors.blue, fontWeight: FontWeight.bold),),
      onPressed: () {
        if (onAccept != null) onAccept();
        Navigator.of(context).pop(true);
      },
    );
    // set up the AlertDialog

    // show the dialog
    Widget _getWidgetContent() {
      if (isNotNullOrEmpty(title)) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              widgetContent ?? Text(content)
            ]);
      } else
        return widgetContent ?? Text(content);
    }

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(32),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          child: Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: EdgeInsets.only(left: 16, right: 16), child: _getWidgetContent()),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [cancelButton, continueButton],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
