import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTabBarWidget extends StatelessWidget {

  String tabName;

  int size;

  CustomTabBarWidget(this.tabName, this.size);

  @override
  Widget build(BuildContext context) {
    if (tabName == "Đã hoàn thành" || tabName == "Có gắn sao" || tabName == "Tất cả hồ sơ" || size == 0) {
      return Text("$tabName");
    }
    return Row(
      children: [
        Text("$tabName "),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Text(
              "$size",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.amber
          ),
        )
      ],
    );
  }
}