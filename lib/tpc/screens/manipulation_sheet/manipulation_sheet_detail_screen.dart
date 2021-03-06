import 'package:dropdown_search/dropdown_search.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/extension/list.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/manipulation_sheet_model.dart';
import 'package:workflow_manager/models/response/manipulation_is_order_receiving_response.dart';
import 'package:workflow_manager/models/response/manipulation_sheet_detail_response.dart';
import 'package:workflow_manager/models/response/manipulation_sheets_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/tpc/screens/other/custom_expandable_panel.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class ManipulationSheetArguments {
  ManipulationSheet manipulationSheet;

  ManipulationSheetArguments({
    this.manipulationSheet,
  });
}

class ManipulationSheetDetailScreen extends StatefulWidget {
  final ManipulationSheet manipulationSheet;

  const ManipulationSheetDetailScreen({
    this.manipulationSheet,
  });

  @override
  State<StatefulWidget> createState() {
    return _ManipulationSheetDetailScreenState();
  }
}

class _ManipulationSheetDetailScreenState
    extends State<ManipulationSheetDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  void onRefresh() {
    Provider.of<ManipulationSheetModel>(context, listen: false)
        .getManipulationSheetDetail(widget.manipulationSheet.iD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chi ti???t phi???u thao t??c"),
      ),
      body: Consumer<ManipulationSheetModel>(
        builder: (_, model, __) => (model.detailData == null ||
                model.detailData.thongTinChung.iD !=
                    widget.manipulationSheet.iD)
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: ListItemInfo(
                        itemPairsData: [
                          {
                            'icon': 'ic_circle',
                            'content': model.detailData.thongTinChung.code,
                            'color': kManipulationSheetsStatusColor[
                                EnumToString.convertToString(
                                    widget.manipulationSheet.getStatus())],
                          },
                          {
                            'status': widget.manipulationSheet.getStatusName(),
                            'color': kManipulationSheetsStatusColor[
                                EnumToString.convertToString(
                                    widget.manipulationSheet.getStatus())],
                          },
                          {
                            'icon': 'ic_avatar',
                            'content':
                                'Ng?????i gi??m s??t : ${model.detailData.thongTinChung.nguoiGiamSat}',
                          },
                          {
                            'icon': 'ic_avatar',
                            'content':
                                'Ng?????i thao t??c : ${model.detailData.thongTinChung.nguoiThaoTac}',
                          }
                        ],
                        onTap: () {},
                        showActions: false,
                      ),
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Th??ng tin chung',
                      contentExpanded: _buildGeneralInfo(model),
                      initExpanded:
                          model.detailData.thongTinChung != null ? true : false,
                    ),
                    CustomExpandablePanel(
                      headerTitle:
                          'Giao nh???n, nghi???m thu ???????ng d??y, thi???t b??? ??i???n',
                      contentExpanded: _buildDanhSachNghiemThuDuongDay(model),
                      initExpanded: (model.detailData.danhSachNghiemThuDuongDay
                              .isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Tr??nh t??? h???ng m???c thao t??c',
                      contentExpanded: _buildDanhSachTrinhTuThaoTac(model),
                      initExpanded: (model
                              .detailData.danhSachTrinhTuThaoTac.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'C??c s??? ki???n b???t th?????ng trong thao t??c',
                      contentExpanded: _buildCapNhatSuKienBatThuong(model),
                      initExpanded: true,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildGeneralInfo(ManipulationSheetModel model) {
    return ListItemGeneralInfo(
      itemPairsData: [
        {
          'content': 'M?? phi???u : ${model.detailData.thongTinChung.code}',
        },
        {
          'content':
              'T??n phi???u thao t??c : ${model.detailData.thongTinChung.tenPhieu}',
        },
        {
          'content':
              'Ng?????i vi???t phi???u : ${model.detailData.thongTinChung.nguoiVietPhieu}',
        },
        {
          'content':
              'Ng?????i duy???t phi???u : ${model.detailData.thongTinChung.nguoiDuyetPhieu}',
        },
        {
          'content':
              'Ng?????i gi??m s??t : ${model.detailData.thongTinChung.nguoiGiamSat}',
        },
        {
          'content':
              'Ng?????i thao t??c : ${model.detailData.thongTinChung.nguoiThaoTac}',
        },
        {
          'content':
              'M???c ????ch thao t??c : ${model.detailData.thongTinChung.mucDichThaoTac}',
        },
        {
          'content':
              'Th???i gian d??? ki???n b???t ?????u : ${model.detailData.thongTinChung.thoiGianDuKienBatDau.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Th???i gian d??? ki???n k???t th??c : ${model.detailData.thongTinChung.thoiGianDuKienKetThuc.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              '????n v??? ????? ngh??? thao t??c : ${model.detailData.thongTinChung.donViDeNghiThaoTac}',
        },
        {
          'content':
              '??i???u ki???n c???n ????? th???c hi???n : ${model.detailData.thongTinChung.dieuKienCanDeThucHien}',
        },
        {
          'content': 'L??u ?? : ${model.detailData.thongTinChung.luuY}',
        },
      ],
    );
  }

  Widget _buildDanhSachNghiemThuDuongDay(ManipulationSheetModel model) {
    if (model.detailData.danhSachNghiemThuDuongDay.isNullOrEmpty) {
      return Container();
    }
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0;
                  i < model.detailData.danhSachNghiemThuDuongDay.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachNghiemThuDuongDay[i].noiDung}',
                  itemPairsData: [
                    {
                      'content':
                          'Th???i gian : ${model.detailData.danhSachNghiemThuDuongDay[i].thoiGian.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          '????n v??? : ${model.detailData.danhSachNghiemThuDuongDay[i].donVi}'
                    },
                    {
                      'content':
                          'H??? t??n : ${model.detailData.danhSachNghiemThuDuongDay[i].hoTen}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachNghiemThuDuongDay.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachTrinhTuThaoTac(ManipulationSheetModel model) {
    if (model.detailData.danhSachTrinhTuThaoTac.isNullOrEmpty) {
      return Container();
    }
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(
                  visible: model.detailData.isCapNhapTrinhTu,
                  child: Column(
                    children: [
                      Divider(
                        height: 1,
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                      _buildCapNhatTrinhTuActions(model),
                    ],
                  )),
              SizedBox(height: 12),
              for (var i = 0;
                  i < model.detailData.danhSachTrinhTuThaoTac.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachTrinhTuThaoTac[i].muc}',
                  itemPairsData: [
                    {
                      'content':
                          '?????a ??i???m : ${model.detailData.danhSachTrinhTuThaoTac[i].diaDiem}'
                    },
                    {
                      'content':
                          'B?????c	 : ${model.detailData.danhSachTrinhTuThaoTac[i].buoc}'
                    },
                    {
                      'content':
                          'N???i dung : ${model.detailData.danhSachTrinhTuThaoTac[i].noiDung}'
                    },
                    {
                      'content':
                          '???? th???c hi???n : ${model.detailData.danhSachTrinhTuThaoTac[i].daThucHien}'
                    },
                    {
                      'content':
                          'Th???i gian b???t ?????u : ${model.detailData.danhSachTrinhTuThaoTac[i].batDau.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Th???i gian k???t th??c : ${model.detailData.danhSachTrinhTuThaoTac[i].ketThuc.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Ng?????i ra l???nh : ${model.detailData.danhSachTrinhTuThaoTac[i].raLenh}'
                    },
                    {
                      'content':
                          'Ng?????i nh???n l???nh : ${model.detailData.danhSachTrinhTuThaoTac[i].nhanLenh}'
                    },
                  ],
                  showActions:
                      model.detailData.danhSachTrinhTuThaoTac[i].isRaLenh,
                  actionLabel: 'RA L???NH',
                  onTapAction: () {
                    _showDialogOrderCommand(context, model,
                        model.detailData.danhSachTrinhTuThaoTac[i].iD);
                  },
                  showActions2:
                      model.detailData.danhSachTrinhTuThaoTac[i].isNhanLenh,
                  actionLabel2: 'NH???N L???NH',
                  onTapAction2: () {
                    _showDialogOrderReceiving(context, model,
                        model.detailData.danhSachTrinhTuThaoTac[i].iD);
                  },
                  showActionsEdit: model.detailData.isCapNhapTrinhTu,
                  onTapActionEdit: () {
                    _showEditSequenceDialog(context, model,
                        model.detailData.danhSachTrinhTuThaoTac[i]);
                  },
                  showActionsDelete: model.detailData.isCapNhapTrinhTu,
                  onTapActionDelete: () {
                    _showDeleteSequenceDialog(context, model,
                        model.detailData.danhSachTrinhTuThaoTac[i].iD);
                  },
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachTrinhTuThaoTac.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildCapNhatSuKienBatThuong(ManipulationSheetModel model) {
    return Container(
      color: kGrey4,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(
                  visible: model.detailData.isCapNhatSuKienBatThuong,
                  child: Column(
                    children: [
                      Divider(
                        height: 1,
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                      _buildCapNhatSuKienBatThuongActions(model),
                    ],
                  )),
              SizedBox(height: 12),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    (model.detailData.suKienBatThuong != null
                            ? model.detailData.suKienBatThuong
                            : '') +
                        '\n\n\n',
                    style: kDefaultTextStyle,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _buildCapNhatTrinhTuActions(ManipulationSheetModel model) {
    return Container(
      color: kGrey4,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'TH??M M???I TR??NH T???',
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
              onPressed: () {
                _showAddSequenceDialog(context, model);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCapNhatSuKienBatThuongActions(ManipulationSheetModel model) {
    return Container(
      color: kGrey4,
      padding: EdgeInsets.only(top: 8, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'C???P NH???T S??? KI???N B???T TH?????NG',
                style: kDefaultTextStyle.copyWith(color: Colors.white),
              ),
            ),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(kBlue2),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: kBlue2)))),
            onPressed: () {
              _showDialogConfirmUpdateUnusualEvent(context, model);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDialogConfirmUpdateUnusualEvent(
      BuildContext context, ManipulationSheetModel model) async {
    TextEditingController contentTextController = TextEditingController();

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'H??? th???ng l??u tr??? khai th??c',
            textAlign: TextAlign.center,
            style: kMediumBlackTextStyle,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: TextField(
            controller: contentTextController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'S??? ki???n b???t th?????ng trong thao t??c',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
              ),
              isDense: true,
              contentPadding: EdgeInsets.only(top: 8, bottom: 4),
            ),
          ),
        ),
        txtNegativeBtn: 'HU???',
        onTapNegativeBtn: () {
          Navigator.of(context).pop();
        },
        txtPositiveBtn: '?????NG ??',
        onTapPositiveBtn: () async {
          if (contentTextController.text.isEmpty) {
            ToastMessage.show(
                'S??? ki???n b???t th?????ng kh??ng ????? tr???ng', ToastStyle.error);
            return;
          }
          StatusResponse result = await model.updateUnusualEvent(
              model.detailData.thongTinChung.iD, contentTextController.text);
          Navigator.of(context).pop(result);
        },
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess() ? 'C???p nh???t th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }

  Future<void> _showDialogOrderReceiving(BuildContext context,
      ManipulationSheetModel model, int idSequence) async {
    ManipulationSheetIsOrderReceivingResponse isOrderReceivingResponse =
        await model.isOrderReceiving(
            model.detailData.thongTinChung.iD, idSequence);

    List<DanhSachKetQuaThucHien> _allResult =
        isOrderReceivingResponse.data.danhSachKetQuaThucHien;
    DanhSachKetQuaThucHien _selectedResult;

    if (_allResult.isNullOrEmpty) {
      NotificationDialog.show(
          context, 'ic_error', 'Kh??ng c?? k???t qu??? th???c hi???n n??o');
      return;
    }

    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'X??c nh???n nh???n l???nh',
                      textAlign: TextAlign.center,
                      style: kMediumBlackTextStyle,
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: kGrey1,
                  ),
                ],
              ),
              titlePadding: EdgeInsets.symmetric(horizontal: 0),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              content: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 0, bottom: 16),
                child: DropdownSearch<DanhSachKetQuaThucHien>(
                  mode: Mode.MENU,
                  dropdownButtonBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SvgImage(
                        svgName: 'ic_dropdown',
                        size: 6.0,
                      ),
                    );
                  },
                  items: _allResult,
                  itemAsString: (DanhSachKetQuaThucHien result) => result.text,
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    hintText: 'Ch???n k???t qu??? th???c hi???n',
                    hintStyle: kDefaultTextStyle.copyWith(color: kGrey2),
                  ),
                  onChanged: (DanhSachKetQuaThucHien type) {
                    setState(() {
                      _selectedResult = type;
                    });
                  },
                ),
              ),
              actionsPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'X??C NH???N',
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
                          if (_selectedResult == null) {
                            ToastMessage.show(
                                'Xin ch???n lo???i r??t kh???i', ToastStyle.error);
                            return;
                          }
                          final result = await model.orderReceiving(
                              model.detailData.thongTinChung.iD,
                              idSequence,
                              int.parse(_selectedResult.value));
                          Navigator.of(context).pop(result);
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
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess() ? 'Nh???n l???nh th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }

  Future<void> _showDialogOrderCommand(BuildContext context,
      ManipulationSheetModel model, int idSequence) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'X??c nh???n ra l???nh',
            textAlign: TextAlign.center,
            style: kMediumBlackTextStyle,
          ),
        ),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'B???n c?? ?????ng ?? ra l???nh ?',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        txtNegativeBtn: 'HU???',
        onTapNegativeBtn: () {
          Navigator.of(context).pop();
        },
        txtPositiveBtn: '?????NG ??',
        onTapPositiveBtn: () async {
          StatusResponse result = await model.orderCommand(
              model.detailData.thongTinChung.iD, idSequence);
          Navigator.of(context).pop(result);
        },
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess() ? 'Ra l???nh th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }

  Future<void> _showAddSequenceDialog(
      BuildContext context, ManipulationSheetModel model) async {
    TextEditingController _mucTextController = TextEditingController();
    TextEditingController _diadiemTextController = TextEditingController();
    TextEditingController _buocTextController = TextEditingController();
    TextEditingController _noiDungTextController = TextEditingController();

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
                        controller: _mucTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'M???c',
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
                        controller: _noiDungTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'N???i dung tr??nh t???',
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
                        controller: _diadiemTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: '?????a ??i???m',
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
                        controller: _buocTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'B?????c',
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
                          final result =
                              await Provider.of<ManipulationSheetModel>(context,
                                      listen: false)
                                  .addSequence(
                                      model.detailData.thongTinChung.iD,
                                      _mucTextController.text,
                                      _diadiemTextController.text,
                                      _buocTextController.text,
                                      _noiDungTextController.text);
                          Navigator.of(context).pop(result);
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
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess()
              ? 'Th??m m???i th??nh c??ng'
              : '???? x???y ra l???i, Vui l??ng th??? l???i');
      onRefresh();
    }
  }

  Future<void> _showEditSequenceDialog(BuildContext context,
      ManipulationSheetModel model, DanhSachTrinhTuThaoTac sequence) async {
    TextEditingController _mucTextController = TextEditingController();
    TextEditingController _diadiemTextController = TextEditingController();
    TextEditingController _buocTextController = TextEditingController();
    TextEditingController _noiDungTextController = TextEditingController();
    _mucTextController.text = sequence.muc.isNotNullOrEmpty ? sequence.muc : '';
    _diadiemTextController.text =
        sequence.diaDiem.isNotNullOrEmpty ? sequence.diaDiem : '';
    _buocTextController.text =
        sequence.buoc.isNotNullOrEmpty ? sequence.buoc : '';
    _noiDungTextController.text =
        sequence.noiDung.isNotNullOrEmpty ? sequence.noiDung : '';

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
                        'C???p nh???t tr??nh t???',
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
                        controller: _mucTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'M???c',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: TextField(
                        controller: _noiDungTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'N???i dung tr??nh t???',
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
                        controller: _diadiemTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: '?????a ??i???m',
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
                        controller: _buocTextController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'B?????c',
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
                            'C???P NH???T',
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
                          final result =
                              await Provider.of<ManipulationSheetModel>(context,
                                      listen: false)
                                  .editSequence(
                                      model.detailData.thongTinChung.iD,
                                      sequence.iD,
                                      _mucTextController.text,
                                      _diadiemTextController.text,
                                      _buocTextController.text,
                                      _noiDungTextController.text);
                          Navigator.of(context).pop(result);
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
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess()
              ? 'C???p nh???t th??nh c??ng'
              : '???? x???y ra l???i, Vui l??ng th??? l???i');
      onRefresh();
    }
  }

  Future<void> _showDeleteSequenceDialog(BuildContext context,
      ManipulationSheetModel model, int idSequence) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'X??c nh???n x??a tr??nh t???',
            textAlign: TextAlign.center,
            style: kMediumBlackTextStyle,
          ),
        ),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'B???n c?? ?????ng ?? x??a tr??nh t??? ?',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        txtNegativeBtn: 'HU???',
        onTapNegativeBtn: () {
          Navigator.of(context).pop();
        },
        txtPositiveBtn: '?????NG ??',
        onTapPositiveBtn: () async {
          final result = await model.deleteSequence(
              model.detailData.thongTinChung.iD, idSequence);
          Navigator.of(context).pop(result);
        },
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess() ? 'Ra l???nh th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }
}
