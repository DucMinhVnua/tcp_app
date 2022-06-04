import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/expandable.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';


class CustomExpandablePanel extends StatelessWidget {
  final String headerTitle;
  final Widget contentExpanded;
  final bool initExpanded;

  CustomExpandablePanel({
    this.headerTitle,
    this.contentExpanded,
    this.initExpanded = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kGrey1,
        child: ExpandableNotifier(
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
        )
    );
  }

  Widget _buildExpandableHeader({String titlePanel, bool isExpanded}) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        child: Row(children: [
          Flexible(
              flex: 9,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  titlePanel,
                  style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.w700),
                ),
              )),
          Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: isExpanded
                    ? SvgImage(svgName: "ic_collapse", size: 20.0)
                    : RotatedBox(
                    quarterTurns: 2,
                    child: SvgImage(svgName: "ic_collapse", size: 20.0)
                ),
              )),
        ]),
      ),
    );
  }

}
