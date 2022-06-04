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
import 'package:workflow_manager/models/mechanical_work_sheet_model.dart';
import 'package:workflow_manager/models/response/mechanical_work_sheets_response.dart';
import 'package:workflow_manager/tpc/screens/other/add_button.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class MechanicalWorkSheetAddWorkPlaceScreen extends StatefulWidget {
  final MechanicalWorkSheet mechanicalWorkSheet;

  MechanicalWorkSheetAddWorkPlaceScreen({
    this.mechanicalWorkSheet,
  });

  @override
  State<StatefulWidget> createState() =>
      _MechanicalWorkSheetAddWorkPlaceScreenState();
}

class _MechanicalWorkSheetAddWorkPlaceScreenState
    extends State<MechanicalWorkSheetAddWorkPlaceScreen> {
  TextEditingController workPlaceTextController = TextEditingController();
  TextEditingController overviewTextController = TextEditingController();
  // TextEditingController startDateTextController = TextEditingController();
  // TextEditingController endDateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  void onRefresh() {
    Provider.of<MechanicalWorkSheetModel>(context, listen: false)
        .getMechanicalWorkSheetDetail(widget.mechanicalWorkSheet.iD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bổ sung địa điểm công tác"),
        ),
        body: SafeArea(
          child: Consumer<MechanicalWorkSheetModel>(
            builder: (_, model, __) => (model.detailData == null ||
                    model.detailData.thongTinChung.iD !=
                        widget.mechanicalWorkSheet.iD)
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
                                "Danh sách địa điểm công tác: ${model.detailData.danhSachDiaDiemCongTac.length}",
                                style: kDefaultTextStyle.copyWith(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            AddButton(
                                onTapButton: () =>
                                    showAddWorkPlaceDialog(context))
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
                                      'icon': 'ic_location',
                                      'content':
                                          'Địa điểm công tác : ${model.detailData.danhSachDiaDiemCongTac[index].diaDiemCongTac}',
                                    },
                                    // {
                                    //   'icon': 'ic_clock',
                                    //   'content':
                                    //       'Thời gian bắt đầu : ${model.detailData.danhSachDiaDiemCongTac[index].thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}',
                                    // },
                                    // {
                                    //   'icon': 'ic_clock',
                                    //   'content':
                                    //       'Thời gian kết thúc : ${model.detailData.danhSachDiaDiemCongTac[index].thoiGianKetThuc.toDate(Constant.ddMMyyyyHHmm2)}',
                                    // },
                                  ],
                                  showAction: !(model.detailData.danhSachDiaDiemCongTac[index].thoiGianBatDau > 0),
                                  onEdit: () => {},
                                  onDelete: () => showDialogConfirmDelete(
                                      context,
                                      widget.mechanicalWorkSheet.iD,
                                      model
                                          .detailData
                                          .danhSachDiaDiemCongTac[index]
                                          .iDDiaDiem),
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
                                  .detailData.danhSachDiaDiemCongTac.length),
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }

  Future<void> showAddWorkPlaceDialog(BuildContext context) async {
    workPlaceTextController.clear();
    overviewTextController.clear();
    // startDateTextController.clear();
    // endDateTextController.clear();
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
                        'Bổ sung địa điểm công tác',
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
                        controller: workPlaceTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Địa điểm công việc',
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
                        controller: overviewTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Mô tả',
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 16, vertical: 4),
                    //   child: TextField(
                    //     controller: startDateTextController,
                    //     readOnly: true,
                    //     onTap: () {
                    //       DateTimePickerWidget(
                    //               context: context,
                    //               format: Constant.ddMMyyyyHHmm2,
                    //               onDateTimeSelected: (value) {
                    //                 setState(() {
                    //                   startDateTextController.text = value;
                    //                 });
                    //               },
                    //               maxTime: DateTime.now()
                    //                   .add(const Duration(days: 30)),
                    //               minTime: DateTime.now()
                    //                   .add(const Duration(days: -30)))
                    //           .showDateTimePicker();
                    //     },
                    //     decoration: InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Thời gian bắt đầu',
                    //       labelStyle: TextStyle(
                    //         fontWeight: FontWeight.w400,
                    //         fontStyle: FontStyle.normal,
                    //         fontSize: 14,
                    //         color: kGrey2,
                    //       ),
                    //       isDense: true,
                    //       suffixIconConstraints:
                    //           BoxConstraints(minHeight: 16.3, minWidth: 17),
                    //       suffixIcon: SvgImage(svgName: 'ic_date_picker'),
                    //       contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 16, vertical: 4),
                    //   child: TextField(
                    //     controller: endDateTextController,
                    //     readOnly: true,
                    //     onTap: () {
                    //       DateTimePickerWidget(
                    //               context: context,
                    //               format: Constant.ddMMyyyyHHmm2,
                    //               onDateTimeSelected: (value) {
                    //                 setState(() {
                    //                   endDateTextController.text = value;
                    //                 });
                    //               },
                    //               maxTime: DateTime.now()
                    //                   .add(const Duration(days: 30)),
                    //               minTime: DateTime.now()
                    //                   .add(const Duration(days: -30)))
                    //           .showDateTimePicker();
                    //     },
                    //     decoration: InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Thời gian kết thúc',
                    //       labelStyle: TextStyle(
                    //         fontWeight: FontWeight.w400,
                    //         fontStyle: FontStyle.normal,
                    //         fontSize: 14,
                    //         color: kGrey2,
                    //       ),
                    //       isDense: true,
                    //       suffixIconConstraints:
                    //           BoxConstraints(minHeight: 16.3, minWidth: 17),
                    //       suffixIcon: SvgImage(svgName: 'ic_date_picker'),
                    //       contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                    //     ),
                    //   ),
                    // ),
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
                          if (workPlaceTextController.text.isEmpty) {
                            ToastMessage.show(
                                'Địa điểm công tác không để trống',
                                ToastStyle.error);
                            return;
                          }
                          final result = await Provider.of<
                                      MechanicalWorkSheetModel>(context,
                                  listen: false)
                              .addWorkPlace(
                                  widget.mechanicalWorkSheet.iD,
                                  workPlaceTextController.text,
                                  overviewTextController.text,
                                  '',
                                  ''
                                  // DateFormat(Constant.ddMMyyyyHHmm2)
                                  //     .parse(startDateTextController.text)
                                  //     .millisecondsSinceEpoch
                                  //     .toString(),
                                  // DateFormat(Constant.ddMMyyyyHHmm2)
                                  //     .parse(endDateTextController.text)
                                  //     .millisecondsSinceEpoch
                                  //     .toString()
                                  );
                          Navigator.of(context).pop(result);
                          NotificationDialog.show(
                              this.context,
                              result.isSuccess() ? 'ic_success' : 'ic_error',
                              result.isSuccess()
                                  ? 'Bổ sung thành công'
                                  : 'Đã xảy ra lỗi');
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
    workPlaceTextController.dispose();
    overviewTextController.dispose();
    // startDateTextController.dispose();
    // endDateTextController.dispose();
    super.dispose();
  }

  Future<void> showDialogConfirmDelete(
      BuildContext context, int workSheetId, int workPlaceId) async {
    CustomTwoButtonDialog dialog = CustomTwoButtonDialog(
      context: context,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Text(
          'Xóa địa điểm công tác',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'Xác nhận xóa địa điểm công tác?',
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
            await Provider.of<MechanicalWorkSheetModel>(context, listen: false)
                .deleteWorkPlace(workSheetId, workPlaceId);
        Navigator.of(context).pop(result);
        NotificationDialog.show(
            this.context,
            result.isSuccess() ? 'ic_success' : 'ic_error',
            result.isSuccess() ? 'Xóa thành công' : 'Đã xảy ra lỗi');
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
