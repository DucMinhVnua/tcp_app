import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';

class ListItemInfo extends StatelessWidget {
  final List<Map<String, dynamic>> itemPairsData;
  final Function onTap;
  final bool showActions;

  ListItemInfo({
    this.itemPairsData,
    this.onTap,
    this.showActions,
  }) : super(key: ObjectKey(itemPairsData));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (itemPairsData[0]["icon"] != null)
                          Flexible(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: itemPairsData[0]["color"] != null
                                  ? SvgImage(
                                      color: HexColor(
                                          '${itemPairsData[0]["color"]}'),
                                      svgName: '${itemPairsData[0]["icon"]}',
                                    )
                                  : SvgImage(
                                      svgName: '${itemPairsData[0]["icon"]}',
                                    ),
                            ),
                          ),
                        Expanded(
                            flex: 12,
                            child: Text(
                              '${itemPairsData[0]["content"]}',
                              style: kDefaultTextStyle.copyWith(
                                  fontWeight: FontWeight.w600),
                            )),
                      ],
                    ),
                  ),
                  if (itemPairsData[1]["status"] != null)
                    Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          child: Text(
                            '${itemPairsData[1]["status"]}',
                            style: kDefaultTextStyle.copyWith(
                                color: HexColor('${itemPairsData[1]["color"]}'),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: HexColor('${itemPairsData[1]["color"]}')
                                  .withOpacity(0.25)),
                        )),
                  for (var i = 2; i < itemPairsData.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SvgImage(
                                svgName: '${itemPairsData[i]["icon"]}',
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 12,
                              child: Text(
                                '${itemPairsData[i]["content"]}'
                                        .endsWith('null')
                                    ? '${itemPairsData[i]["content"]}'
                                            .split(":")
                                            .first +
                                        ' : '
                                    : '${itemPairsData[i]["content"]}',
                                style: kDefaultTextStyle,
                              )),
                        ],
                      ),
                    ),
                ],
              )),
          Visibility(
            visible: showActions,
            child: Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SvgImage(svgName: "ic_more"),
                    ),
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}

class ListItemEditDelete extends StatelessWidget {
  final List<Map<String, String>> itemPairsData;
  final Function onEdit;
  final Function onDelete;
  final bool showAction;

  ListItemEditDelete({
    this.itemPairsData,
    this.onEdit,
    this.onDelete,
    this.showAction,
  }) : super(key: ObjectKey(itemPairsData));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < itemPairsData.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SvgImage(
                              svgName: '${itemPairsData[i]["icon"]}',
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 12,
                            child: Text(
                              '${itemPairsData[i]["content"]}'.endsWith('null')
                                  ? '${itemPairsData[i]["content"]}'
                                          .split(":")
                                          .first +
                                      ' : '
                                  : '${itemPairsData[i]["content"]}',
                              style: kDefaultTextStyle.copyWith(
                                  fontWeight: i == 0
                                      ? FontWeight.w400
                                      : FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
              ],
            )),
        Visibility(
          visible: showAction == null ? true : showAction,
          child: Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SvgImage(
                  //   svgName: "ic_edit",
                  //   onTap: this.onEdit,
                  // ),
                  // SizedBox(width: 5),
                  SvgImage(
                    svgName: "ic_delete",
                    onTap: this.onDelete,
                  ),
                ],
              )),
        ),
      ]),
    );
  }
}

class ListItemZebraStyle extends StatelessWidget {
  final String itemTitle;
  final List<Map<String, String>> itemPairsData;
  final Function onTap;
  final bool showActions;
  final String actionLabel;
  final Function onTapAction;
  final bool showActions2;
  final String actionLabel2;
  final Function onTapAction2;
  final bool showActions3;
  final String actionLabel3;
  final Function onTapAction3;
  final bool showActionsEdit;
  final Function onTapActionEdit;
  final bool showActionsDelete;
  final Function onTapActionDelete;
  final bool isLastItem;
  final Widget statusWidget;

  ListItemZebraStyle(
      {this.itemTitle,
      this.itemPairsData,
      this.onTap,
      this.showActions,
      this.isLastItem = false,
      this.actionLabel,
      this.onTapAction,
      this.showActions2,
      this.actionLabel2,
      this.onTapAction2,
      this.showActions3,
      this.actionLabel3,
      this.onTapAction3,
      this.showActionsEdit,
      this.onTapActionEdit,
      this.showActionsDelete,
      this.onTapActionDelete,
      this.statusWidget})
      : super(key: ObjectKey(itemPairsData));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? onTap : () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        itemTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: kDefaultTextStyle.copyWith(
                            fontWeight: FontWeight.w700),
                      )),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: showActions == null ? false : showActions,
                            child: InkWell(
                              onTap: onTapAction != null ? onTapAction : () {},
                              child: Container(
                                child: Text(
                                  actionLabel == null ? 'ACTION' : actionLabel,
                                  style: kDefaultTextStyle.copyWith(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: kColorPrimary),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Visibility(
                            visible:
                                showActions2 == null ? false : showActions2,
                            child: InkWell(
                              onTap:
                                  onTapAction2 != null ? onTapAction2 : () {},
                              child: Container(
                                child: Text(
                                  actionLabel2 == null
                                      ? 'ACTION2'
                                      : actionLabel2,
                                  style: kDefaultTextStyle.copyWith(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: kColorPrimary),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Visibility(
                            visible:
                                showActions3 == null ? false : showActions3,
                            child: InkWell(
                              onTap:
                                  onTapAction3 != null ? onTapAction3 : () {},
                              child: Container(
                                child: Text(
                                  actionLabel3 == null
                                      ? 'ACTION3'
                                      : actionLabel3,
                                  style: kDefaultTextStyle.copyWith(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: kColorPrimary),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Visibility(
                            visible: showActionsEdit == null
                                ? false
                                : showActionsEdit,
                            child: SvgImage(
                              svgName: "ic_edit",
                              onTap: onTapActionEdit != null
                                  ? onTapActionEdit
                                  : () {},
                            ),
                          ),
                          SizedBox(width: 5),
                          Visibility(
                            visible: showActionsDelete == null
                                ? false
                                : showActionsDelete,
                            child: SvgImage(
                              svgName: "ic_delete",
                              onTap: onTapActionDelete != null
                                  ? onTapActionDelete
                                  : () {},
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: SvgImage(svgName: "ic_next"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                for (var i = 0; i < itemPairsData.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            color: (i % 2 == 0) ? kGrey3 : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                '${itemPairsData[i]["content"]}'
                                        .endsWith('null')
                                    ? '${itemPairsData[i]["content"]}'
                                            .split(":")
                                            .first +
                                        ' : '
                                    : '${itemPairsData[i]["content"]}',
                                textAlign: TextAlign.start,
                                style: kDefaultTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Visibility(
                  visible: statusWidget == null ? false : true,
                  child: statusWidget == null ? Container() : statusWidget,
                ),
                Visibility(
                  visible: !isLastItem ? true : false,
                  child: Divider(thickness: 1.0, color: kGrey1),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class ListItemReceipt extends StatelessWidget {
  final String itemTitle;
  final List<Map<String, dynamic>> itemPairsData;
  final Function onTap;
  final bool showActions;
  final String actionLabel;
  final Function onTapAction;
  final bool showActions2;
  final String actionLabel2;
  final Function onTapAction2;
  final bool showActions3;
  final String actionLabel3;
  final Function onTapAction3;
  final bool isLastItem;
  final bool showFileList;
  final Widget fileList;

  ListItemReceipt(
      {this.itemTitle,
      this.itemPairsData,
      this.onTap,
      this.showActions,
      this.isLastItem = false,
      this.actionLabel,
      this.onTapAction,
      this.showActions2,
      this.actionLabel2,
      this.onTapAction2,
      this.showActions3,
      this.actionLabel3,
      this.onTapAction3,
      this.showFileList,
      this.fileList})
      : super(key: ObjectKey(itemPairsData));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        itemTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: kDefaultTextStyle.copyWith(
                            fontWeight: FontWeight.w700),
                      )),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: showActions == null ? false : showActions,
                            child: InkWell(
                              onTap: onTapAction != null ? onTapAction : () {},
                              child: Container(
                                child: Text(
                                  actionLabel == null ? 'ACTION' : actionLabel,
                                  style: kDefaultTextStyle.copyWith(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: kColorPrimary),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Visibility(
                            visible:
                                showActions2 == null ? false : showActions2,
                            child: InkWell(
                              onTap:
                                  onTapAction2 != null ? onTapAction2 : () {},
                              child: Container(
                                child: Text(
                                  actionLabel2 == null
                                      ? 'ACTION2'
                                      : actionLabel2,
                                  style: kDefaultTextStyle.copyWith(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: kColorPrimary),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Visibility(
                            visible:
                                showActions3 == null ? false : showActions3,
                            child: InkWell(
                              onTap:
                                  onTapAction3 != null ? onTapAction3 : () {},
                              child: Container(
                                child: Text(
                                  actionLabel3 == null
                                      ? 'ACTION3'
                                      : actionLabel3,
                                  style: kDefaultTextStyle.copyWith(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: kColorPrimary),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerRight,
                            child: SvgImage(svgName: "ic_next"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (itemPairsData[0]["content"] != null)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            child: Text(
                              '${itemPairsData[0]["content"]}',
                              style: kDefaultTextStyle.copyWith(
                                  color:
                                      HexColor('${itemPairsData[0]["color"]}'),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: HexColor('${itemPairsData[0]["color"]}')
                                    .withOpacity(0.25)),
                          )),
                    for (var i = 1; i < itemPairsData.length; i++)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '${itemPairsData[i]["content"]}'.endsWith('null')
                                ? '${itemPairsData[i]["content"]}'
                                        .split(":")
                                        .first +
                                    ' : '
                                : '${itemPairsData[i]["content"]}',
                            style: kDefaultTextStyle,
                          )),
                  ],
                ),
                Visibility(
                  visible: showFileList ? true : false,
                  child: fileList != null ? fileList : Container(),
                ),
                Visibility(
                  visible: !isLastItem ? true : false,
                  child: Divider(thickness: 1.0, color: kGrey1),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class ListItemGeneralInfo extends StatelessWidget {
  final List<Map<String, dynamic>> itemPairsData;
  final Function onTap;
  final bool showActions;

  ListItemGeneralInfo({
    this.itemPairsData,
    this.onTap,
    this.showActions,
  }) : super(key: ObjectKey(itemPairsData));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < itemPairsData.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0),
                    child: Text(
                      '${itemPairsData[i]["content"]}'.endsWith('null')
                          ? '${itemPairsData[i]["content"]}'.split(":").first +
                              ' : '
                          : '${itemPairsData[i]["content"]}',
                      textAlign: TextAlign.start,
                      style: kDefaultTextStyle,
                    ),
                  ),
              ],
            ),
          ),
          Visibility(
            visible: showActions == null ? false : showActions,
            child: Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SvgImage(
                    svgName: "ic_view_eye",
                    onTap: onTap != null ? onTap : () {},
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}