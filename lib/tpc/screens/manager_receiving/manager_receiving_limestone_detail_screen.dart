import 'package:dropdown_search/dropdown_search.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/extension/list.dart';
import 'package:workflow_manager/base/ui/date_time_picker_widget.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/base/utils/base_sharepreference.dart';
import 'package:workflow_manager/base/utils/file_utils.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/manager_receiving_limestone_model.dart';
import 'package:workflow_manager/models/response/list_require_receiver_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_lime_stones_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_limestone_detail_response.dart';
import 'package:workflow_manager/storage/utils/ImageUtils.dart';
import 'package:workflow_manager/tpc/screens/other/custom_expandable_panel.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class ManagerReceivingLimestoneArguments {
  ManagerReceivingLimestone managerReceivingLimestone;

  ManagerReceivingLimestoneArguments({
    this.managerReceivingLimestone,
  });
}

class ManagerReceivingLimestoneDetailScreen extends StatefulWidget {
  final ManagerReceivingLimestone managerReceivingLimestone;

  const ManagerReceivingLimestoneDetailScreen({this.managerReceivingLimestone});

  @override
  State<StatefulWidget> createState() {
    return _ManagerReceivingLimestoneDetailScreenState();
  }
}

class _ManagerReceivingLimestoneDetailScreenState
    extends State<ManagerReceivingLimestoneDetailScreen> {
  TextEditingController _contentNotificationTextController =
      TextEditingController();
  TextEditingController _requireDateTextController = TextEditingController();
  TextEditingController _requireReceiverTextController =
      TextEditingController();
  DanhSachNguoiTiepNhanYeuCau _requireReceiver;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  @override
  void dispose() {
    _contentNotificationTextController.dispose();
    _requireDateTextController.dispose();
    _requireReceiverTextController.dispose();
    super.dispose();
  }

  void onRefresh() {
    Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
        .getManagerReceivingLimestoneDetail(
            widget.managerReceivingLimestone.iD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chi ti???t ti???p nh???n"),
      ),
      body: Consumer<ManagerReceivingLimestoneModel>(
        builder: (_, model, __) => (model.detailData ==
                null /*||
            model.detailData.thongTinChung.iD != widget.managerReceivingLimestone.iD*/
            )
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: ListItemInfo(
                        itemPairsData: [
                          {
                            'content':
                                'S??? phi???u y??u c???u : ${model.detailData.thongTinChung.soPhieuYeuCau}',
                          },
                          {
                            'icon': 'ic_clock',
                            'content':
                                'Ng??y ti???p nh???n : ${model.detailData.thongTinChung.ngayGuiYeuCau.toDate(Constant.ddMMyyyyHHmm2)}',
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'S??? h???p ?????ng : ${model.detailData.thongTinChung.soHopDong}',
                          },
                          {
                            'icon': 'ic_clock',
                            'content':
                                'Ng??y h???p ?????ng : ${model.detailData.thongTinChung.ngayHopDong.toDate(Constant.ddMMyyyyHHmm2)}',
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'S??? l?????ng : ${widget.managerReceivingLimestone.soLuong}',
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'Gi?? : ${widget.managerReceivingLimestone.gia}',
                          },
                          {
                            'icon': 'ic_location',
                            'content':
                                '?????a ??i???m giao h??ng : ${model.detailData.thongTinChung.diaDiemGiaoHang}',
                          },
                        ],
                        onTap: () {},
                        showActions: false,
                      ),
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Th??ng tin chung',
                      contentExpanded: Column(
                        children: [
                          _buildGeneralInfo(model),
                          //TODO danhSachFile ThongTinChung ??
                          _buildFileListGeneralInfo(),
                        ],
                      ),
                      initExpanded: true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'G???i y??u c???u ti???p nh???n tr?????c v?? trong',
                      contentExpanded: _buildRequireReceiveBeforeList(model),
                      initExpanded: true,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildGeneralInfo(ManagerReceivingLimestoneModel model) {
    return ListItemGeneralInfo(
      itemPairsData: [
        {
          'content':
              'S??? g???i y??u c???u: ${model.detailData.thongTinChung.soPhieuYeuCau}',
        },
        {
          'content':
              'Ng??y g???i y??u c???u: ${model.detailData.thongTinChung.ngayGuiYeuCau.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Th???i gian giao h??ng t??? ng??y: ${model.detailData.thongTinChung.thoiGianGiaoHangTuNgay.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Th???i gian giao h??ng ?????n ng??y: ${model.detailData.thongTinChung.thoiGianGiaoHangDenNgay.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Phi???u ti???p nh???n ???? v??i: ${model.detailData.thongTinChung.phieuTiepNhanDaVoi}',
        },
        {
          'content': 'S??? h???p ?????ng: ${model.detailData.thongTinChung.soHopDong}',
        },
        {
          'content':
              'Ng??y h???p ?????ng: ${model.detailData.thongTinChung.ngayHopDong.toDate(Constant.ddMMyyyyHHmm2)}',
        },
      ],
    );
  }

  Widget _buildFileListGeneralInfo() {
    //TODO danhSachFile ThongTinChung ??
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                'T??i li???u ????nh k??m',
                style:
                kSmallGreyTextStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 20.0, top: 4.0, right: 20.0),
              child: Divider(
                color: kGrey1,
                thickness: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileListRequireReceive(List<DanhSachFile> danhSachFile) {
    if (danhSachFile.isNullOrEmpty) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  'T??i li???u ????nh k??m',
                  style:
                      kSmallGreyTextStyle.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                'T??i li???u ????nh k??m',
                style:
                    kSmallGreyTextStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
              ),
              child: Divider(
                color: kGrey1,
                thickness: 1.0,
              ),
            ),
            for (DanhSachFile file in danhSachFile)
              buildUploadedModelCard1(file),
          ],
        ),
      ),
    );
  }

  Widget buildUploadedModelCard1(DanhSachFile model) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 4),
              child: Image.asset(
                  ImageUtils.instance.getImageType(model.fileName),
                  height: 20,
                  fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${model.fileName}',
                        style: kDefaultTextStyle.copyWith(
                            fontWeight: FontWeight.w700, color: kColorPrimary)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text('Ng?????i t???i l??n : ${model.nguoiTai}',
                          style: kDefaultTextStyle.copyWith(
                              fontWeight: FontWeight.w700)),
                    ),
                    Text(
                        'Ng??y t???i l??n : ${model.ngayTaiLen.toDate(Constant.ddMMyyyyHHmm2)}',
                        style: kDefaultTextStyle.copyWith(
                            fontWeight: FontWeight.w700))
                  ],
                ),
              ),
            ),
            SvgImage(
              svgName: "ic_download",
              onTap: () async {
                String fileName = model.fileName;
                String root = await SharedPreferencesClass.get(
                    SharedPreferencesClass.ROOT_KEY);
                String url = '$root${model.linkDownLoad}';
                final result = await FileUtils.instance.downloadFileAndOpen(
                    fileName, url, context,
                    isStorage: true, isNeedToken: true);
                if (result != null) {
                  //Downloaded and open success
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequireReceiveBeforeList(ManagerReceivingLimestoneModel model) {
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                  _buildRequireReceiveBeforeActions(model),
                ],
              ),
              for (var i = 0;
                  i <
                      model.detailData.danhSachGuiYeuCauTruocVaTrongTiepNhan
                          .length;
                  i++)
                ListItemReceipt(
                  itemTitle: model.detailData
                      .danhSachGuiYeuCauTruocVaTrongTiepNhan[i].noiDungThongBao,
                  itemPairsData: [
                    {
                      'content': model.detailData
                          .danhSachGuiYeuCauTruocVaTrongTiepNhan[i].trangThai,
                      'color': kRequireStatusColor[EnumToString.convertToString(
                          model.detailData
                              .danhSachGuiYeuCauTruocVaTrongTiepNhan[i]
                              .getStatus())],
                    },
                    {
                      'content':
                          'N???i dung th??ng b??o : ${model.detailData.danhSachGuiYeuCauTruocVaTrongTiepNhan[i].noiDungThongBao}'
                    },
                    {
                      'content':
                          'Ng?????i g???i y??u c???u : ${model.detailData.danhSachGuiYeuCauTruocVaTrongTiepNhan[i].nguoiGuiYeuCau}'
                    },
                    {
                      'content':
                          'Ng?????i nh???n y??u c???u : ${model.detailData.danhSachGuiYeuCauTruocVaTrongTiepNhan[i].nguoiNhanYeuCau == null ? "" : model.detailData.danhSachGuiYeuCauTruocVaTrongTiepNhan[i].nguoiNhanYeuCau}'
                    },
                    {
                      'content':
                          'Th???i gian y??u c???u : ${model.detailData.danhSachGuiYeuCauTruocVaTrongTiepNhan[i].thoiGianYeuCau.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                  ],
                  showFileList: true,
                  fileList: !model.detailData
                          .danhSachGuiYeuCauTruocVaTrongTiepNhan.isNullOrEmpty
                      ? _buildFileListRequireReceive(model
                          .detailData
                          .danhSachGuiYeuCauTruocVaTrongTiepNhan[i]
                          .danhSachFile)
                      : Container(),
                  isLastItem: i ==
                          model.detailData.danhSachGuiYeuCauTruocVaTrongTiepNhan
                                  .length -
                              1
                      ? true
                      : false,
                )
            ],
          )),
    );
  }

  Widget _buildRequireReceiveBeforeActions(
      ManagerReceivingLimestoneModel model) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'TH??M Y??U C???U',
                  style: kDefaultTextStyle.copyWith(color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(kBlue2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: kBlue2)))),
              onPressed: () async {
                final responseReceiverList = await Provider.of<
                        ManagerReceivingLimestoneModel>(context, listen: false)
                    .createRequire(widget.managerReceivingLimestone
                        .iD); // TODO need change to model.detailData.thongTinChung.iD
                _displayDialogAddRequireReceipt(
                    context,
                    responseReceiverList.data.danhSachNguoiTiepNhanYeuCau,
                    true);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _displayDialogAddRequireReceipt(
      BuildContext context,
      List<DanhSachNguoiTiepNhanYeuCau> receiverList,
      bool isBeforeRequire) async {
    _contentNotificationTextController.clear();
    _requireDateTextController.text =
        DateFormat(Constant.ddMMyyyyHHmm).format(DateTime.now());
    _requireReceiverTextController.clear();
    _requireReceiver = null;

    Widget contentDialog = _contentAddAddRequireReceiptDialog(receiverList);
    CustomTwoButtonDialog dialogAddMember = CustomTwoButtonDialog(
      context: context,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Text(
          'Th??m m???i y??u c???u',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: contentDialog,
      txtNegativeBtn: 'HU???',
      onTapNegativeBtn: () {
        Navigator.of(context).pop();
      },
      txtPositiveBtn: 'TH??M',
      onTapPositiveBtn: () async {
        final response = await Provider.of<ManagerReceivingLimestoneModel>(
                context,
                listen: false)
            .sendRequireReceiveBefore(
                widget.managerReceivingLimestone.iD,
                DateFormat(Constant.ddMMyyyyHHmm)
                    .parse(_requireDateTextController.text)
                    .millisecondsSinceEpoch
                    .toString(),
                _contentNotificationTextController.text,
                _requireReceiver == null ? 0 : _requireReceiver.value);
        Navigator.of(context).pop(response);
        NotificationDialog.show(
            context,
            response.isSuccess() ? 'ic_success' : 'ic_error',
            response.isSuccess()
                ? 'X??c nh???n th??nh c??ng'
                : '???? x???y ra l???i, Vui l??ng th??? l???i');
      },
    );
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => dialogAddMember,
      barrierDismissible: false,
    );
    if (result != null) {
      onRefresh();
    }
  }

  Widget _contentAddAddRequireReceiptDialog(
      List<DanhSachNguoiTiepNhanYeuCau> receiverList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
          child: Text(
            'N???i dung th??ng b??o',
            style: kSmallGreyTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _contentNotificationTextController,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kGrey1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kBlue1),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 13.0,
                color: kBlack1,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
          child: Text(
            'Th???i gian y??u c???u',
            style: kSmallGreyTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _requireDateTextController,
            readOnly: true,
            onTap: () {
              DateTimePickerWidget(
                      context: context,
                      format: Constant.ddMMyyyyHHmm2,
                      onDateTimeSelected: (value) {
                        setState(() {
                          _requireDateTextController.text = value;
                        });
                      },
                      maxTime: DateTime.now().add(const Duration(days: 30)),
                      minTime: DateTime.now().add(const Duration(days: -30)))
                  .showDateTimePicker();
            },
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kGrey1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kBlue1),
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: kGrey2,
              ),
              isDense: true,
              suffixIconConstraints:
                  BoxConstraints(minHeight: 16.3, minWidth: 17),
              suffixIcon: SvgImage(svgName: 'ic_date_picker'),
              contentPadding: EdgeInsets.only(top: 8, bottom: 4),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
          child: Text(
            'Ng?????i nh???n y??u c???u',
            style: kSmallGreyTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownSearch<DanhSachNguoiTiepNhanYeuCau>(
            mode: Mode.BOTTOM_SHEET,
            dropdownButtonBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: SvgImage(
                  svgName: 'ic_dropdown',
                  size: 6.0,
                ),
              );
            },
            items: receiverList,
            itemAsString: (DanhSachNguoiTiepNhanYeuCau receiver) =>
                receiver.text,
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kGrey1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kBlue1),
              ),
            ),
            onChanged: (DanhSachNguoiTiepNhanYeuCau receiver) {
              _requireReceiverTextController.text = receiver.text;
              _requireReceiver = receiver;
            },
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              enableSuggestions: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                contentPadding: EdgeInsets.all(8.0),
                hintText: 'T??m ki???m ng?????i nh???n',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
