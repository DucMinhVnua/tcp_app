import 'package:dropdown_search/dropdown_search.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/extension/list.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/ui/date_time_picker_widget.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/base/utils/file_utils.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/mechanical_work_sheet_model.dart';
import 'package:workflow_manager/models/response/check_in_response.dart';
import 'package:workflow_manager/models/response/check_out_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_sheets_response.dart';
import 'package:workflow_manager/models/response/sign_process_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/tpc/screens/other/custom_expandable_panel.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class MechanicalWorkSheetArguments {
  MechanicalWorkSheet mechanicalWorkSheet;

  MechanicalWorkSheetArguments({
    this.mechanicalWorkSheet,
  });
}

class MechanicalWorkSheetDetailScreen extends StatefulWidget {
  final MechanicalWorkSheet mechanicalWorkSheet;

  const MechanicalWorkSheetDetailScreen({
    this.mechanicalWorkSheet,
  });

  @override
  State<StatefulWidget> createState() {
    return _MechanicalWorkSheetDetailScreenState();
  }
}

class _MechanicalWorkSheetDetailScreenState
    extends State<MechanicalWorkSheetDetailScreen> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chi ti???t phi???u c??ng t??c CNH"),
      ),
      body: Consumer<MechanicalWorkSheetModel>(
        builder: (_, model, __) => (model.detailData == null ||
                model.detailData.thongTinChung.iD !=
                    widget.mechanicalWorkSheet.iD)
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
                            'content': model.detailData.thongTinChung.noiDung,
                            'color': kWorkSheetStatusColor[
                                EnumToString.convertToString(
                                    widget.mechanicalWorkSheet.getStatus())],
                          },
                          {
                            'status':
                                widget.mechanicalWorkSheet.getStatusName(),
                            'color': kWorkSheetStatusColor[
                                EnumToString.convertToString(
                                    widget.mechanicalWorkSheet.getStatus())],
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'S??? phi???u : ${model.detailData.thongTinChung.code}',
                          },
                          {
                            'icon': 'ic_avatar',
                            'content':
                                'Ch??? huy tr???c ti???p : ${model.detailData.thongTinChung.nguoiChiHuy}',
                          },
                          {
                            'icon': 'ic_clock',
                            'content':
                                'Ng??y l???p phi???u : ${model.detailData.thongTinChung.ngayLap.toDate(Constant.ddMMyyyyHHmm2)}',
                          },
                          {
                            'icon': 'ic_location',
                            'content':
                                '?????a ??i???m : ${model.detailData.thongTinChung.diaDiem}',
                          },
                          {
                            'icon': 'ic_avatar',
                            'content':
                                'N???i dung c??ng vi???c : ${model.detailData.thongTinChung.noiDung}',
                          },
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
                      headerTitle: 'Danh s??ch nh???n di???n m???i nguy v?? an to??n',
                      contentExpanded: _buildDanhSachNhanDienMoiNguy(model),
                      initExpanded: (model
                              .detailData.danhSachNhanDienMoiNguy.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Ph???n B: Cho ph??p c??ng t??c',
                      contentExpanded:
                          _buildDanhSachKiemTraCacBienPhapAnToanCP(model),
                      initExpanded: (model.detailData
                              .danhSachKiemTraCacBienPhapAnToanCP.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Ph???n C: Th???c hi???n c??ng t??c',
                      contentExpanded:
                          _buildDanhSachKiemTraCacBienPhapAnToanCH(model),
                      initExpanded: (model.detailData
                              .danhSachKiemTraCacBienPhapAnToanCH.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Danh s??ch nh??n vi??n ????n v???',
                      contentExpanded: _buildDanhSachNhanVien(model),
                      initExpanded:
                          (model.detailData.danhSachNhanVien.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: '?????a ??i???m c??ng t??c',
                      contentExpanded: _buildDanhSachDiaDiemCongTac(model),
                      initExpanded: (model
                              .detailData.danhSachDiaDiemCongTac.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Ng?????i ch??? huy tr???c ti???p',
                      contentExpanded: _buildDirectCommanderList(model),
                      initExpanded: (model.detailData.danhSachCapNhapNguoiChiHuy
                              .isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'L???ch s??? ?????i ca',
                      contentExpanded: _buildChangeShiftLeaderHistory(model),
                      initExpanded: (model.detailData.danhSachLichSuDoiCa
                          .isNullOrEmpty)
                          ? false
                          : true,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildGeneralInfo(MechanicalWorkSheetModel model) {
    return ListItemGeneralInfo(
      itemPairsData: [
        {
          'content':
              'S??? phi???u c??ng t??c : ${model.detailData.thongTinChung.code}',
        },
        {
          'content':
              'Ng??y l???p phi???u : ${model.detailData.thongTinChung.ngayLap.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Ng?????i l???p phi???u : ${model.detailData.thongTinChung.nguoiLap}',
        },
        {
          'content':
              'Ng?????i c???p phi???u : ${model.detailData.thongTinChung.nguoiCap}',
        },
        {
          'content':
              'T??n ????n v??? c???p phi???u : ${model.detailData.thongTinChung.donViCap}',
        },
        {
          'content':
              'Ng?????i cho ph??p : ${model.detailData.thongTinChung.nguoiChoPhep}',
        },
        {
          'content':
              'Ng?????i cho ph??p t???i ch??? : ${model.detailData.thongTinChung.nguoiChoPhepTaiCho}',
        },
        {
          'content':
              'Ng?????i ch??? huy tr???c ti???p : ${model.detailData.thongTinChung.nguoiChiHuy}',
        },
        {
          'content': '?????a ??i???m : ${model.detailData.thongTinChung.diaDiem}',
        },
        {
          'content': 'N???i dung : ${model.detailData.thongTinChung.noiDung}',
        },
        {
          'content': 'Ph???m vi : ${model.detailData.thongTinChung.phamVi}',
        },
        {
          'content':
              'Th???i gian t??? : ${model.detailData.thongTinChung.thoiGianTu.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Th???i gian ?????n : ${model.detailData.thongTinChung.thoiGianDen.toDate(Constant.ddMMyyyyHHmm2)}',
        },
      ],
      showActions: true,
      onTap: () {
        _viewSignProcess(context, model);
      },
    );
  }

  Widget _buildDanhSachNhanDienMoiNguy(MechanicalWorkSheetModel model) {
    if (model.detailData.danhSachNhanDienMoiNguy.isNullOrEmpty) {
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
                  i < model.detailData.danhSachNhanDienMoiNguy.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachNhanDienMoiNguy[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Nh???n di???n m???i nguy : ${model.detailData.danhSachNhanDienMoiNguy[i].nhanDienMoiNguy}'
                    },
                    {
                      'content':
                          'Bi???n ph??p an to??n : ${model.detailData.danhSachNhanDienMoiNguy[i].bienPhapAnToan}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachNhanDienMoiNguy.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachKiemTraCacBienPhapAnToanCP(
      MechanicalWorkSheetModel model) {
    if (model.detailData.danhSachKiemTraCacBienPhapAnToanCP.isNullOrEmpty) {
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
                  i <
                      model
                          .detailData.danhSachKiemTraCacBienPhapAnToanCP.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachKiemTraCacBienPhapAnToanCP[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Ki???m tra c??c bi???n ph??p an to??n cho ph??p : ${model.detailData.danhSachKiemTraCacBienPhapAnToanCP[i].kiemTraCacBienPhap}'
                    },
                    {
                      'content':
                          '????nh d???u : ${model.detailData.danhSachKiemTraCacBienPhapAnToanCP[i].danhDau}'
                    },
                    {
                      'content':
                          'Ghi ch?? : ${model.detailData.danhSachKiemTraCacBienPhapAnToanCP[i].ghiChu}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem: i ==
                          model.detailData.danhSachKiemTraCacBienPhapAnToanCP
                                  .length -
                              1
                      ? true
                      : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachKiemTraCacBienPhapAnToanCH(
      MechanicalWorkSheetModel model) {
    if (model.detailData.danhSachKiemTraCacBienPhapAnToanCH.isNullOrEmpty) {
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
                  i <
                      model
                          .detailData.danhSachKiemTraCacBienPhapAnToanCH.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachKiemTraCacBienPhapAnToanCH[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Ki???m tra c??c bi???n ph??p an to??n cho ph??p : ${model.detailData.danhSachKiemTraCacBienPhapAnToanCH[i].kiemTraCacBienPhap}'
                    },
                    {
                      'content':
                          '????nh d???u : ${model.detailData.danhSachKiemTraCacBienPhapAnToanCH[i].danhDau}'
                    },
                    {
                      'content':
                          'Ghi ch?? : ${model.detailData.danhSachKiemTraCacBienPhapAnToanCH[i].ghiChu}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem: i ==
                          model.detailData.danhSachKiemTraCacBienPhapAnToanCH
                                  .length -
                              1
                      ? true
                      : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachNhanVien(MechanicalWorkSheetModel model) {
    if (model.detailData.danhSachNhanVien.isNullOrEmpty) {
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
                  visible: !model.detailData.danhSachNhanVien.isNullOrEmpty &&
                      model.detailData.isXacNhanCoMatDayDu,
                  child: Column(
                    children: [
                      Divider(
                        height: 1,
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                      _buildMemberJoinActions(model),
                    ],
                  )),
              SizedBox(height: 12),
              for (var i = 0; i < model.detailData.danhSachNhanVien.length; i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachNhanVien[i].iDThamGia}',
                  itemPairsData: [
                    {
                      'content':
                          'Th???i gian b??? sung : ${model.detailData.danhSachNhanVien[i].ngay.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'H??? v?? t??n : ${model.detailData.danhSachNhanVien[i].hoVaTen}'
                    },
                    {
                      'content':
                          'S??? th??? an to??n : ${model.detailData.danhSachNhanVien[i].soTheATD}'
                    },
                    {
                      'content':
                          'Th???i gian ?????n l??m vi???c : ${model.detailData.danhSachNhanVien[i].thoiGianDenLamViec.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Th???i gian r??t kh???i : ${model.detailData.danhSachNhanVien[i].thoiGianRutKhoi.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                  ],
                  showActions:
                      (model.detailData.danhSachNhanVien[i].isChiHuyXacNhan ||
                          model.detailData.danhSachNhanVien[i]
                              .isNguoiChoPhepTaiChoXacNhan ||
                          model.detailData.danhSachNhanVien[i]
                              .isNguoiChoPhepXacNhan),
                  actionLabel: 'X??C NH???N',
                  onTapAction: () {
                    String withdrawType = '';
                    int type = 0;
                    if (model.detailData.danhSachNhanVien[i].isChiHuyXacNhan) {
                      withdrawType = 'R??t kh???i c???a Ch??? Huy';
                      type = 1;
                    } else if (model.detailData.danhSachNhanVien[i]
                        .isNguoiChoPhepTaiChoXacNhan) {
                      withdrawType = 'R??t kh???i c???a Ng?????i Cho Ph??p t???i ch???';
                      type = 2;
                    } else if (model
                        .detailData.danhSachNhanVien[i].isNguoiChoPhepXacNhan) {
                      withdrawType = 'R??t kh???i c???a Ng?????i Cho ph??p';
                      type = 3;
                    }
                    _showDialogConfirmWithdraw(
                        context,
                        model,
                        model.detailData.danhSachNhanVien[i].iDThamGia,
                        withdrawType,
                        type);
                  },
                  showActions2:
                      model.detailData.danhSachNhanVien[i].isXacNhanRutKhoi,
                  actionLabel2: 'CHECK OUT',
                  onTapAction2: () {
                    _showDialogMemberCheckOut(context, model,
                        model.detailData.danhSachNhanVien[i].iDThamGia);
                  },
                  showActions3:
                      model.detailData.danhSachNhanVien[i].isActionCheckin,
                  actionLabel3: 'CHECK IN',
                  onTapAction3: () {
                    _showDialogCheckIn(context, model,
                        model.detailData.danhSachNhanVien[i].iDThamGia);
                  },
                  onTap: () {},
                  isLastItem: i == model.detailData.danhSachNhanVien.length - 1
                      ? true
                      : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachDiaDiemCongTac(MechanicalWorkSheetModel model) {
    if (model.detailData.danhSachDiaDiemCongTac.isNullOrEmpty) {
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
                  i < model.detailData.danhSachDiaDiemCongTac.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachDiaDiemCongTac[i].iDDiaDiem}',
                  itemPairsData: [
                    {
                      'content':
                          '?????a ??i???m c??ng t??c : ${model.detailData.danhSachDiaDiemCongTac[i].diaDiemCongTac}'
                    },
                    {
                      'content':
                          'Th???i gian b???t ?????u : ${model.detailData.danhSachDiaDiemCongTac[i].thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Th???i gian k???t th??c : ${model.detailData.danhSachDiaDiemCongTac[i].thoiGianKetThuc.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Ng?????i ch??? huy tr???c ti???p : ${model.detailData.danhSachDiaDiemCongTac[i].nguoiChiHuyXacNhanBD}'
                    },
                    {
                      'content':
                          'Ng?????i cho ph??p : ${model.detailData.danhSachDiaDiemCongTac[i].nguoiChoPhepXacNhanBD}'
                    },
                    {
                      'content':
                          'Ng?????i cho ph??p t???i ch??? : ${model.detailData.danhSachDiaDiemCongTac[i].nguoiChoPhepTaiChoBD}'
                    },
                  ],
                  showActions: (model.detailData.danhSachDiaDiemCongTac[i]
                          .isChiHuyXacNhanBD ||
                      model.detailData.danhSachDiaDiemCongTac[i]
                          .isChiHuyXacNhanKT ||
                      model.detailData.danhSachDiaDiemCongTac[i]
                          .isNguoiChoPhepXacNhanBD ||
                      model.detailData.danhSachDiaDiemCongTac[i]
                          .isNguoiChoPhepXacNhanKT ||
                      model.detailData.danhSachDiaDiemCongTac[i]
                          .isNguoiChoPhepTaiChoXacNhanBD ||
                      model.detailData.danhSachDiaDiemCongTac[i]
                          .isNguoiChoPhepTaiChoXacNhanKT),
                  actionLabel: 'X??C NH???N',
                  onTapAction: () {
                    String actionType = '';
                    int typeUser = 1;
                    int typeTime = 1;
                    if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isChiHuyXacNhanBD) {
                      actionType = 'Ch??? huy x??c nh???n b???t ?????u';
                      typeUser = 1;
                      typeTime = 1;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isChiHuyXacNhanKT) {
                      actionType = 'Ch??? huy x??c nh???n k???t th??c';
                      typeUser = 1;
                      typeTime = 2;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isNguoiChoPhepXacNhanBD) {
                      actionType = 'Ng?????i cho ph??p x??c nh???n b???t ?????u';
                      typeUser = 2;
                      typeTime = 1;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isNguoiChoPhepXacNhanKT) {
                      actionType = 'Ng?????i cho ph??p x??c nh???n k???t th??c';
                      typeUser = 2;
                      typeTime = 2;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isNguoiChoPhepTaiChoXacNhanBD) {
                      actionType = 'Ng?????i cho ph??p t???i ch??? x??c nh???n b???t ?????u';
                      typeUser = 3;
                      typeTime = 1;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isNguoiChoPhepTaiChoXacNhanKT) {
                      actionType = 'Ng?????i cho ph??p t???i ch??? x??c nh???n k???t th??c';
                      typeUser = 3;
                      typeTime = 2;
                    }
                    _showDialogConfirmLocation(
                        context,
                        model,
                        model.detailData.danhSachDiaDiemCongTac[i].iDDiaDiem,
                        actionType,
                        typeUser,
                        typeTime);
                  },
                  isLastItem:
                      i == model.detailData.danhSachDiaDiemCongTac.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDirectCommanderList(MechanicalWorkSheetModel model) {
    if (model.detailData.danhSachCapNhapNguoiChiHuy.isNullOrEmpty) {
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
              i < model.detailData.danhSachCapNhapNguoiChiHuy.length;
              i++)
                ListItemZebraStyle(
                  itemTitle:
                  '${i + 1}. ${model.detailData.danhSachCapNhapNguoiChiHuy[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                      'Ch??? huy tr???c ti???p c??	: ${model.detailData.danhSachCapNhapNguoiChiHuy[i].chiHuyTrucTiepCu}'
                    },
                    {
                      'content':
                      'Th???i gian th??ng b??o ?????i ca : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].thoiGianThongBaoDoiCa.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                      'Ch??? huy tr???c ti???p m???i : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].chiHuyTrucTiepMoi}'
                    },
                    {
                      'content':
                      'Th???i gian x??c nh???n : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].thoiGianXacNhan.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    //TODO API missing ?
                    // {
                    //   'content':
                    //   'L?? do : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].}'
                    // },
                  ],
                  showActions: (model
                      .detailData.danhSachCapNhapNguoiChiHuy[i].isXacNhan),
                  actionLabel: 'X??C NH???N',
                  onTapAction: () {
                    _showDialogConfirmChangeShiftLeader(context, model,
                        model.detailData.danhSachCapNhapNguoiChiHuy[i].iD);
                  },
                  onTap: () {},
                  statusWidget: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 4, top: 8, bottom: 8),
                            child: Text(
                              'Tr???ng th??i : ',
                              textAlign: TextAlign.start,
                              style: kDefaultTextStyle,
                            ),
                          ),
                          Container(
                            child: Text(
                              model.detailData.danhSachCapNhapNguoiChiHuy[i]
                                  .trangThai,
                              style: kDefaultTextStyle.copyWith(
                                  color: HexColor(kConfirmCommanderStatus[
                                  EnumToString.convertToString(model
                                      .detailData
                                      .danhSachCapNhapNguoiChiHuy[i]
                                      .getStatus())]),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: HexColor(kConfirmCommanderStatus[
                                EnumToString.convertToString(model
                                    .detailData
                                    .danhSachCapNhapNguoiChiHuy[i]
                                    .getStatus())])
                                    .withOpacity(0.25)),
                          ),
                        ],
                      )),
                  isLastItem: i ==
                      model.detailData.danhSachCapNhapNguoiChiHuy.length - 1
                      ? true
                      : false,
                )
            ],
          )),
    );
  }

  Widget _buildChangeShiftLeaderHistory(MechanicalWorkSheetModel model) {
    if (model.detailData.danhSachLichSuDoiCa.isNullOrEmpty) {
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
              i < model.detailData.danhSachLichSuDoiCa.length;
              i++)
                ListItemZebraStyle(
                  itemTitle:
                  '${i + 1}. ${model.detailData.danhSachLichSuDoiCa[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                      'Tr?????ng ca c??: ${model.detailData.danhSachLichSuDoiCa[i].truongCaCu}'
                    },
                    {
                      'content':
                      'Tr?????ng ca m???i : ${model.detailData.danhSachLichSuDoiCa[i].truongCaMoi}'
                    },
                    {
                      'content':
                      '	N???i dung : ${model.detailData.danhSachLichSuDoiCa[i].noiDung}'
                    },
                  ],
                  isLastItem: i ==
                      model.detailData.danhSachCapNhapNguoiChiHuy.length - 1
                      ? true
                      : false,
                )
            ],
          )),
    );
  }

  Future<void> _showDialogConfirmWithdraw(
      BuildContext context,
      MechanicalWorkSheetModel model,
      int userId,
      String withdrawType,
      int type) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'X??c nh???n r??t kh???i',
            textAlign: TextAlign.center,
            style: kMediumBlackTextStyle,
          ),
        ),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              withdrawType,
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
          StatusResponse result = await model.confirmWithdraw(
              model.detailData.thongTinChung.iD, userId, type);
          Navigator.of(context).pop(result);
        },
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess() ? 'R??t kh???i th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }

  Future<void> _showDialogMemberCheckOut(
      BuildContext context, MechanicalWorkSheetModel model, int userId) async {
    IsCheckOutResponse isCheckOutResponse =
        await model.isCheckOut(model.detailData.thongTinChung.iD, userId);

    List<DanhSachChuKy> _allSign = isCheckOutResponse.data.danhSachChuKy;
    DanhSachChuKy _selectedSign;

    List<LoaiRutKhois> _allCheckOutType = isCheckOutResponse.data.loaiRutKhois;
    LoaiRutKhois _selectedCheckOutType;

    if (_allSign.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Kh??ng c?? ch??? k?? n??o');
      return;
    }

    if (_allCheckOutType.isNullOrEmpty) {
      NotificationDialog.show(
          context, 'ic_error', 'Kh??ng c?? lo???i r??t kh???i n??o');
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
                      'X??c nh???n r??t kh???i',
                      textAlign: TextAlign.center,
                      style: kMediumBlackTextStyle,
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: kGrey1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 0, bottom: 16),
                    child: DropdownSearch<LoaiRutKhois>(
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
                      items: _allCheckOutType,
                      itemAsString: (LoaiRutKhois member) => member.text,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kBlue1),
                        ),
                        hintText: 'Ch???n lo???i r??t kh???i',
                        hintStyle: kDefaultTextStyle.copyWith(color: kGrey2),
                      ),
                      onChanged: (LoaiRutKhois type) {
                        setState(() {
                          _selectedCheckOutType = type;
                        });
                      },
                    ),
                  ),
                ],
              ),
              titlePadding: EdgeInsets.symmetric(horizontal: 0),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              content: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _allSign.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 6 / 5),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (_allSign[index] == _selectedSign) {
                              _selectedSign = null;
                            } else {
                              _selectedSign = _allSign[index];
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: (_selectedSign == _allSign[index])
                                  ? kColorPrimary
                                  : kGrey1,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        child: Container(
                                          color: kGrey5,
                                          child: Image.network(
                                              "${_allSign[index].duongDan}",
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            (_selectedSign == _allSign[index])
                                                ? true
                                                : false,
                                        child: Positioned(
                                            right: 5,
                                            top: 5,
                                            child: SvgImage(
                                                svgName: "ic_tick_selected",
                                                size: 18)),
                                      ),
                                    ],
                                  )),
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  alignment: Alignment.center,
                                  child: Text("${_allSign[index].ten}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: kDefaultTextStyle.copyWith(
                                          fontSize: 13)))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              actionsPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              actions: [
                Row(
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
                          if (_selectedCheckOutType == null) {
                            ToastMessage.show(
                                'Xin ch???n lo???i r??t kh???i', ToastStyle.error);
                            return;
                          }
                          if (_selectedSign == null) {
                            ToastMessage.show(
                                'Ch???n ch??? k?? kh??ng ????? tr???ng', ToastStyle.error);
                            return;
                          }
                          final result = await model.checkOut(
                              model.detailData.thongTinChung.iD,
                              int.parse(_selectedCheckOutType.value),
                              _selectedSign.iD,
                              userId);
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
              ? 'Check out th??nh c??ng'
              : '???? x???y ra l???i, Vui l??ng th??? l???i');
      onRefresh();
    }
  }

  Future<void> _showDialogCheckIn(
      BuildContext context, MechanicalWorkSheetModel model, int userId) async {
    IsCheckInResponse isCheckInResponse =
        await model.isCheckIn(model.detailData.thongTinChung.iD, userId);

    List<DanhSachChuKy> _allSign = isCheckInResponse.data.danhSachChuKy;
    DanhSachChuKy _selectedSign;

    if (_allSign.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Kh??ng c?? ch??? k?? n??o');
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
                      'X??c nh???n checkin',
                      textAlign: TextAlign.center,
                      style: kMediumBlackTextStyle,
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: kGrey1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 8, left: 12, right: 12),
                    child: Text(
                      'Vui l??ng ch???n ch??? k??',
                      textAlign: TextAlign.center,
                      style: kDefaultTextStyle.copyWith(color: kGrey2),
                    ),
                  ),
                ],
              ),
              titlePadding: EdgeInsets.symmetric(horizontal: 0),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              content: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _allSign.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 6 / 5),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (_allSign[index] == _selectedSign) {
                              _selectedSign = null;
                            } else {
                              _selectedSign = _allSign[index];
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: (_selectedSign == _allSign[index])
                                  ? kColorPrimary
                                  : kGrey1,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        child: Container(
                                          color: kGrey5,
                                          child: Image.network(
                                              "${_allSign[index].duongDan}",
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            (_selectedSign == _allSign[index])
                                                ? true
                                                : false,
                                        child: Positioned(
                                            right: 5,
                                            top: 5,
                                            child: SvgImage(
                                                svgName: "ic_tick_selected",
                                                size: 18)),
                                      ),
                                    ],
                                  )),
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  alignment: Alignment.center,
                                  child: Text("${_allSign[index].ten}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: kDefaultTextStyle.copyWith(
                                          fontSize: 13)))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              actionsPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              actions: [
                Row(
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
                          if (_selectedSign == null) {
                            ToastMessage.show(
                                'Ch???n ch??? k?? kh??ng ????? tr???ng', ToastStyle.error);
                            return;
                          }
                          final result = await model.checkIn(
                              model.detailData.thongTinChung.iD,
                              userId,
                              _selectedSign.iD);
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
              ? 'Check in th??nh c??ng'
              : '???? x???y ra l???i, Vui l??ng th??? l???i');
      onRefresh();
    }
  }

  Widget _buildMemberJoinActions(MechanicalWorkSheetModel model) {
    return Container(
      color: kGrey4,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: model.detailData.isXacNhanCoMatDayDu,
            child: InkWell(
              onTap: () => _showDialogConfirmAttendance(context, model),
              child: Container(
                child: Text(
                  'X??C NH???N C?? M???T ?????Y ?????',
                  style: kDefaultTextStyle.copyWith(color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: kBlue2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialogConfirmAttendance(
      BuildContext context, MechanicalWorkSheetModel model) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'X??c nh???n check in ?????y ?????',
            textAlign: TextAlign.center,
            style: kMediumBlackTextStyle,
          ),
        ),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'X??c nh???n c?? m???t ?????y ??????',
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
          StatusResponse result =
              await model.confirmAttendance(model.detailData.thongTinChung.iD);
          Navigator.of(context).pop(result);
        },
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess() ? 'X??c nh???n th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }

  Future<void> _showDialogConfirmLocation(
      BuildContext context,
      MechanicalWorkSheetModel model,
      int locationId,
      String actionType,
      int typeUser,
      int typeTime) async {
    IsCheckInResponse isCheckInResponse =
        await model.isConfirmLocation(model.detailData.thongTinChung.iD);

    List<DanhSachChuKy> _allSign = isCheckInResponse.data.danhSachChuKy;
    DanhSachChuKy _selectedSign;

    TextEditingController dateTextController = TextEditingController();

    if (_allSign.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Kh??ng c?? ch??? k?? n??o');
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
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              titlePadding: EdgeInsets.symmetric(horizontal: 0),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'X??c nh???n tr??nh t???',
                      textAlign: TextAlign.center,
                      style: kMediumBlackTextStyle,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: kGrey2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      actionType,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Visibility(
                      visible: (typeUser == 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: TextField(
                          controller: dateTextController,
                          readOnly: true,
                          onTap: () {
                            DateTimePickerWidget(
                                    context: context,
                                    format: Constant.ddMMyyyyHHmm2,
                                    onDateTimeSelected: (value) {
                                      setState(() {
                                        dateTextController.text = value;
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
                            labelText:
                                'Th???i gian ${typeTime == 1 ? 'b???t ?????u' : 'k???t th??c'}',
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
                      )),
                ],
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _allSign.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 6 / 5),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_allSign[index] == _selectedSign) {
                                _selectedSign = null;
                              } else {
                                _selectedSign = _allSign[index];
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: (_selectedSign == _allSign[index])
                                    ? kColorPrimary
                                    : kGrey1,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          child: Container(
                                            color: kGrey5,
                                            child: Image.network(
                                                "${_allSign[index].duongDan}",
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              (_selectedSign == _allSign[index])
                                                  ? true
                                                  : false,
                                          child: Positioned(
                                              right: 5,
                                              top: 5,
                                              child: SvgImage(
                                                  svgName: "ic_tick_selected",
                                                  size: 18)),
                                        ),
                                      ],
                                    )),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    alignment: Alignment.center,
                                    child: Text("${_allSign[index].ten}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: kDefaultTextStyle.copyWith(
                                            fontSize: 13)))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
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
                          if (typeUser == 1 &&
                              dateTextController.text.isEmpty) {
                            ToastMessage.show(
                                'L???a ch???n th???i gian kh??ng ????? tr???ng',
                                ToastStyle.error);
                            return;
                          }
                          if (_selectedSign == null) {
                            ToastMessage.show(
                                'Ch???n ch??? k?? kh??ng ????? tr???ng', ToastStyle.error);
                            return;
                          }
                          String dateEpoch = dateTextController.text.isEmpty
                              ? ''
                              : '${new DateFormat(Constant.ddMMyyyyHHmm2).parse(dateTextController.text).millisecondsSinceEpoch}';
                          final result =
                              await Provider.of<MechanicalWorkSheetModel>(
                                      context,
                                      listen: false)
                                  .confirmLocation(
                                      widget.mechanicalWorkSheet.iD,
                                      locationId,
                                      typeUser,
                                      typeTime,
                                      _selectedSign.iD,
                                      (typeUser == 1) ? dateEpoch : "");
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
          result.isSuccess() ? 'X??c nh???n th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }

  Future<void> _viewSignProcess(
      BuildContext context, MechanicalWorkSheetModel model) async {
    SignProcessResponse signProcessResponse = await model.signProcess(model.detailData.thongTinChung.iD);
    if (!signProcessResponse.isSuccess()) {
      NotificationDialog.show(
          context, 'ic_error', '???? x???y ra l???i, Vui l??ng th??? l???i');
      return;
    }
    String _signProcessUrl = signProcessResponse.data.linkFileTrinhKy;
    if (_signProcessUrl.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Link tr??nh k?? l???i');
      return;
    }
    String fileName =
        'FileTrinhKy_' + DateTime.now().millisecondsSinceEpoch.toString();
    final result = await FileUtils.instance.downloadFileAndOpen(
        fileName, _signProcessUrl, context,
        isStorage: true, isNeedToken: true);
    if (result != null) {
      //Downloaded and open success
    }
  }

  Future<void> _showDialogConfirmChangeShiftLeader(BuildContext context,
      MechanicalWorkSheetModel model, int idChangeShiftLeader) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'X??c nh???n',
            textAlign: TextAlign.center,
            style: kMediumBlackTextStyle,
          ),
        ),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'B???n c?? ?????ng ?? x??c nh???n ?',
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
          StatusResponse result =
              await model.confirmChangeShiftLeader(idChangeShiftLeader);
          Navigator.of(context).pop(result);
        },
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      NotificationDialog.show(
          context,
          result.isSuccess() ? 'ic_success' : 'ic_error',
          result.isSuccess() ? 'X??c nh???n th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }
}
