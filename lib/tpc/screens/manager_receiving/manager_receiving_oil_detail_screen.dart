import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/extension/list.dart';
import 'package:workflow_manager/base/ui/date_time_picker_widget.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/base/utils/base_sharepreference.dart';
import 'package:workflow_manager/base/utils/file_utils.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/manager_receiving_oil_model.dart';
import 'package:workflow_manager/models/response/login_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_oil_detail_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_oils_response.dart';
import 'package:workflow_manager/storage/utils/ImageUtils.dart';
import 'package:workflow_manager/tpc/screens/other/custom_expandable_panel.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class ManagerReceivingOilArguments {
  ManagerReceivingOil managerReceivingOil;

  ManagerReceivingOilArguments({
    this.managerReceivingOil,
  });
}

class ManagerReceivingOilDetailScreen extends StatefulWidget {
  final ManagerReceivingOil managerReceivingOil;

  const ManagerReceivingOilDetailScreen({this.managerReceivingOil});

  @override
  State<StatefulWidget> createState() {
    return _ManagerReceivingOilDetailScreenState();
  }
}

class _ManagerReceivingOilDetailScreenState
    extends State<ManagerReceivingOilDetailScreen> {
  TextEditingController _contentNotificationTextController =
      TextEditingController();
  TextEditingController _requireDateTextController = TextEditingController();
  TextEditingController _requireSenderTextController = TextEditingController();

  User _currentUser;

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
    _requireSenderTextController.dispose();
    super.dispose();
  }

  void onRefresh() {
    Provider.of<ManagerReceivingOilModel>(context, listen: false)
        .getManagerReceivingOilDetail(widget.managerReceivingOil.iD);
  }

  Future<void> getCurrentUser() async {
    _currentUser = await SharedPreferencesClass.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chi tiết Tiếp nhận hồ sơ dầu"),
      ),
      body: Consumer<ManagerReceivingOilModel>(
        builder: (_, model, __) => (model.detailData == null ||
                model.detailData.thongTinChung.iD !=
                    widget.managerReceivingOil.iD)
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
                                'Số tiếp nhận : ${model.detailData.thongTinChung.soTiepNhan}',
                            'color': kManagerReceivingOilStatusColor[
                                EnumToString.convertToString(
                                    widget.managerReceivingOil.getStatus())],
                          },
                          {
                            'status':
                                widget.managerReceivingOil.getStatusName(),
                            'color': kManagerReceivingOilStatusColor[
                                EnumToString.convertToString(
                                    widget.managerReceivingOil.getStatus())],
                          },
                          {
                            'icon': 'ic_page',
                            'content':
                                'Loại : ${model.detailData.thongTinChung.getContractType()}',
                          },
                          {
                            'icon': 'ic_clock',
                            'content':
                                'Ngày tiếp nhận : ${model.detailData.thongTinChung.ngayTiepNhan.toDate(Constant.ddMMyyyyHHmm2)}',
                          },
                          {
                            'icon': 'ic_square',
                            'content':
                                'Loại dầu : ${model.detailData.thongTinChung.loaiDau}',
                          },
                          {
                            'icon': 'ic_delivery',
                            'content':
                                'Hình thức vận chuyển : ${model.detailData.thongTinChung.getTransportType()}',
                          },
                          {
                            'icon': 'ic_location',
                            'content':
                                'Địa điểm giao hàng : ${model.detailData.thongTinChung.diaDiemGiaoHang}',
                          },
                          {
                            'icon': 'ic_clock',
                            'content':
                                'Thời gian phương tiện đến : ${model.detailData.thongTinChung.thoiGianPhuongTienDen.toDate(Constant.ddMMyyyyHHmm2)}',
                          },
                        ],
                        onTap: () {},
                        showActions: false,
                      ),
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Thông tin chung',
                      contentExpanded: Column(
                        children: [
                          _buildGeneralInfo(model),
                          _buildFileListGeneralInfo(
                              model.detailData.thongTinChung.danhSachFile),
                        ],
                      ),
                      initExpanded: true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Phòng ban nhận thông báo',
                      contentExpanded:
                          _buildDepartmentReceiveNotificationList(model),
                      initExpanded:
                          (model.detailData.phongBanNhanThongBao.isNullOrEmpty)
                              ? false
                              : true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Gửi yêu cầu tiếp nhận trước và trong',
                      contentExpanded: _buildRequireReceiveBeforeList(model),
                      initExpanded: true,
                    ),
                    CustomExpandablePanel(
                      headerTitle: 'Gửi yêu cầu tiếp nhận sau',
                      contentExpanded: _buildRequireReceiveAfterList(model),
                      initExpanded: true,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () async {
                          final response =
                              await Provider.of<ManagerReceivingOilModel>(
                                      context,
                                      listen: false)
                                  .sendNoticeComplete(
                                      model.detailData.thongTinChung.iD);
                          if (response.isSuccess()) {
                            if (response.status == 1) {
                              NotificationDialog.show(
                                  context, 'ic_success', response.data.text);
                            } else {
                              NotificationDialog.show(
                                  context, 'ic_error', response.data.text);
                            }
                          } else {
                            NotificationDialog.show(context, 'ic_error',
                                'Đã xảy ra lỗi, Vui lòng thử lại');
                          }

                          onRefresh();
                        },
                        child: Text(
                          'HOÀN THÀNH QUY TRÌNH',
                          style: kDefaultTextStyle.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildGeneralInfo(ManagerReceivingOilModel model) {
    return ListItemGeneralInfo(
      itemPairsData: [
        {
          'content':
              'Số tiếp nhận : ${model.detailData.thongTinChung.soTiepNhan}',
        },
        {
          'content':
              'Ngày tiếp nhận : ${model.detailData.thongTinChung.ngayTiepNhan.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Người tiếp nhận : ${model.detailData.thongTinChung.nguoiTiepNhan}',
        },
        {
          'content':
              'Thời gian phương tiện đến : ${model.detailData.thongTinChung.thoiGianPhuongTienDen.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content':
              'Hình thức vận chuyển : ${model.detailData.thongTinChung.getTransportType()}',
        },
        {
          'content':
              'Loại : ${model.detailData.thongTinChung.getContractType()}',
        },
        // if (model.detailData.thongTinChung.type == 2)
        {
          'content': 'Phiếu tiếp nhận dầu : Phiếu tiếp nhận dầu',
        },
        {
          'content':
              'Số hợp đồng : ${model.detailData.thongTinChung.soHopDong}',
        },
        {
          'content':
              'Ngày hợp đồng : ${model.detailData.thongTinChung.ngayHopDong.toDate(Constant.ddMMyyyyHHmm2)}',
        },
        {
          'content': 'Loại dầu : ${model.detailData.thongTinChung.loaiDau}',
        },
        {
          'content':
              'Địa điểm giao hàng : ${model.detailData.thongTinChung.diaDiemGiaoHang}',
        },
      ],
    );
  }

  Widget _buildFileListGeneralInfo(List<DanhSachFile> danhSachFile) {
    if (danhSachFile.isNullOrEmpty) {
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
                  'Tài liệu đính kèm',
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
                'Tài liệu đính kèm',
                style:
                    kSmallGreyTextStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 4.0, right: 20.0),
              child: Divider(
                color: kGrey1,
                thickness: 1.0,
              ),
            ),
            for (DanhSachFile file in danhSachFile)
              buildUploadedModelCard(file),
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
                  'Tài liệu đính kèm',
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
                'Tài liệu đính kèm',
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

  Widget _buildDepartmentReceiveNotificationList(
      ManagerReceivingOilModel model) {
    if (model.detailData.phongBanNhanThongBao.isNullOrEmpty) {
      return Container();
    }
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0;
                  i < model.detailData.phongBanNhanThongBao.length;
                  i++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: Text(
                      '${i + 1}. ${model.detailData.phongBanNhanThongBao[i].name == null ? "" : model.detailData.phongBanNhanThongBao[i].name}',
                      style: kDefaultTextStyle.copyWith(
                          color: kGrey2, fontWeight: FontWeight.w700)),
                ),
            ],
          )),
    );
  }

  Widget _buildRequireReceiveBeforeList(ManagerReceivingOilModel model) {
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
                  i < model.detailData.guiYeuCauTiepNhanTruocVaTrong.length;
                  i++)
                ListItemReceipt(
                  itemTitle: model.detailData.guiYeuCauTiepNhanTruocVaTrong[i]
                      .noiDungThongBao,
                  itemPairsData: [
                    {
                      'content': model.detailData
                          .guiYeuCauTiepNhanTruocVaTrong[i].trangThai,
                      'color': kRequireStatusColor[EnumToString.convertToString(
                          model.detailData.guiYeuCauTiepNhanTruocVaTrong[i]
                              .getStatus())],
                    },
                    {
                      'content':
                          'Nội dung thông báo : ${model.detailData.guiYeuCauTiepNhanTruocVaTrong[i].noiDungThongBao}'
                    },
                    {
                      'content':
                          'Người gửi yêu cầu : ${model.detailData.guiYeuCauTiepNhanTruocVaTrong[i].nguoiGui}'
                    },
                    {
                      'content':
                          'Thời gian yêu cầu : ${model.detailData.guiYeuCauTiepNhanTruocVaTrong[i].thoiGianYeuCau}'
                    },
                  ],
                  showActions3: true,
                  onTapAction3: () {
                    _launchURL(model.detailData.guiYeuCauTiepNhanTruocVaTrong[i]
                        .linkChiTiet);
                  },
                  actionLabel3: 'XEM CHI TIẾT',
                  showFileList: true,
                  fileList: !model.detailData.guiYeuCauTiepNhanTruocVaTrong
                          .isNullOrEmpty
                      ? _buildFileListRequireReceive(model.detailData
                          .guiYeuCauTiepNhanTruocVaTrong[i].danhSachFile)
                      : Container(),
                  isLastItem: i ==
                          model.detailData.guiYeuCauTiepNhanTruocVaTrong
                                  .length -
                              1
                      ? true
                      : false,
                ),
            ],
          )),
    );
  }

  _launchURL(String url) async {
    String root =
        await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
    url += "${url.contains("?") ? "&" : "?"}token=" +
        await SharedPreferencesClass.getToken();
    String rootUrl = '$root' + url;
    if (await canLaunch(rootUrl)) {
      await launch(rootUrl);
    } else {
      NotificationDialog.show(context, 'ic_error', 'Đường dẫn chi tiết lỗi');
    }
  }

  Widget _buildRequireReceiveAfterList(ManagerReceivingOilModel model) {
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
                  _buildRequireReceiveAfterActions(model),
                ],
              ),
              for (var i = 0;
                  i < model.detailData.guiYeuCauTiepNhanSau.length;
                  i++)
                ListItemReceipt(
                  itemTitle:
                      model.detailData.guiYeuCauTiepNhanSau[i].noiDungThongBao,
                  itemPairsData: [
                    {
                      'content':
                          model.detailData.guiYeuCauTiepNhanSau[i].trangThai,
                      'color': kRequireStatusColor[EnumToString.convertToString(
                          model.detailData.guiYeuCauTiepNhanSau[i]
                              .getStatus())],
                    },
                    {
                      'content':
                          'Nội dung thông báo : ${model.detailData.guiYeuCauTiepNhanSau[i].noiDungThongBao}'
                    },
                    {
                      'content':
                          'Người gửi yêu cầu : ${model.detailData.guiYeuCauTiepNhanSau[i].nguoiGui}'
                    },
                    {
                      'content':
                          'Thời gian yêu cầu : ${model.detailData.guiYeuCauTiepNhanSau[i].thoiGianYeuCau}'
                    },
                  ],
                  showActions3: true,
                  onTapAction3: () {
                    _launchURL(model.detailData.guiYeuCauTiepNhanTruocVaTrong[i]
                        .linkChiTiet);
                  },
                  actionLabel3: 'XEM CHI TIẾT',
                  showFileList: true,
                  fileList: !model.detailData.guiYeuCauTiepNhanSau.isNullOrEmpty
                      ? _buildFileListRequireReceive(
                          model.detailData.guiYeuCauTiepNhanSau[i].danhSachFile)
                      : Container(),
                  isLastItem:
                      i == model.detailData.guiYeuCauTiepNhanSau.length - 1
                          ? true
                          : false,
                ),
            ],
          )),
    );
  }

  Widget _buildRequireReceiveBeforeActions(ManagerReceivingOilModel model) {
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
                  'THÊM YÊU CẦU',
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
                await getCurrentUser();
                _displayDialogAddRequireReceipt(context, model, true);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRequireReceiveAfterActions(ManagerReceivingOilModel model) {
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
                  'THÊM YÊU CẦU',
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
                await getCurrentUser();
                _displayDialogAddRequireReceipt(context, model, false);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _displayDialogAddRequireReceipt(BuildContext context,
      ManagerReceivingOilModel model, bool isBeforeRequire) async {
    _contentNotificationTextController.clear();
    _requireDateTextController.text =
        DateFormat(Constant.ddMMyyyyHHmm2).format(DateTime.now());

    Widget contentDialog = _contentAddAddRequireReceiptDialog();
    CustomTwoButtonDialog dialogAddMember = CustomTwoButtonDialog(
      context: context,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Text(
          'Thêm mới yêu cầu',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: contentDialog,
      txtNegativeBtn: 'HUỶ',
      onTapNegativeBtn: () {
        Navigator.of(context).pop();
      },
      txtPositiveBtn: 'THÊM',
      onTapPositiveBtn: () async {
        if (_currentUser == null) {
          ToastMessage.show('Không tìm thấy user', ToastStyle.error);
          return;
        }
        var response;
        if (isBeforeRequire) {
          response = await Provider.of<ManagerReceivingOilModel>(context,
                  listen: false)
              .sendRequireReceiveBefore(
                  model.detailData.thongTinChung.iD,
                  _contentNotificationTextController.text,
                  _currentUser.iDUserDocPro,
                  _requireDateTextController.text);
        } else {
          response = await Provider.of<ManagerReceivingOilModel>(context,
                  listen: false)
              .sendRequireReceiveAfter(
                  model.detailData.thongTinChung.iD,
                  _contentNotificationTextController.text,
                  _currentUser.iDUserDocPro,
                  _requireDateTextController.text);
        }
        Navigator.of(context).pop(response);
        NotificationDialog.show(
            context,
            response.isSuccess() ? 'ic_success' : 'ic_error',
            response.isSuccess()
                ? 'Xác nhận thành công'
                : 'Đã xảy ra lỗi, Vui lòng thử lại');
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

  Widget _contentAddAddRequireReceiptDialog() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
          child: Text(
            'Nội dung thông báo',
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
            'Thời gian yêu cầu',
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
            'Người gửi yêu cầu',
            style: kSmallGreyTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0, right: 20.0),
          child: Text(
            _currentUser == null ? "" : _currentUser.name,
            style: kDefaultTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Divider(
            color: kGrey1,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }

  Widget buildUploadedModelCard(DanhSachFile model) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                  ImageUtils.instance.getImageType(model.fileName),
                  height: 20,
                  fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text('${model.fileName}',
                    style: kDefaultTextStyle.copyWith(
                        fontWeight: FontWeight.w700, color: kColorPrimary)),
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

  Widget buildUploadedModelCard1(DanhSachFile model) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                  ImageUtils.instance.getImageType(model.fileName),
                  height: 20,
                  fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text('${model.fileName}',
                    style: kDefaultTextStyle.copyWith(
                        fontWeight: FontWeight.w700, color: kColorPrimary)),
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
}
