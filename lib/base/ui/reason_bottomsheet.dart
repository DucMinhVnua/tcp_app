import 'package:flutter/material.dart';
import 'package:workflow_manager/base/ui/save_button.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/base/utils/ui_common_functions.dart';

class ReasonBottomSheet extends StatelessWidget {
  String title;
  String nameButtonSave;
  Color colorButtonSave;
  String reason;
  String dataReason;
  bool isRequired = false;
  double borderRadius;
  var reasonController = TextEditingController();

  Future<String> showBottomSheet(BuildContext context) async {
    String data = await showListBottomSheet(
        context,
        ReasonBottomSheet(
          title,
          reason: reason,
          nameButtonSave: nameButtonSave,
          colorButtonSave: colorButtonSave,
          dataReason: dataReason,
          isRequired: isRequired,
          borderRadius: borderRadius,
        ));
    return data;
  }

  ReasonBottomSheet(this.title,
      {Key key,
      this.reason,
      this.nameButtonSave,
      this.colorButtonSave,
      this.dataReason,
      this.borderRadius,
      this.isRequired})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    reasonController.text = dataReason;
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  reason ?? 'Lý do',
                  style: TextStyle(fontSize: 14),
                ),
                Visibility(
                  visible: isRequired,
                  child: Text(
                    ' *',
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: TextField(
              minLines: 5,
              maxLines: 9,
              controller: reasonController,
              decoration: InputDecoration(
                hintText: 'Nhập ${reason?.toLowerCase() ?? 'lý do'}',
              ),
            ),
          ),
          SaveButton(
            borderRadius: borderRadius,
            buttonType: SaveButton.button_type_default,
            title: '${nameButtonSave ?? 'Đồng ý'}',
            color: colorButtonSave,
            onTap: () {
              if (isRequired && isNullOrEmpty(reasonController.text.trim())) {
                ToastMessage.show(
                    '${reason ?? 'Lý do'}$textNotLeftBlank', ToastStyle.error);
                return;
              }
              Navigator.of(context).pop(reasonController.text);
            },
          ),
          SaveButton(
            buttonType: SaveButton.button_type_cancel,
            title: 'Hủy',
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
