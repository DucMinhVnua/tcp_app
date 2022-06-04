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
import 'package:workflow_manager/models/response/check_in_response.dart';
import 'package:workflow_manager/models/response/check_out_response.dart';
import 'package:workflow_manager/models/response/sign_process_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/models/response/work_commands_response.dart';
import 'package:workflow_manager/models/work_command_model.dart';
import 'package:workflow_manager/tpc/screens/other/custom_expandable_panel.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class WorkCommandArguments {
  WorkCommand workCommand;

  WorkCommandArguments({
    this.workCommand,
  });
}

class WorkCommandDetailScreen extends StatefulWidget {
  final WorkCommand workCommand;

  const WorkCommandDetailScreen({
    this.workCommand,
  });

  @override
  State<StatefulWidget> createState() {
    return _WorkCommandDetailScreenState();
  }
}

class _WorkCommandDetailScreenState extends State<WorkCommandDetailScreen> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chi tiết lệnh công tác"),
      ),
      body: Consumer<WorkCommandModel>(
        builder: (_, model, __) => (model.detailData == null ||
                model.detailData.thongTinChung.iD != widget.workCommand.iD)
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
                            'content': model.detailData.thongTinChung.noiDungCongTac,
                            'color': kWorkCommandStatusColor[
                                EnumToString.convertToString(
                                    widget.workCommand.getStatus())],
                          },
                          {
                            'status': widget.workCommand.getStatusName(),
                            'color': kWorkCommandStatusColor[
                                EnumToString.convertToString(
                                    widget.workCommand.getStatus())],
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'Số lệnh công tác : ${model.detailData.thongTinChung.code}',
                          },
                          {
                            'icon': 'ic_clock',
                            'content':
                                'Ngày lập lệnh công tác : ${model.detailData.thongTinChung.ngayLap.toDate(Constant.ddMMyyyyHHmm2)}',
                          },
                          {
                            'icon': 'ic_avatar',
                            'content':
                                'Người chỉ huy : ${model.detailData.thongTinChung.nguoiChiHuy}',
                          },
                          {
                            'icon': 'ic_location',
                            'content':
                                'Địa điểm thực hiện : ${model.detailData.thongTinChung.diaDiem}',
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'Nội dung : ${model.detailData.thongTinChung.noiDungCongTac}',
                          },
                        ],
                        onTap: () => {},
                        showActions: false,
                      ),
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Thông tin chung',
                      contentExpanded: _buildGeneralInfo(model),
                      initExpanded:
                          model.detailData.thongTinChung != null ? true : false,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Danh sách nhân sự tham gia',
                      contentExpanded: _buildMemberJoinList(model),
                      initExpanded:
                          (model.detailData.danhSachNhanVien.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Trình tự công việc và điều kiện an toàn',
                      contentExpanded: _buildSequenceWorkList(model),
                      initExpanded: (model
                              .detailData.danhSachTrinhTuCongViec.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Danh sách người chỉ huy trực tiếp',
                      contentExpanded: _buildDirectCommanderList(model),
                      initExpanded: (model.detailData.danhSachCapNhapNguoiChiHuy
                              .isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Lịch sử đổi ca',
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

  Widget _buildGeneralInfo(WorkCommandModel model) {
    return ListItemGeneralInfo(
      itemPairsData: [
        {
          'content':
              'Số lệnh công tác : ${model.detailData.thongTinChung.code}',
        },
        {
          'content':
              'Ngày lập lệnh : ${model.detailData.thongTinChung.ngayLap.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Người cho phép : ${model.detailData.thongTinChung.nguoiChoPhep}',
        },
        {
          'content':
              'Người chỉ huy trực tiếp : ${model.detailData.thongTinChung.nguoiChiHuy}',
        },
        {
          'content':
              'Người cho phép tại chỗ : ${model.detailData.thongTinChung.nguoiChoPhepTaiCho}',
        },
        {
          'content':
          'Người giám sát ATĐ : ${model.detailData.thongTinChung.nguoiGiamSatATD == null ? '' : model.detailData.thongTinChung.nguoiGiamSatATD}',
        },
        {
          'content':
              'Thời gian bắt đầu : ${model.detailData.thongTinChung.thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content': 'Địa điểm : ${model.detailData.thongTinChung.diaDiem}',
        },
        {
          'content':
              'Nội dung công tác : ${model.detailData.thongTinChung.noiDungCongTac}',
        },
        {
          'content':
              'Điều kiện ATĐ : ${model.detailData.thongTinChung.dieuKienVeATD}',
        },
        {
          'content':
          'Số người tham gia công tác : ${model.detailData.thongTinChung.soNguoiThamGia}',
        },
      ],
      showActions: true,
      onTap: () {
        _viewSignProcess(context, model);
      },
    );
  }

  Widget _buildMemberJoinList(WorkCommandModel model) {
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
                          'Họ và tên : ${model.detailData.danhSachNhanVien[i].hoVaTen}'
                    },
                    {
                      'content':
                          'Bậc an toàn điện : ${model.detailData.danhSachNhanVien[i].bacAnToanDien}'
                    },
                    {
                      'content':
                          'Thời gian rút khỏi : ${model.detailData.danhSachNhanVien[i].thoiGianRutKhoi.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Thời gian đến làm việc : ${model.detailData.danhSachNhanVien[i].thoiGianDenLamViec.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                  ],
                  showActions:
                      (model.detailData.danhSachNhanVien[i].isChiHuyXacNhan ||
                          model.detailData.danhSachNhanVien[i]
                              .isNguoiChoPhepTaiChoXacNhan ||
                          model.detailData.danhSachNhanVien[i]
                              .isNguoiChoPhepXacNhan),
                  actionLabel: 'XÁC NHẬN',
                  onTapAction: () {
                    String withdrawType = '';
                    int type = 0;
                    if (model.detailData.danhSachNhanVien[i].isChiHuyXacNhan) {
                      withdrawType = 'Rút khỏi của Chỉ Huy';
                      type = 1;
                    } else if (model.detailData.danhSachNhanVien[i]
                        .isNguoiChoPhepTaiChoXacNhan) {
                      withdrawType = 'Rút khỏi của Người Cho Phép tại chỗ';
                      type = 2;
                    } else if (model
                        .detailData.danhSachNhanVien[i].isNguoiChoPhepXacNhan) {
                      withdrawType = 'Rút khỏi của Người Cho phép';
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

  Widget _buildSequenceWorkList(WorkCommandModel model) {
    if (model.detailData.danhSachTrinhTuCongViec.isNullOrEmpty) {
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
                  i < model.detailData.danhSachTrinhTuCongViec.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachTrinhTuCongViec[i].iDTrinhTu}',
                  itemPairsData: [
                    {
                      'content':
                          'Trình tự thao tác : ${model.detailData.danhSachTrinhTuCongViec[i].trinhTuThaoTac}'
                    },
                    {
                      'content':
                      'Trình tự công tác NCPTC : ${model.detailData.danhSachTrinhTuCongViec[i].trinhTuCongTacNCPTC}'
                    },
                    {
                      'content':
                          'Điều kiện an toàn : ${model.detailData.danhSachTrinhTuCongViec[i].dieuKienAnToan}'
                    },
                    {
                      'content':
                          'Thời gian bắt đầu : ${model.detailData.danhSachTrinhTuCongViec[i].thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Thời gian kết thúc : ${model.detailData.danhSachTrinhTuCongViec[i].thoiGianKetThuc.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Người chỉ huy xác nhận : ${model.detailData.danhSachTrinhTuCongViec[i].nguoiChiHuyXacNhanBD}'
                    },
                    {
                      'content':
                          'Người cho phép xác nhận : ${model.detailData.danhSachTrinhTuCongViec[i].nguoiChoPhepXacNhanBD}'
                    },
                    {
                      'content':
                          'Người cho phép tại chỗ : ${model.detailData.danhSachTrinhTuCongViec[i].nguoiChoPhepTaiChoBD}'
                    },
                  ],
                  showActions: (model.detailData.danhSachTrinhTuCongViec[i]
                          .isChiHuyXacNhanBD ||
                      model.detailData.danhSachTrinhTuCongViec[i]
                          .isChiHuyXacNhanKT ||
                      model.detailData.danhSachTrinhTuCongViec[i]
                          .isNguoiChoPhepXacNhanBD ||
                      model.detailData.danhSachTrinhTuCongViec[i]
                          .isNguoiChoPhepXacNhanKT ||
                      model.detailData.danhSachTrinhTuCongViec[i]
                          .isNguoiChoPhepTaiChoXacNhanBD ||
                      model.detailData.danhSachTrinhTuCongViec[i]
                          .isNguoiChoPhepTaiChoXacNhanKT),
                  actionLabel: 'XÁC NHẬN',
                  onTapAction: () {
                    String sequenceType = '';
                    int typeUser = 1;
                    int typeTime = 1;
                    if (model.detailData.danhSachTrinhTuCongViec[i]
                        .isChiHuyXacNhanBD) {
                      sequenceType = 'Chỉ huy xác nhận bắt đầu';
                      typeUser = 1;
                      typeTime = 1;
                    } else if (model.detailData.danhSachTrinhTuCongViec[i]
                        .isChiHuyXacNhanKT) {
                      sequenceType = 'Chỉ huy xác nhận kết thúc';
                      typeUser = 1;
                      typeTime = 2;
                    } else if (model.detailData.danhSachTrinhTuCongViec[i]
                        .isNguoiChoPhepXacNhanBD) {
                      sequenceType = 'Người cho phép xác nhận bắt đầu';
                      typeUser = 2;
                      typeTime = 1;
                    } else if (model.detailData.danhSachTrinhTuCongViec[i]
                        .isNguoiChoPhepXacNhanKT) {
                      sequenceType = 'Người cho phép xác nhận kết thúc';
                      typeUser = 2;
                      typeTime = 2;
                    } else if (model.detailData.danhSachTrinhTuCongViec[i]
                        .isNguoiChoPhepTaiChoXacNhanBD) {
                      sequenceType = 'Người cho phép tại chỗ xác nhận bắt đầu';
                      typeUser = 3;
                      typeTime = 1;
                    } else if (model.detailData.danhSachTrinhTuCongViec[i]
                        .isNguoiChoPhepTaiChoXacNhanKT) {
                      sequenceType = 'Người cho phép tại chỗ xác nhận kết thúc';
                      typeUser = 3;
                      typeTime = 2;
                    }
                    _showDialogConfirmSequence(
                        context,
                        model,
                        model.detailData.danhSachTrinhTuCongViec[i].iDTrinhTu,
                        sequenceType,
                        typeUser,
                        typeTime);
                  },
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachTrinhTuCongViec.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDirectCommanderList(WorkCommandModel model) {
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
                          'Chỉ huy trực tiếp cũ	: ${model.detailData.danhSachCapNhapNguoiChiHuy[i].chiHuyTrucTiepCu}'
                    },
                    {
                      'content':
                          'Thời gian thông báo đổi ca : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].thoiGianThongBaoDoiCa.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Chỉ huy trực tiếp mới : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].chiHuyTrucTiepMoi}'
                    },
                    {
                      'content':
                          'Thời gian xác nhận : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].thoiGianXacNhan.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Lý do : ${model.detailData.danhSachCapNhapNguoiChiHuy[i].lyDo}'
                    },
                  ],
                  showActions: (model
                      .detailData.danhSachCapNhapNguoiChiHuy[i].isXacNhan),
                  actionLabel: 'XÁC NHẬN',
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
                              'Trạng thái : ',
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

  Widget _buildMemberJoinActions(WorkCommandModel model) {
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
                  'XÁC NHẬN CÓ MẶT ĐẦY ĐỦ',
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

  Widget _buildChangeShiftLeaderHistory(WorkCommandModel model) {
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
                          'Trưởng ca cũ: ${model.detailData.danhSachLichSuDoiCa[i].truongCaCu}'
                    },
                    {
                      'content':
                          'Trường ca mới : ${model.detailData.danhSachLichSuDoiCa[i].truongCaMoi}'
                    },
                    {
                      'content':
                          '	Nội dung : ${model.detailData.danhSachLichSuDoiCa[i].noiDung}'
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
      BuildContext context, WorkCommandModel model) async {
    IsCheckInResponse isCheckInResponse =
        await model.isCheckIn(model.detailData.thongTinChung.iD);

    List<DanhSachChuKy> _allSign = isCheckInResponse.data.danhSachChuKy;
    DanhSachChuKy _selectedSign;

    if (_allSign.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Không có chữ ký nào');
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
                      'Xác nhận checkin',
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
                      'Xác nhận check in, vui lòng chọn chữ ký',
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
                            'XÁC NHẬN',
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
                                'Chọn chữ ký không để trống', ToastStyle.error);
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
              ? 'Check in thành công'
              : 'Đã xảy ra lỗi, Vui lòng thử lại');
      onRefresh();
    }
  }

  Future<void> _showDialogConfirmAttendance(
      BuildContext context, WorkCommandModel model) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'Xác nhận check in đầy đủ',
            textAlign: TextAlign.center,
            style: kMediumBlackTextStyle,
          ),
        ),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Xác nhận có mặt đầy đủ?',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        txtNegativeBtn: 'HUỶ',
        onTapNegativeBtn: () {
          Navigator.of(context).pop();
        },
        txtPositiveBtn: 'ĐỒNG Ý',
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
          result.isSuccess() ? 'Xác nhận thành công' : 'Đã xảy ra lỗi');
      onRefresh();
    }
  }

  Future<void> _showDialogConfirmWithdraw(BuildContext context,
      WorkCommandModel model, int userId, String withdrawType, int type) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'Xác nhận rút khỏi',
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
        txtNegativeBtn: 'HUỶ',
        onTapNegativeBtn: () {
          Navigator.of(context).pop();
        },
        txtPositiveBtn: 'ĐỒNG Ý',
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
          result.isSuccess() ? 'Rút khỏi thành công' : 'Đã xảy ra lỗi');
      onRefresh();
    }
  }

  Future<void> _showDialogConfirmSequence(
      BuildContext context,
      WorkCommandModel model,
      int sequenceId,
      String sequenceType,
      int typeUser,
      int typeTime) async {
    IsCheckInResponse isCheckInResponse = await model.isConfirmSequence(
        model.detailData.thongTinChung.iD, sequenceId);

    List<DanhSachChuKy> _allSign = isCheckInResponse.data.danhSachChuKy;
    DanhSachChuKy _selectedSign;

    TextEditingController dateTextController = TextEditingController();
    TextEditingController trinhTuCongTacNCPTCTextController = TextEditingController();

    if (_allSign.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Không có chữ ký nào');
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
                      'Xác nhận trình tự',
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
                      sequenceType,
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
                                'Thời gian ${typeTime == 1 ? 'bắt đầu' : 'kết thúc'}',
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
                            labelText: 'Trình tự công tác NCPTC',
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
                            'XÁC NHẬN',
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
                                'Lựa chọn thời gian không để trống',
                                ToastStyle.error);
                            return;
                          }
                          if (_selectedSign == null) {
                            ToastMessage.show(
                                'Chọn chữ ký không để trống', ToastStyle.error);
                            return;
                          }
                          String dateEpoch = dateTextController.text.isEmpty
                              ? ''
                              : '${new DateFormat(Constant.ddMMyyyyHHmm2).parse(dateTextController.text).millisecondsSinceEpoch}';
                          final result = await Provider.of<WorkCommandModel>(
                                  context,
                                  listen: false)
                              .confirmSequence(
                                  widget.workCommand.iD,
                                  sequenceId,
                                  typeUser,
                                  typeTime,
                                  _selectedSign.iD,
                                  (typeUser == 1) ? dateEpoch : "",
                                  ((typeUser == 3 && typeTime == 2) ||
                                          (typeUser == 2 && typeTime == 2))
                                      ? trinhTuCongTacNCPTCTextController.text
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
          result.isSuccess() ? 'Xác nhận thành công' : 'Đã xảy ra lỗi');
      onRefresh();
    }
  }

  Future<void> _showDialogMemberCheckOut(
      BuildContext context, WorkCommandModel model) async {
    IsCheckOutResponse isCheckOutResponse =
        await model.isCheckOut(model.detailData.thongTinChung.iD);

    List<DanhSachChuKy> _allSign = isCheckOutResponse.data.danhSachChuKy;
    DanhSachChuKy _selectedSign;

    List<LoaiRutKhois> _allCheckOutType = isCheckOutResponse.data.loaiRutKhois;
    LoaiRutKhois _selectedCheckOutType;

    if (_allSign.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Không có chữ ký nào');
      return;
    }

    if (_allCheckOutType.isNullOrEmpty) {
      NotificationDialog.show(
          context, 'ic_error', 'Không có loại rút khỏi nào');
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
                      'Xác nhận rút khỏi',
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
                        hintText: 'Chọn loại rút khỏi',
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
                            'XÁC NHẬN',
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
                                'Xin chọn loại rút khỏi', ToastStyle.error);
                            return;
                          }
                          if (_selectedSign == null) {
                            ToastMessage.show(
                                'Chọn chữ ký không để trống', ToastStyle.error);
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
          result.isSuccess() ? 'Check out thành công' : 'Đã xảy ra lỗi');
      onRefresh();
    }
  }

  Future<void> _viewSignProcess(
      BuildContext context, WorkCommandModel model) async {
    SignProcessResponse signProcessResponse = await model.signProcess(model.detailData.thongTinChung.iD);
    if (!signProcessResponse.isSuccess()) {
      NotificationDialog.show(
          context, 'ic_error', 'Đã xảy ra lỗi, Vui lòng thử lại');
      return;
    }
    String _signProcessUrl = signProcessResponse.data.linkFileTrinhKy;
    if (_signProcessUrl.isNullOrEmpty) {
      NotificationDialog.show(context, 'ic_success', 'Link trình ký lỗi');
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
      WorkCommandModel model, int idChangeShiftLeader) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomTwoButtonDialog(
        context: context,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            'Xác nhận',
            textAlign: TextAlign.center,
            style: kMediumBlackTextStyle,
          ),
        ),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Bạn có đồng ý xác nhận ?',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        txtNegativeBtn: 'HUỶ',
        onTapNegativeBtn: () {
          Navigator.of(context).pop();
        },
        txtPositiveBtn: 'ĐỒNG Ý',
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
          result.isSuccess() ? 'Xác nhận thành công' : 'Đã xảy ra lỗi');
      onRefresh();
    }
  }
}
