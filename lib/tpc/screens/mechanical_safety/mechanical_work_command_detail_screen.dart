import 'dart:ui';

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
import 'package:workflow_manager/models/mechanical_work_command_model.dart';
import 'package:workflow_manager/models/response/check_in_response.dart';
import 'package:workflow_manager/models/response/check_out_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_commands_response.dart';
import 'package:workflow_manager/models/response/sign_process_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/tpc/screens/other/custom_expandable_panel.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class MechanicalWorkCommandArguments {
  MechanicalWorkCommand mechanicalWorkCommand;

  MechanicalWorkCommandArguments({
    this.mechanicalWorkCommand,
  });
}

class MechanicalWorkCommandDetailScreen extends StatefulWidget {
  final MechanicalWorkCommand mechanicalWorkCommand;

  const MechanicalWorkCommandDetailScreen({
    this.mechanicalWorkCommand,
  });

  @override
  State<StatefulWidget> createState() {
    return _MechanicalWorkCommandDetailScreenState();
  }
}

class _MechanicalWorkCommandDetailScreenState
    extends State<MechanicalWorkCommandDetailScreen> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chi ti???t l???nh c??ng t??c CNH"),
      ),
      body: Consumer<MechanicalWorkCommandModel>(
        builder: (_, model, __) => (model.detailData == null ||
                model.detailData.thongTinChung.iD !=
                    widget.mechanicalWorkCommand.iD)
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
                            'content':
                                model.detailData.thongTinChung.noiDungCongTac,
                            'color': kWorkCommandStatusColor[
                                EnumToString.convertToString(
                                    widget.mechanicalWorkCommand.getStatus())],
                          },
                          {
                            'status':
                                widget.mechanicalWorkCommand.getStatusName(),
                            'color': kWorkCommandStatusColor[
                                EnumToString.convertToString(
                                    widget.mechanicalWorkCommand.getStatus())],
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'S??? l???nh c??ng t??c : ${model.detailData.thongTinChung.code}',
                          },
                          {
                            'icon': 'ic_clock',
                            'content':
                                'Ng??y l???p l???nh c??ng t??c : ${model.detailData.thongTinChung.ngayLap.toDate(Constant.ddMMyyyyHHmm2)}',
                          },
                          {
                            'icon': 'ic_avatar',
                            'content':
                                'Ng?????i l???p : ${model.detailData.thongTinChung.nguoiLap}',
                          },
                          {
                            'icon': 'ic_location',
                            'content':
                                '?????a ??i???m ti???n h??nh c??ng t??c : ${model.detailData.thongTinChung.diaDiem}',
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'N???i dung : ${model.detailData.thongTinChung.noiDungCongTac}',
                          },
                        ],
                        onTap: () => {},
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
                      contentExpanded: _buildMemberJoinList(model),
                      initExpanded:
                          (model.detailData.danhSachNhanVien.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Nh???t k?? c??ng t??c t??? b???t ?????u ?????n k???t th??c',
                      contentExpanded: _buildDanhSachNhatKyCongTac(model),
                      initExpanded:
                          (model.detailData.danhSachNhatKyCongTac.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Danh s??ch ng?????i ch??? huy tr???c ti???p',
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

  Widget _buildGeneralInfo(MechanicalWorkCommandModel model) {
    return ListItemGeneralInfo(
      itemPairsData: [
        {
          'content':
              'S??? l???nh c??ng t??c : ${model.detailData.thongTinChung.code}',
        },
        {
          'content':
              'Ng??y l???p l???nh : ${model.detailData.thongTinChung.ngayLap.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Ng?????i l???p l???nh : ${model.detailData.thongTinChung.nguoiLap}',
        },
        {
          'content':
              'Ng?????i c???p phi???u : ${model.detailData.thongTinChung.nguoiCapPhieu}',
        },
        {
          'content':
              'T??n ????n v??? c???p phi???u : ${model.detailData.thongTinChung.donViCapPhieu}',
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
          'content':
              'N???i dung : ${model.detailData.thongTinChung.noiDungCongTac}',
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

  Widget _buildDanhSachNhanDienMoiNguy(MechanicalWorkCommandModel model) {
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
      MechanicalWorkCommandModel model) {
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
      MechanicalWorkCommandModel model) {
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

  Widget _buildMemberJoinList(MechanicalWorkCommandModel model) {
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
                      (model.detailData.isXacNhanCoMatDayDu ||
                          model.detailData.isActionCheckin),
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
                      '${i + 1}. ${model.detailData.danhSachNhanVien[i].iDNhanVien}',
                  itemPairsData: [
                    {
                      'content':
                          'H??? v?? t??n : ${model.detailData.danhSachNhanVien[i].hoVaTen}'
                    },
                    {
                      'content':
                          'B???c an to??n ??i???n : ${model.detailData.danhSachNhanVien[i].bacAnToanDien}'
                    },
                    {
                      'content':
                          'Th???i gian r??t kh???i : ${model.detailData.danhSachNhanVien[i].thoiGianRutKhoi.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Th???i gian ?????n l??m vi???c : ${model.detailData.danhSachNhanVien[i].thoiGianDenLamViec.toDate(Constant.ddMMyyyyHHmm2)}'
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
                        model.detailData.danhSachNhanVien[i].iDNhanVien,
                        withdrawType,
                        type);
                  },
                  showActions2:
                      model.detailData.danhSachNhanVien[i].isXacNhanRutKhoi,
                  actionLabel2: 'CHECK OUT',
                  onTapAction2: () {
                    _showDialogMemberCheckOut(context, model);
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

  Widget _buildDanhSachNhatKyCongTac(MechanicalWorkCommandModel model) {
    if (model.detailData.danhSachNhatKyCongTac.isNullOrEmpty) {
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
                  i < model.detailData.danhSachNhatKyCongTac.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachNhatKyCongTac[i].iDNhatKy}',
                  itemPairsData: [
                    {
                      'content':
                          'Nh???t k?? c??ng t??c : ${model.detailData.danhSachNhatKyCongTac[i].nhatKyCongTac}'
                    },
                    {
                      'content':
                          'Tr??nh t??? c??ng t??c NCPTC : ${model.detailData.danhSachNhatKyCongTac[i].trinhTuCongTacNCPTC}'
                    },
                    {
                      'content':
                          'Th???i gian b???t ?????u : ${model.detailData.danhSachNhatKyCongTac[i].thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Th???i gian k???t th??c : ${model.detailData.danhSachNhatKyCongTac[i].thoiGianKetThuc.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Ng?????i ch??? huy tr???c ti???p : ${model.detailData.danhSachNhatKyCongTac[i].nguoiChiHuyXacNhanBD}'
                    },
                    {
                      'content':
                          'Ng?????i cho ph??p : ${model.detailData.danhSachNhatKyCongTac[i].nguoiChoPhepXacNhanBD}'
                    },
                    {
                      'content':
                          'Ng?????i cho ph??p t???i ch??? : ${model.detailData.danhSachNhatKyCongTac[i].nguoiChoPhepTaiChoBD}'
                    },
                  ],
                  showActions: (model.detailData.danhSachNhatKyCongTac[i]
                          .isChiHuyXacNhanBD ||
                      model.detailData.danhSachNhatKyCongTac[i]
                          .isChiHuyXacNhanKT ||
                      model.detailData.danhSachNhatKyCongTac[i]
                          .isNguoiChoPhepXacNhanBD ||
                      model.detailData.danhSachNhatKyCongTac[i]
                          .isNguoiChoPhepXacNhanKT ||
                      model.detailData.danhSachNhatKyCongTac[i]
                          .isNguoiChoPhepTaiChoXacNhanBD ||
                      model.detailData.danhSachNhatKyCongTac[i]
                          .isNguoiChoPhepTaiChoXacNhanKT),
                  actionLabel: 'X??C NH???N',
                  onTapAction: () {
                    String type = '';
                    int typeUser = 1;
                    int typeTime = 1;
                    if (model.detailData.danhSachNhatKyCongTac[i]
                        .isChiHuyXacNhanBD) {
                      type = 'Ch??? huy x??c nh???n b???t ?????u';
                      typeUser = 1;
                      typeTime = 1;
                    } else if (model.detailData.danhSachNhatKyCongTac[i]
                        .isChiHuyXacNhanKT) {
                      type = 'Ch??? huy x??c nh???n k???t th??c';
                      typeUser = 1;
                      typeTime = 2;
                    } else if (model.detailData.danhSachNhatKyCongTac[i]
                        .isNguoiChoPhepXacNhanBD) {
                      type = 'Ng?????i cho ph??p x??c nh???n b???t ?????u';
                      typeUser = 2;
                      typeTime = 1;
                    } else if (model.detailData.danhSachNhatKyCongTac[i]
                        .isNguoiChoPhepXacNhanKT) {
                      type = 'Ng?????i cho ph??p x??c nh???n k???t th??c';
                      typeUser = 2;
                      typeTime = 2;
                    } else if (model.detailData.danhSachNhatKyCongTac[i]
                        .isNguoiChoPhepTaiChoXacNhanBD) {
                      type = 'Ng?????i cho ph??p t???i ch??? x??c nh???n b???t ?????u';
                      typeUser = 3;
                      typeTime = 1;
                    } else if (model.detailData.danhSachNhatKyCongTac[i]
                        .isNguoiChoPhepTaiChoXacNhanKT) {
                      type = 'Ng?????i cho ph??p t???i ch??? x??c nh???n k???t th??c';
                      typeUser = 3;
                      typeTime = 2;
                    }
                    _showDialogConfirmDiary(
                        context,
                        model,
                        model.detailData.danhSachNhatKyCongTac[i].iDNhatKy,
                        type,
                        typeUser,
                        typeTime);
                  },
                  isLastItem:
                      i == model.detailData.danhSachNhatKyCongTac.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDirectCommanderList(MechanicalWorkCommandModel model) {
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
                    {
                      'content':
                      'L?? do : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].lyDo}'
                    },
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

  Widget _buildMemberJoinActions(MechanicalWorkCommandModel model) {
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
          Visibility(
            visible: model.detailData.isActionCheckin,
            child: InkWell(
              onTap: () => _showDialogCheckIn(context, model),
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  'CHECK IN',
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

  Widget _buildChangeShiftLeaderHistory(MechanicalWorkCommandModel model) {
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

  Future<void> _showDialogCheckIn(
      BuildContext context, MechanicalWorkCommandModel model) async {
    IsCheckInResponse isCheckInResponse =
        await model.isCheckIn(model.detailData.thongTinChung.iD);

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
                      'X??c nh???n check in, vui l??ng ch???n ch??? k??',
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

  Future<void> _showDialogConfirmAttendance(
      BuildContext context, MechanicalWorkCommandModel model) async {
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

  Future<void> _showDialogConfirmWithdraw(
      BuildContext context,
      MechanicalWorkCommandModel model,
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
      BuildContext context, MechanicalWorkCommandModel model) async {
    IsCheckOutResponse isCheckOutResponse =
        await model.isCheckOut(model.detailData.thongTinChung.iD);

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
          result.isSuccess() ? 'Check out th??nh c??ng' : '???? x???y ra l???i');
      onRefresh();
    }
  }

  Future<void> _showDialogConfirmDiary(
      BuildContext context,
      MechanicalWorkCommandModel model,
      int diaryId,
      String locationType,
      int typeUser,
      int typeTime) async {
    IsCheckInResponse isCheckInResponse =
        await model.isConfirmDiary(model.detailData.thongTinChung.iD, diaryId);

    List<DanhSachChuKy> _allSign = isCheckInResponse.data.danhSachChuKy;
    DanhSachChuKy _selectedSign;

    TextEditingController dateTextController = TextEditingController();
    TextEditingController trinhTuCongTacNCPTCTextController = TextEditingController();

    if (_allSign.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Kh??ng c?? ch??? k?? n??o');
      return;
    }

    if (isCheckInResponse.data.trinhTuCongTacNCPTC.isNotNullOrEmpty) {
      trinhTuCongTacNCPTCTextController.text =
          isCheckInResponse.data.trinhTuCongTacNCPTC;
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
              titlePadding: EdgeInsets.symmetric(horizontal: 4),
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
                      locationType,
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
                  Visibility(
                      visible: (typeUser == 3 && typeTime == 2) ||
                          (typeUser == 2 && typeTime == 2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextField(
                          controller: trinhTuCongTacNCPTCTextController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nh???t k?? c??ng t??c NCPTC',
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
                              await Provider.of<MechanicalWorkCommandModel>(
                                      context,
                                      listen: false)
                                  .confirmDiary(
                                      widget.mechanicalWorkCommand.iD,
                                      diaryId,
                                      typeUser,
                                      typeTime,
                                      _selectedSign.iD,
                                      (typeUser == 1) ? dateEpoch : "",
                                      ((typeUser == 3 && typeTime == 2) ||
                                              (typeUser == 2 && typeTime == 2))
                                          ? trinhTuCongTacNCPTCTextController
                                              .text
                                          : "");
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
      BuildContext context, MechanicalWorkCommandModel model) async {
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
      MechanicalWorkCommandModel model, int idChangeShiftLeader) async {
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
