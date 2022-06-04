import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/base/extension/string.dart';

class NumberGroupWidget extends StatefulWidget {
  String title;

  int count;

  IconData icon;
  bool isShowValidate;

  final VoidCallback onPressed;

  NumberGroupWidget(
      {this.title = "",
      this.count = 0,
      this.icon = Icons.arrow_forward_ios,
      this.isShowValidate = false,
      this.onPressed});

  @override
  State<NumberGroupWidget> createState() => _NumberGroupWidgetState();
}

class _NumberGroupWidgetState extends State<NumberGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.widget.title,
                    style: TextStyle(color: "#555555".toColor(), fontSize: 14),
                  ),
                  Text(
                    widget.isShowValidate ? '*' : '',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              ),
              // Text(
              //   this.widget.title,
              //   style: TextStyle(color: Colors.blue),
              // ),
              Container(
                margin: EdgeInsets.only(left: 4),
                padding: EdgeInsets.only(left: 4, top: 2, right: 4, bottom: 2),
                child: Text(
                  "${this.widget.count}",
                  style: TextStyle(color: Colors.blue),
                ),
                decoration: BoxDecoration(
                    color: "#DFEAFB".toColor(),
                    borderRadius: BorderRadius.circular(8)),
              ),
              Expanded(
                child: Container(
                  height: 20,
                  alignment: Alignment.centerRight,
                  child: Icon(
                    this.widget.icon,
                    color: "#939BA2".toColor(),
                  ),
                ),
              )
            ],
          )),
      onTap: () {
        this.widget.onPressed();
      },
    );
  }
}
