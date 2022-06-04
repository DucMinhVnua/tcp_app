import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/ui/date_time_picker_widget.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/dimens.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/mechanical_work_command_model.dart';
import 'package:workflow_manager/models/response/mechanical_work_commands_response.dart';
import 'package:workflow_manager/tpc/screens/other/add_button.dart';
import 'package:workflow_manager/tpc/screens/other/custom_one_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class MechanicalWorkCommandAddSequenceScreen extends StatefulWidget {
  final MechanicalWorkCommand mechanicalWorkCommand;

  MechanicalWorkCommandAddSequenceScreen({
    this.mechanicalWorkCommand,
  });

  @override
  State<StatefulWidget> createState() => _MechanicalWorkCommandAddSequenceScreenState();
}

class _MechanicalWorkCommandAddSequenceScreenState extends State<MechanicalWorkCommandAddSequenceScreen> {
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
    Provider.of<MechanicalWorkCommandModel>(context, listen: false)
        .getMechanicalWorkCommandDetail(widget.mechanicalWorkCommand.iD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bổ sung trình tự công việc"),
        ),
        body: SafeArea(
          child: Consumer<MechanicalWorkCommandModel>(
            builder: (_, model, __) => (model.detailData == null ||
                model.detailData.thongTinChung.iD != widget.mechanicalWorkCommand.iD)
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
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        child: Text(
                          "Danh sách trình tự công việc: ${model.detailData.danhSachNhatKyCongTac.length}",
                          style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      AddButton(
                          onTapButton: () => showAddSequenceDialog(context)
                      ),
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
                                'Trình tự thao tác : ${model.detailData.danhSachNhatKyCongTac[index].nhatKyCongTac}',
                              },
                              {
                                'icon': 'ic_safety_conditional',
                                'content':
                                'Điều kiện an toàn : ${model.detailData.danhSachNhatKyCongTac[index].nguoiChiHuyXacNhanBD}',
                              },
                              {
                                'icon': 'ic_clock',
                                'content':
                                'Thời gian bắt đầu : ${model.detailData.danhSachNhatKyCongTac[index].thoiGianBatDau.toDate(Constant.ddMMyyyy)}',
                              },
                              {
                                'icon': 'ic_clock',
                                'content':
                                'Thời gian kết thúc : ${model.detailData.danhSachNhatKyCongTac[index].thoiGianKetThuc.toDate(Constant.ddMMyyyy)}',
                              },
                            ],
                            showAction: !(model.detailData.danhSachNhatKyCongTac[index].thoiGianBatDau > 0),
                            onEdit: () => {},
                            onDelete: () => showDialogConfirmDelete(
                                context,
                                widget.mechanicalWorkCommand.iD,
                                model.detailData.danhSachNhatKyCongTac[index].iDNhatKy),
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
                            .detailData.danhSachNhatKyCongTac.length),
                  ),
                ),
              ],
            ),
          ),
        )
    );
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
                        'Thêm mới trình tự',
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
                          labelText: 'Trình tự công tác	',
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
                          labelText: 'Điều kiện an toàn',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                          ),
                          isDense: true,
                          hintText: 'Có đồ bảo hộ',
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
                          labelText: 'Thời gian bắt đầu',
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
                          labelText: 'Thời gian kết thúc',
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
                            'HUỶ',
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
                            'THÊM',
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
                                'Trình tự công tác không để trống',
                                ToastStyle.error);
                            return;
                          }
                          final result = await Provider.of<
                                      MechanicalWorkCommandModel>(context,
                                  listen: false)
                              .addWorkDiary(
                                  widget.mechanicalWorkCommand.iD,
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
                          // ToastMessage.show(
                          //     result.data.text,
                          //     result.isSuccess()
                          //         ? ToastStyle.success
                          //         : ToastStyle.error);
                          Navigator.of(context).pop(result);
                          NotificationDialog.show(
                              this.context,
                              result.isSuccess() ? 'ic_success' : 'ic_error',
                              result.isSuccess() ? 'Xác nhận thành công' : 'Đã xảy ra lỗi, Vui lòng thử lại');
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
      txtBtn: 'ĐỒNG Ý',
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
          'Xóa trình tự công việc',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'Xác nhận xóa trình tự công việc?',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      txtNegativeBtn: 'HUỶ',
      onTapNegativeBtn: () {
        Navigator.of(context).pop();
      },
      txtPositiveBtn: 'XÓA',
      onTapPositiveBtn: () async {
        final result =
        await Provider.of<MechanicalWorkCommandModel>(context, listen: false)
            .deleteWorkSequence(workCommandId, workSequenceId);
        // ToastMessage.show(result.data.text,
        //     result.isSuccess() ? ToastStyle.success : ToastStyle.error);
        Navigator.of(context).pop(result);
        NotificationDialog.show(
            this.context,
            result.isSuccess() ? 'ic_success' : 'ic_error',
            result.isSuccess() ? 'Xác nhận thành công' : 'Đã xảy ra lỗi, Vui lòng thử lại');
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