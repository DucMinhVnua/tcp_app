import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  final void Function() onSelectedButton;
  Color colorBackGround;

  FloatingButtonWidget({this.onSelectedButton, this.colorBackGround});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          if (this.onSelectedButton != null) this.onSelectedButton();
        },
        child: Icon(Icons.add),
        backgroundColor: colorBackGround ?? Colors.blue,
        heroTag: null);
  }
}
