import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/main.dart';

Future<T> showListBottomSheet<T>(BuildContext context, Widget widget) async {
  return await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Wrap(children: [
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: widget),
          )
        ]);
      });
}

removeFocus({BuildContext context}) {
  // FocusScope.of(mainGlobalKey.currentContext).requestFocus(FocusNode());
}
