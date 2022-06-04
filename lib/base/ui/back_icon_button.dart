import 'dart:io';

import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {

  Function() onTapListener;

  BackIconButton({this.onTapListener});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Platform.isAndroid == true ? Icons.arrow_back : Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () {
        onTapListener == null ?
        Navigator.of(context).pop() : onTapListener();
      },
    );
  }
}
