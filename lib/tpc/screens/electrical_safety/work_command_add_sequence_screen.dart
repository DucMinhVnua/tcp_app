import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/ui/date_time_picker_widget.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/response/work_commands_response.dart';
import 'package:workflow_manager/models/work_command_model.dart';
import 'package:workflow_manager/tpc/screens/other/add_button.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

import '../other/custom_one_button_dialog.dart';

class WorkCommandAddSequenceScreen extends StatefulWidget {
  final WorkCommand workCommand;

  WorkCommandAddSequenceScreen({
    this.workCommand,
  });

  @override
  State<StatefulWidget> createState() => _WorkCommandAddSequenceScreenState();
}

class _WorkCommandAddSequenceScreenState
    extends State<WorkCommandAddSequenceScreen> {
  TextEditingController workSequenceTextController = TextEditingController();
  TextEditingController safetyConditionTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  void onRefresh() {
    Provider.of<WorkCommandModel>(context, listen: false)
        .getWorkCommandDetail(widget.workCommand.iD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("B??? sung tr??nh t??? c??ng vi???c"),
        ),
        body: SafeArea(
          child: Consumer<WorkCommandModel>(
            builder: (_, model, __) => (model.detailData == null ||
                    model.detailData.thongTinChung.iD != widget.workCommand.iD)
                ? Container()
                : Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height *
                            kDefaultAppBarBottom,
                        alignment: Alignment.centerLeft,
                        color: kGrey1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Text(
                                "Danh s??ch tr??nh t??? c??ng vi???c: ${model.detailData.danhSachTrinhTuCongViec.length}",
                                style: kDefaultTextStyle.copyWith(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            AddButton(
                                onTapButton: () =>
                                    showAddSequenceDialog(context))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return ListItemEditDelete(
                                  itemPairsData: [
                                    {
                                      'icon': 'ic_sequence_name',
                                      'content':
                                          'Tr??nh t??? thao t??c : ${model.detailData.danhSachTrinhTuCongViec[index].trinhTuThaoTac}',
                                    },
                                    {
                                      'icon': 'ic_safety_conditional',
                                      'content':
                                          '??i???u ki???n an to??n : ${model.detailData.danhSachTrinhTuCongViec[index].dieuKienAnToan}',
                                    },
                                    {
                                      'icon': 'ic_clock',
                                      'content':
                                          'Th???i gian b???t ?????u : ${model.detailData.danhSachTrinhTuCongViec[index].thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}',
                                    },
                                    {
                                      'icon': 'ic_clock',
                                      'content':
                                          'Th???i gian k???t th??c : ${model.detailData.danhSachTrinhTuCongViec[index].thoiGianKetThuc.toDate(Constant.ddMMyyyyHHmm2)}',
                                    },
                                  ],
                                  showAction: !(model.detailData.danhSachTrinhTuCongViec[index].thoiGianBatDau > 0),
                                  onEdit: () => {},
                                  onDelete: () => showDialogConfirmDelete(
                                      context,
                                      widget.workCommand.iD,
                                      model
                                          .detailData
                                          .danhSachTrinhTuCongViec[index]
                                          .iDTrinhTu),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 32,
                                  color: kGrey1,
                                  thickness: 2,
                                );
                              },
                              itemCount: model
                                  .detailData.danhSachTrinhTuCongViec.length),
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }

  Future<void> showAddSequenceDialog(BuildContext context) async {
    workSequenceTextController.clear();
    safetyConditionTextController.clear();
    startDateTextController.clear();
    endDateTextController.clear();
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Th??m m???i tr??nh t???',
                        textAlign: TextAlign.center,
                        style: kMediumBlackTextStyle,
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: kGrey2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: TextField(
                        controller: workSequenceTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Tr??nh t??? c??ng t??c	',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                          ),
                          isDense: true,
                          hintText: '',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: TextField(
                        controller: safetyConditionTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: '??i???u ki???n an to??n',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                          ),
                          isDense: true,
                          hintText: 'C?? ????? b???o h???',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: TextField(
                        controller: startDateTextController,
                        readOnly: true,
                        onTap: () {
                          DateTimePickerWidget(
                                  context: context,
                                  format: Constant.ddMMyyyyHHmm2,
                                  onDateTimeSelected: (value) {
                                    setState(() {
                                      startDateTextController.text = value;
                                    });
                                  },
                                  maxTime: DateTime.now()
                                      .add(const Duration(days: 30)),
                                  minTime: DateTime.now()
                                      .add(const Duration(days: -30)))
                              .showDateTimePicker();
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Th???i gian b???t ?????u',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: kGrey2,
                          ),
                          isDense: true,
                          hintText: '21-11-2020 22:00',
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 16.3, minWidth: 17),
                          suffixIcon: SvgImage(svgName: 'ic_date_picker'),
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: TextField(
                        controller: endDateTextController,
                        readOnly: true,
                        onTap: () {
                          DateTimePickerWidget(
                                  context: context,
                                  format: Constant.ddMMyyyyHHmm2,
                                  onDateTimeSelected: (value) {
                                    setState(() {
                                      endDateTextController.text = value;
                                    });
                                  },
                                  maxTime: DateTime.now()
                                      .add(const Duration(days: 30)),
                                  minTime: DateTime.now()
                                      .add(const Duration(days: -30)))
                              .showDateTimePicker();
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Th???i gian k???t th??c',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: kGrey2,
                          ),
                          isDense: true,
                          hintText: '21-11-2020 22:00',
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 16.3, minWidth: 17),
                          suffixIcon: SvgImage(svgName: 'ic_date_picker'),
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actionsPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'HU???',
                            style: kDefaultTextStyle.copyWith(color: kBlue1),
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: kBlue1)))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'TH??M',
                            style:
                                kDefaultTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kBlue1),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: kBlue1)))),
                        onPressed: () async {
                          if (workSequenceTextController.text.isEmpty) {
                            ToastMessage.show(
                                'Tr??nh t??? c??ng t??c kh??ng ????? tr???ng',
                                ToastStyle.error);
                            return;
                          }
                          final result = await Provider.of<WorkCommandModel>(
                                  context,
                                  listen: false)
                              .addWorkSequence(
                                  widget.workCommand.iD,
                                  workSequenceTextController.text,
                                  safetyConditionTextController.text,
                                  startDateTextController.text.isEmpty
                                      ? ''
                                      : DateFormat(Constant.ddMMyyyyHHmm2)
                                          .parse(startDateTextController.text)
                                          .millisecondsSinceEpoch
                                          .toString(),
                                  endDateTextController.text.isEmpty
                                      ? ''
                                      : DateFormat(Constant.ddMMyyyyHHmm2)
                                          .parse(endDateTextController.text)
                                          .millisecondsSinceEpoch
                                          .toString());
                          Navigator.of(context).pop(result);
                          NotificationDialog.show(
                              this.context,
                              result.isSuccess() ? 'ic_success' : 'ic_error',
                              result.isSuccess()
                                  ? 'X??c nh???n th??nh c??ng'
                                  : '???? x???y ra l???i, Vui l??ng th??? l???i');
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
    if (result != null) {
      onRefresh();
    }
  }

  @override
  void dispose() {
    workSequenceTextController.dispose();
    safetyConditionTextController.dispose();
    startDateTextController.dispose();
    endDateTextController.dispose();
    super.dispose();
  }

  void _displayDialogEditSequenceWork(BuildContext context) {
    CustomOneButtonDialog dialogEditMember = CustomOneButtonDialog(
      context: context,
      title: 'EDIT',
      content: Container(),
      txtBtn: '?????NG ??',
      onTapBtn: () {
        Navigator.of(context).pop();
      },
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => dialogEditMember,
      barrierDismissible: false,
    );
  }

  Future<void> showDialogConfirmDelete(
      BuildContext context, int workCommandId, int workSequenceId) async {
    CustomTwoButtonDialog dialog = CustomTwoButtonDialog(
      context: context,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Text(
          'X??a tr??nh t??? c??ng vi???c',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'X??c nh???n x??a tr??nh t??? c??ng vi???c?',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      txtNegativeBtn: 'HU???',
      onTapNegativeBtn: () {
        Navigator.of(context).pop();
      },
      txtPositiveBtn: 'X??A',
      onTapPositiveBtn: () async {
        final result =
            await Provider.of<WorkCommandModel>(context, listen: false)
                .deleteWorkSequence(workCommandId, workSequenceId);
        // ToastMessage.show(result.data.text,
        //     result.isSuccess() ? ToastStyle.success : ToastStyle.error);
        Navigator.of(context).pop(result);
        NotificationDialog.show(
            this.context,
            result.isSuccess() ? 'ic_success' : 'ic_error',
            result.isSuccess()
                ? 'X??c nh???n th??nh c??ng'
                : '???? x???y ra l???i, Vui l??ng th??? l???i');
      },
    );
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: false,
    );
    if (result != null) {
      onRefresh();
    }
  }
}
