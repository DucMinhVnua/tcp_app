import 'package:flutter/material.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/common/constants.dart';

class ModalBottomSheetDialog {
  BuildContext context;

  String title;

  Function(dynamic) onTapListener;

  ModalBottomSheetDialog(
      {@required this.context, this.title, this.onTapListener});

  Future<dynamic> showBottomSheetDialog(List<ModalBottomSheetItemPair> data) {
    if (isNullOrEmpty(data)) return null;
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return SizedBox(
            height: data.length * 46.0 + 12.0 + 4 * (data.length - 1),
            // item height + padding top, bottom + divider height
            child: Container(
              padding:
                  const EdgeInsets.only(left: 20, top: 4, right: 20, bottom: 8),
              child: ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return data[index].icon != null
                      ? InkWell(
                          onTap: () async {
                            if (this.onTapListener != null) {
                              var result = await onTapListener(data[index]);
                              // Navigator.pop(context, result);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 46,
                            child: _optionsListItem(
                              context: context,
                              icon: data[index].icon,
                              title: data[index].content,
                              titleStyle: kDefaultTextStyle,
                            ),
                          ),
                        )
                      : Container(
                          height: 46,
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data[index].content,
                              style: kDefaultTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 4,
                  );
                },
              ),
            ),
          );
        });
  }

  Widget _optionsListItem({
    @required BuildContext context,
    @required Widget icon,
    @required String title,
    @required TextStyle titleStyle,
  }) {
    return Row(
      children: [
        Container(width: MediaQuery.of(context).size.width * 0.05, child: icon),
        SizedBox(
          width: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
      ],
    );
  }
}

class ModalBottomSheetItemPair {
  String key;
  Widget icon;
  String content;

  ModalBottomSheetItemPair({this.key, this.icon, this.content});
}
