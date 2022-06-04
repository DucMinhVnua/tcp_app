import 'package:flutter/material.dart';
import 'package:workflow_manager/base/utils/common_function.dart';

class TabNumberWidget extends Tab {
  String nameTab;
  int number;

  TabNumberWidget(this.nameTab, this.number) : super(text: nameTab);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(nameTab),
          number != 0
              ? Container(
                  margin: EdgeInsets.only(left: 2),
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: getColor("#EBF5FE")),
                  child: Text(
                    number > 99 ? '99+' : number.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
