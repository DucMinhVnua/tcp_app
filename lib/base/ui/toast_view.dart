import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workflow_manager/base/models/base_response.dart';

enum ToastStyle { success, error, warning, normal }

final String textNotLeftBlank = ' không được bỏ trống';

class ToastMessage {
  static void show(String message, ToastStyle style) {
    Color bgColor = Colors.greenAccent;
    Color textColor = Colors.white;
    if (style == ToastStyle.success) {
      bgColor = Colors.blue.withAlpha(180);
    } else if (style == ToastStyle.warning) {
      bgColor = Colors.orangeAccent;
    } else if (style == ToastStyle.error) {
      bgColor = Colors.redAccent;
    } else {
      bgColor = Colors.black;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 14.0);
  }
}

void showErrorToast(dynamic content, {String defaultMessage}) {
  String text = "";
  if (content is BaseResponse) {
    text = content.isDefaultMesasge
        ? defaultMessage ?? content.messages
        : content.messages;
  } else {
    text = content.toString();
  }
  ToastMessage.show(text, ToastStyle.error);
}

void showSuccessToast(String text) {
  ToastMessage.show(text, ToastStyle.success);
}
