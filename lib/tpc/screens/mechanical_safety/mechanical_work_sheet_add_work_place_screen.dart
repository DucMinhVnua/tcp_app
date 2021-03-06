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
          title: Text("B??? sung ?????a ??i???m c??ng t??c"),
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
                                "Danh s??ch ?????a ??i???m c??ng t??c: ${model.detailData.danhSachDiaDiemCongTac.length}",
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
                                          '?????a ??i???m c??ng t??c : ${model.detailData.danhSachDiaDiemCongTac[index].diaDiemCongTac}',
                                    },
                                    // {
                                    //   'icon': 'ic_clock',
                                    //   'content':
                                    //       'Th???i gian b???t ?????u : ${model.detailData.danhSachDiaDiemCongTac[index].thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}',
                                    // },
                                    // {
                                    //   'icon': 'ic_clock',
                                    //   'content':
                                    //       'Th???i gian k???t th??c : ${model.detailData.danhSachDiaDiemCongTac[index].thoiGianKetThuc.toDate(Constant.ddMMyyyyHHmm2)}',
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
                        'B??? sung ?????a ??i???m c??ng t??c',
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
                          labelText: '?????a ??i???m c??ng vi???c',
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
                          labelText: 'M?? t???',
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
                    //       labelText: 'Th???i gian b???t ?????u',
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
                    //       labelText: 'Th???i gian k???t th??c',
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
                          if (workPlaceTextController.text.isEmpty) {
                            ToastMessage.show(
                                '?????a ??i???m c??ng t??c kh??ng ????? tr???ng',
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
                                  ? 'B??? sung th??nh c??ng'
                                  : '???? x???y ra l???i');
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
          'X??a ?????a ??i???m c??ng t??c',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'X??c nh???n x??a ?????a ??i???m c??ng t??c?',
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
            await Provider.of<MechanicalWorkSheetModel>(context, listen: false)
                .deleteWorkPlace(workSheetId, workPlaceId);
        Navigator.of(context).pop(result);
        NotificationDialog.show(
            this.context,
            result.isSuccess() ? 'ic_success' : 'ic_error',
            result.isSuccess() ? 'X??a th??nh c??ng' : '???? x???y ra l???i');
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
