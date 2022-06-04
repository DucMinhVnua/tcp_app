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
import 'package:workflow_manager/models/response/work_sheets_response.dart';
import 'package:workflow_manager/models/work_sheet_model.dart';
import 'package:workflow_manager/tpc/screens/other/custom_expandable_panel.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class WorkSheetArguments {
  WorkSheet workSheet;

  WorkSheetArguments({
    this.workSheet,
  });
}

class WorkSheetDetailScreen extends StatefulWidget {
  final WorkSheet workSheet;

  const WorkSheetDetailScreen({
    this.workSheet,
  });

  @override
  State<StatefulWidget> createState() {
    return _WorkSheetDetailScreenState();
  }
}

class _WorkSheetDetailScreenState extends State<WorkSheetDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  void onRefresh() {
    Provider.of<WorkSheetModel>(context, listen: false)
        .getWorkSheetDetail(widget.workSheet.iD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chi tiết phiếu công tác"),
      ),
      body: Consumer<WorkSheetModel>(
        builder: (_, model, __) => (model.detailData == null ||
                model.detailData.thongTinChung.iD != widget.workSheet.iD)
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
                            'color': kWorkSheetStatusColor[
                                EnumToString.convertToString(
                                    widget.workSheet.getStatus())],
                          },
                          {
                            'status': widget.workSheet.getStatusName(),
                            'color': kWorkSheetStatusColor[
                                EnumToString.convertToString(
                                    widget.workSheet.getStatus())],
                          },
                          {
                            'icon': 'ic_page',
                            'content': 'Số phiếu : ${model.detailData.thongTinChung.code}',
                          },
                          {
                            'icon': 'ic_avatar',
                            'content':
                                'Người chỉ huy : ${model.detailData.thongTinChung.nguoiChiHuy}',
                          },
                          {
                            'icon': 'ic_clock',
                            'content':
                                'Ngày lập phiếu : ${model.detailData.thongTinChung.ngayLap.toDate(Constant.ddMMyyyyHHmm2)}',
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
                        onTap: () {},
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
                      headerTitle: 'Điều kiện thực hiện công việc',
                      contentExpanded: _buildDanhSachDieuKienThucHien(model),
                      initExpanded: (model.detailData.danhSachDieuKienThucHien
                              .isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Vị trí tiếp đất',
                      contentExpanded: _buildDanhSachViTriTiepDat(model),
                      initExpanded:
                          (model.detailData.danhSachViTriTiepDat.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Vị trí làm rào chắn',
                      contentExpanded: _buildDanhSachViTriRaoChan(model),
                      initExpanded:
                          (model.detailData.danhSachViTriRaoChan.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Phạm vi được phép làm việc',
                      contentExpanded:
                          _buildDanhSachPhamViDuocPhepLamViec(model),
                      initExpanded: (model.detailData
                              .danhSachPhamViDuocPhepLamViec.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Cảnh báo, chỉ dẫn cần thiết',
                      contentExpanded: _buildDanhSachCanhBaoChiDan(model),
                      initExpanded:
                          (model.detailData.danhSachCanhBaoChiDan.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Biện pháp an toàn làm thêm',
                      contentExpanded: _buildDanhSachBienPhapAnToan(model),
                      initExpanded: (model
                              .detailData.danhSachBienPhapAnToan.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Nhân viên đơn vị công tác',
                      contentExpanded: _buildDanhSachNhanVien(model),
                      initExpanded:
                          (model.detailData.danhSachNhanVien.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Địa điểm công tác',
                      contentExpanded: _buildDanhSachDiaDiemCongTac(model),
                      initExpanded: (model
                              .detailData.danhSachDiaDiemCongTac.isNullOrEmpty)
                          ? false
                          : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Người chỉ huy trực tiếp',
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

  Widget _buildGeneralInfo(WorkSheetModel model) {
    return ListItemGeneralInfo(
      itemPairsData: [
        {
          'content':
              'Số phiếu công tác : ${model.detailData.thongTinChung.code}',
        },
        {
          'content':
              'Ngày lập Phiếu : ${model.detailData.thongTinChung.ngayLap.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Người lập phiếu : ${model.detailData.thongTinChung.nguoiLap}',
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
              'Người cho phép : ${model.detailData.thongTinChung.nguoiChoPhep}',
        },
        {
          'content':
              'Số người tham gia công tác : ${model.detailData.thongTinChung.soNguoiThamGia}',
        },
        {
          'content':
              'Địa điểm thực hiện công việc : ${model.detailData.thongTinChung.diaDiem}',
        },
        {
          'content':
              'Nội dung công việc : ${model.detailData.thongTinChung.noiDungCongTac}',
        },
        {
          'content':
              'Thời gian bắt đầu : ${model.detailData.thongTinChung.thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Thời gian kết thúc : ${model.detailData.thongTinChung.thoiGianKetThuc.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Người giám sát ATĐ : ${model.detailData.thongTinChung.nguoiGiamSatATD == null ? '' : model.detailData.thongTinChung.nguoiGiamSatATD}',
        },
        {
          'content':
              'Thời gian bắt đầu công tác : ${model.detailData.thongTinChung.thoiGianBatDauCongTac.toDate(Constant.ddMMyyyyHHmm2)}',
        },
      ],
      showActions: true,
      onTap: () {
        _viewSignProcess(context, model);
      },
    );
  }

  Widget _buildDanhSachDieuKienThucHien(WorkSheetModel model) {
    if (model.detailData.danhSachDieuKienThucHien.isNullOrEmpty) {
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
                  i < model.detailData.danhSachDieuKienThucHien.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachDieuKienThucHien[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Thiết bị/DD : ${model.detailData.danhSachDieuKienThucHien[i].thietBi}'
                    },
                    {
                      'content':
                          'Điều kiện : ${model.detailData.danhSachDieuKienThucHien[i].dieuKien}'
                    },
                    {
                      'content':
                          'Đơn vị QLVH : ${model.detailData.danhSachDieuKienThucHien[i].donViQLVH}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachDieuKienThucHien.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachViTriTiepDat(WorkSheetModel model) {
    if (model.detailData.danhSachViTriTiepDat.isNullOrEmpty) {
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
                  i < model.detailData.danhSachViTriTiepDat.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachViTriTiepDat[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Vị trí : ${model.detailData.danhSachViTriTiepDat[i].viTri}'
                    },
                    {
                      'content':
                          'Tiếp đất : ${model.detailData.danhSachViTriTiepDat[i].tiepDat}'
                    },
                    {
                      'content':
                          'Đơn vị QLVH : ${model.detailData.danhSachViTriTiepDat[i].donViQLVH}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachViTriTiepDat.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachViTriRaoChan(WorkSheetModel model) {
    if (model.detailData.danhSachViTriRaoChan.isNullOrEmpty) {
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
                  i < model.detailData.danhSachViTriRaoChan.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachViTriRaoChan[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Ví trí làm rào chắn : ${model.detailData.danhSachViTriRaoChan[i].viTriRaoChan}'
                    },
                    {
                      'content':
                          'Rào chắn, biến báo : ${model.detailData.danhSachViTriRaoChan[i].raoChanBienBao}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachViTriRaoChan.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachPhamViDuocPhepLamViec(WorkSheetModel model) {
    if (model.detailData.danhSachPhamViDuocPhepLamViec.isNullOrEmpty) {
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
                  i < model.detailData.danhSachPhamViDuocPhepLamViec.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachPhamViDuocPhepLamViec[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Vị trí/ĐD/ Thiết bị : ${model.detailData.danhSachPhamViDuocPhepLamViec[i].viTri}'
                    },
                    {
                      'content':
                          'Phạm vi được phép làm việc : ${model.detailData.danhSachPhamViDuocPhepLamViec[i].phamViDuocPhepLamViec}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem: i ==
                          model.detailData.danhSachPhamViDuocPhepLamViec
                                  .length -
                              1
                      ? true
                      : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachCanhBaoChiDan(WorkSheetModel model) {
    if (model.detailData.danhSachCanhBaoChiDan.isNullOrEmpty) {
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
                  i < model.detailData.danhSachCanhBaoChiDan.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachCanhBaoChiDan[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Cảnh báo tai nạn : ${model.detailData.danhSachCanhBaoChiDan[i].canhBaoChiDan}'
                    },
                    {
                      'content':
                          'Chỉ dẫn biện pháp an toàn : ${model.detailData.danhSachCanhBaoChiDan[i].chiDanBienPhapAnToan}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachCanhBaoChiDan.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachBienPhapAnToan(WorkSheetModel model) {
    if (model.detailData.danhSachBienPhapAnToan.isNullOrEmpty) {
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
                  i < model.detailData.danhSachBienPhapAnToan.length;
                  i++)
                ListItemZebraStyle(
                  itemTitle:
                      '${i + 1}. ${model.detailData.danhSachBienPhapAnToan[i].iD}',
                  itemPairsData: [
                    {
                      'content':
                          'Vị trí : ${model.detailData.danhSachBienPhapAnToan[i].viTri}'
                    },
                    {
                      'content':
                          'Biện pháp an toàn : ${model.detailData.danhSachBienPhapAnToan[i].chiDanBienPhapAnToan}'
                    },
                  ],
                  showActions: false,
                  onTap: () {},
                  isLastItem:
                      i == model.detailData.danhSachBienPhapAnToan.length - 1
                          ? true
                          : false,
                )
            ],
          )),
    );
  }

  Widget _buildDanhSachNhanVien(WorkSheetModel model) {
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
                          'Thời gian bổ sung : ${model.detailData.danhSachNhanVien[i].ngay.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
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
                          'Thời gian đến làm việc : ${model.detailData.danhSachNhanVien[i].thoiGianDenLamViec.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Thời gian rút khỏi : ${model.detailData.danhSachNhanVien[i].thoiGianRutKhoi.toDate(Constant.ddMMyyyyHHmm2)}'
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

  Widget _buildDanhSachDiaDiemCongTac(WorkSheetModel model) {
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
                          'Địa điểm công tác : ${model.detailData.danhSachDiaDiemCongTac[i].diaDiemCongTac}'
                    },
                    {
                      'content':
                          'Thời gian bắt đầu : ${model.detailData.danhSachDiaDiemCongTac[i].thoiGianBatDau.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Thời gian kết thúc : ${model.detailData.danhSachDiaDiemCongTac[i].thoiGianKetThuc.toDate(Constant.ddMMyyyyHHmm2)}'
                    },
                    {
                      'content':
                          'Người chỉ huy trực tiếp : ${model.detailData.danhSachDiaDiemCongTac[i].nguoiChiHuyXacNhanBD}'
                    },
                    {
                      'content':
                          'Người cho phép : ${model.detailData.danhSachDiaDiemCongTac[i].nguoiChoPhepXacNhanBD}'
                    },
                    {
                      'content':
                          'Người cho phép tại chỗ : ${model.detailData.danhSachDiaDiemCongTac[i].nguoiChoPhepTaiChoBD}'
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
                  actionLabel: 'XÁC NHẬN',
                  onTapAction: () {
                    String sequenceType = '';
                    int typeUser = 1;
                    int typeTime = 1;
                    if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isChiHuyXacNhanBD) {
                      sequenceType = 'Chỉ huy xác nhận bắt đầu';
                      typeUser = 1;
                      typeTime = 1;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isChiHuyXacNhanKT) {
                      sequenceType = 'Chỉ huy xác nhận kết thúc';
                      typeUser = 1;
                      typeTime = 2;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isNguoiChoPhepXacNhanBD) {
                      sequenceType = 'Người cho phép xác nhận bắt đầu';
                      typeUser = 2;
                      typeTime = 1;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isNguoiChoPhepXacNhanKT) {
                      sequenceType = 'Người cho phép xác nhận kết thúc';
                      typeUser = 2;
                      typeTime = 2;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isNguoiChoPhepTaiChoXacNhanBD) {
                      sequenceType = 'Người cho phép tại chỗ xác nhận bắt đầu';
                      typeUser = 3;
                      typeTime = 1;
                    } else if (model.detailData.danhSachDiaDiemCongTac[i]
                        .isNguoiChoPhepTaiChoXacNhanKT) {
                      sequenceType = 'Người cho phép tại chỗ xác nhận kết thuc';
                      typeUser = 3;
                      typeTime = 2;
                    }
                    _showDialogConfirmLocation(
                        context,
                        model,
                        model.detailData.danhSachDiaDiemCongTac[i].iDDiaDiem,
                        sequenceType,
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

  Widget _buildDirectCommanderList(WorkSheetModel model) {
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

  Widget _buildChangeShiftLeaderHistory(WorkSheetModel model) {
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

  Future<void> _showDialogConfirmWithdraw(BuildContext context,
      WorkSheetModel model, int userId, String withdrawType, int type) async {
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

  Future<void> _showDialogMemberCheckOut(
      BuildContext context, WorkSheetModel model, int userId) async {
    IsCheckOutResponse isCheckOutResponse =
        await model.isCheckOut(model.detailData.thongTinChung.iD, userId);

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
              ? 'Check out thành công'
              : 'Đã xảy ra lỗi, Vui lòng thử lại');
      onRefresh();
    }
  }

  Future<void> _showDialogCheckIn(
      BuildContext context, WorkSheetModel model, int userId) async {
    IsCheckInResponse isCheckInResponse =
        await model.isCheckIn(model.detailData.thongTinChung.iD, userId);

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
                      'Vui lòng chọn chữ ký',
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
              ? 'Check in thành công'
              : 'Đã xảy ra lỗi, Vui lòng thử lại');
      onRefresh();
    }
  }

  Widget _buildMemberJoinActions(WorkSheetModel model) {
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
        ],
      ),
    );
  }

  Future<void> _showDialogConfirmAttendance(
      BuildContext context, WorkSheetModel model) async {
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

  Future<void> _showDialogConfirmLocation(
      BuildContext context,
      WorkSheetModel model,
      int locationId,
      String locationType,
      int typeUser,
      int typeTime) async {
    IsCheckInResponse isCheckInResponse =
        await model.isConfirmLocation(model.detailData.thongTinChung.iD);

    List<DanhSachChuKy> _allSign = isCheckInResponse.data.danhSachChuKy;
    DanhSachChuKy _selectedSign;

    TextEditingController dateTextController = TextEditingController();

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
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              titlePadding: EdgeInsets.symmetric(horizontal: 0),
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
                          final result = await Provider.of<WorkSheetModel>(
                                  context,
                                  listen: false)
                              .confirmLocation(
                                  widget.workSheet.iD,
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
          result.isSuccess() ? 'Xác nhận thành công' : 'Đã xảy ra lỗi');
      onRefresh();
    }
  }

  Future<void> _viewSignProcess(
      BuildContext context, WorkSheetModel model) async {
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
      WorkSheetModel model, int idChangeShiftLeader) async {
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
