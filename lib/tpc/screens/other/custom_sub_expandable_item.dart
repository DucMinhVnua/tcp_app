

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/expandable.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';

class CustomSubExpandableItem extends StatelessWidget {
  final String headerTitle;
  final Widget contentExpanded;
  final bool initExpanded;

  CustomSubExpandableItem({
    this.headerTitle,
    this.contentExpanded,
    this.initExpanded
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      initialExpanded: initExpanded,
      child: Column(
        children: [
          Expandable(
            collapsed: ExpandableButton(
              child: _buildExpandableHeader(titlePanel: headerTitle, isExpanded: false),
            ),
            expanded: Column(
                children: [
                  ExpandableButton(
                    child: _buildExpandableHeader(titlePanel: headerTitle, isExpanded: true),
                  ),
                  contentExpanded,
                ]
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExpandableHeader({String titlePanel, bool isExpanded}) {
    return InkWell(
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                titlePanel,
                style: kDefaultTextStyle.copyWith(fontSize: 13.0),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: isExpanded
                  ? SvgImage(svgName: "ic_sub_collapse", size: 20.0)
                  : SvgImage(svgName: "ic_sub_expand", size: 20.0),
            ),
          ),
        ]),
    );
  }

}