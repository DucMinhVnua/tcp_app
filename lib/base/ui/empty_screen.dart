import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/base/utils/common_function.dart';

class EmptyScreen extends StatefulWidget {
  EmptyScreen({this.message});

  final String message;

  @override
  State<StatefulWidget> createState() => _EmptyScreen();
}

class _EmptyScreen extends State<EmptyScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Xmessage message = ${widget.message}");
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text(
              isNullOrEmpty(widget.message) ? "Không có dữ liệu" : widget.message),
        ),
      ),
    );
  }
}
