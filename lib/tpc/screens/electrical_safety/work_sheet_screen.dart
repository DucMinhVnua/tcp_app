import 'package:dropdown_search/dropdown_search.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/response/list_member_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/models/response/work_sheets_response.dart';
import 'package:workflow_manager/models/work_sheet_model.dart';
import 'package:workflow_manager/routes/route.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_sheet_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

import '../other/bottom_sheet_dialog.dart';

class WorkSheetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WorkSheetScreenState();
  }
}

class _WorkSheetScreenState extends State<WorkSheetScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkSheetModel>(context, listen: false).getWorkSheets(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
            elevation: 2,
            backgroundColor: kColorPrimary,
            title: Text('Phiếu công tác')),
        body: Consumer<WorkSheetModel>(
          builder: (_, model, __) => Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: kColorPrimary,
                  unselectedLabelColor: kBlack1,
                  overlayColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    return Colors.transparent;
                  }),
                  indicatorColor: kColorPrimary,
                  isScrollable: true,
                  physics: ClampingScrollPhysics(),
                  tabs: [
                    TabBadge(StatusWorkSheet.pending, 'Đang cấp phép'),
                    TabBadge(StatusWorkSheet.rePerformTask,
                        'Thực hiện lại công tác'),
                    TabBadge(StatusWorkSheet.performTask, 'Thực hiện công tác'),
                    TabBadge(StatusWorkSheet.waitingConfirm,
                        'Chờ xác nhận hoàn thành'),
                    TabBadge(StatusWorkSheet.notFinished, 'Kết thúc chưa xong'),
                    TabBadge(StatusWorkSheet.confirmed, 'Đã xác nhận'),
                    TabBadge(StatusWorkSheet.completed, 'Hoàn thành'),
                    TabBadge(StatusWorkSheet.cancelled, 'Hủy'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: ClampingScrollPhysics(),
                  children: [
                    WorkSheetTabView(
                      status: StatusWorkSheet.pending,
                    ),
                    WorkSheetTabView(
                      status: StatusWorkSheet.rePerformTask,
                    ),
                    WorkSheetTabView(
                      status: StatusWorkSheet.performTask,
                    ),
                    WorkSheetTabView(
                      status: StatusWorkSheet.waitingConfirm,
                    ),
                    WorkSheetTabView(
                      status: StatusWorkSheet.notFinished,
                    ),
                    WorkSheetTabView(
                      status: StatusWorkSheet.confirmed,
                    ),
                    WorkSheetTabView(
                      status: StatusWorkSheet.completed,
                    ),
                    WorkSheetTabView(
                      status: StatusWorkSheet.cancelled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkSheetTabView extends StatefulWidget {
  final StatusWorkSheet status;

  const WorkSheetTabView({Key key, @required this.status}) : super(key: key);

  @override
  WorkSheetTabViewState createState() {
    return new WorkSheetTabViewState();
  }
}

class WorkSheetTabViewState extends State<WorkSheetTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkSheetModel>(
      builder: (_, model, __) => Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * kDefaultAppBarBottom,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: RichText(
                          text: TextSpan(
                            style: kDefaultTextStyle,
                            children: <TextSpan>[
                              TextSpan(text: 'Tổng số có : '),
                              TextSpan(
                                  style: kDefaultTextStyle.copyWith(
                                      fontWeight: FontWeight.w700),
                                  text:
                                      '${(model.getData().isNotEmpty && model.getDataByStatus(widget.status).isNotEmpty && !model.isLoading) ? model.getDataByStatus(widget.status).length : 0}'),
                              TextSpan(text: ' phiếu công tác'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            _pushFilterScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: SvgImage(
                                  svgName: model.isFiltered
                                      ? "ic_filtered"
                                      : "ic_filter",
                                )),
                          ),
                        )),
                  ],
                ),
              ),
              color: kGrey1),
          Expanded(
              child: Material(
            elevation: 3,
            child: model.isLoading
                ? Container()
                : _buildListDataItem(
                    context: context,
                    workSheets: model.getDataByStatus(widget.status)),
          )),
        ],
      ),
    );
  }
}

Widget _buildListDataItem({
  @required BuildContext context,
  @required List<WorkSheet> workSheets,
}) {
  Future<void> _onRefresh() async {
    Provider.of<WorkSheetModel>(context, listen: false).getWorkSheets(true);
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        itemCount: workSheets.length,
        itemBuilder: (context, index) {
          return ListItemInfo(
            itemPairsData: [
              {
                'icon': 'ic_circle',
                'content': workSheets[index].noiDungCongViec,
                'color': kWorkSheetStatusColor[EnumToString.convertToString(
                    workSheets[index].getStatus())],
              },
              {
                'status': workSheets[index].getStatusName(),
                'color': kWorkSheetStatusColor[EnumToString.convertToString(
                    workSheets[index].getStatus())],
              },
              {
                'icon': 'ic_page',
                'content': 'Số phiếu : ${workSheets[index].code}',
              },
              {
                'icon': 'ic_avatar',
                'content':
                    'Người chỉ huy : ${workSheets[index].tenChiHuy}',
              },
              {
                'icon': 'ic_clock',
                'content':
                    'Ngày lập phiếu : ${workSheets[index].ngayLapPhieu.toDate(Constant.ddMMyyyy)}',
              },
              {
                'icon': 'ic_location',
                'content':
                    'Địa điểm thực hiện : ${workSheets[index].diaDiemThucHienCongViec}',
              },
              {
                'icon': 'ic_page',
                'content':
                    'Nội dung : ${workSheets[index].noiDungCongViec}',
              },
            ],
            onTap: () => _showActionsDialog(context, workSheets[index]),
            showActions: true,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: kGrey1,
            thickness: 2,
            height: 32,
          );
        },
      ),
    ),
  );
}

class TabBadge extends Tab {
  final String name;
  final StatusWorkSheet status;

  TabBadge(this.status, this.name) : super(text: name);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Consumer<WorkSheetModel>(
            builder: (_, model, __) => (model.getData().isEmpty ||
                    model.isLoading ||
                    model.getDataByStatus(status).isEmpty)
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 4),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //TODO Color by status ?\
                      // color: HexColor(kWorkCommandStatusColor[
                      //     EnumToString.convertToString(status)]),
                      color: kOrange1,
                    ),
                    child: Text(
                      model.getDataByStatus(status).length > 99
                          ? '99+'
                          : model.getDataByStatus(status).length.toString(),
                      style: kSmallWhiteTextStyle,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

void _pushFilterScreen(BuildContext context) async {
  final result = await Navigator.of(context).pushNamed(RouteList.filter,
          arguments: FilterPushArguments(pushScreen: FilterPushType.workSheet))
      as FilterPopArguments;
  //Change Tab base on Status
  // DefaultTabController.of(context)
  //     .animateTo(result.status != 0 ? result.status - 1 : 0);
  //Filter data in model
  Provider.of<WorkSheetModel>(context, listen: false).filter(result);
}

void _showActionsDialog(BuildContext context, WorkSheet model) {
  ModalBottomSheetDialog modalBottomSheetDialog = ModalBottomSheetDialog(
    context: context,
    onTapListener: (item) async {
      if (item.key == '2') {
        Navigator.pushNamed(
            context, RouteList.electrical_safety_work_sheet_detail,
            arguments: WorkSheetArguments(workSheet: model));
      } else if (item.key == '3') {
        Navigator.pushNamed(
            context, RouteList.electrical_safety_work_sheet_add_member,
            arguments: WorkSheetArguments(workSheet: model));
      } else if (item.key == '4') {
        Navigator.pushNamed(
            context, RouteList.electrical_safety_work_sheet_add_work_place,
            arguments: WorkSheetArguments(workSheet: model));
      } else if (item.key == '5') {
        final result = await _showChangeDirectCommanderDialog(context, model);
        if (result != null) {
          NotificationDialog.show(
              context,
              result.isSuccess() ? 'ic_success' : 'ic_error',
              result.isSuccess()
                  ? 'Thay đổi thành công'
                  : 'Đã xảy ra lỗi, Vui lòng thử lại');
        }
      } else if (item.key == '6') {
        Navigator.pop(context);
        final result = await Provider.of<WorkSheetModel>(context, listen: false)
            .notifyComplete(model.iD);
        if (result != null) {
          NotificationDialog.show(
              context,
              result.isSuccess() ? 'ic_success' : 'ic_error',
              result.isSuccess() ? 'Thành công' : result.messages);
          Provider.of<WorkSheetModel>(context, listen: false)
              .getWorkSheets(true);
        }
      } else if (item.key == '7') {
        final result = await _showChangeShiftLeaderDialog(context, model);
        if (result != null) {
          NotificationDialog.show(
              context,
              result.isSuccess() ? 'ic_success' : 'ic_error',
              result.isSuccess()
                  ? 'Thay đổi thành công'
                  : 'Đã xảy ra lỗi, Vui lòng thử lại');
        }
      } else if (item.key == '8') {
        final result = await _showChangeAssignmentDialog(context, model);
        if (result != null) {
          NotificationDialog.show(
              context,
              result.isSuccess() ? 'ic_success' : 'ic_error',
              result.isSuccess()
                  ? 'Thay đổi thành công'
                  : 'Đã xảy ra lỗi, Vui lòng thử lại');
        }
      } else if (item.key == '9') {
        final result = await _showConfirmCancelDialog(context, model);
        if (result != null) {
          NotificationDialog.show(
              context,
              result.isSuccess() ? 'ic_success' : 'ic_error',
              result.isSuccess()
                  ? 'Hủy phiếu công tác thành công'
                  : 'Đã xảy ra lỗi, Vui lòng thử lại');
          Provider.of<WorkSheetModel>(context, listen: false)
              .getWorkSheets(true);
        }
      }
    },
  );
  List<ModalBottomSheetItemPair> data = [];
  data.add(ModalBottomSheetItemPair(key: "1", content: model.noiDungCongViec));
  data.add(ModalBottomSheetItemPair(
      key: "2",
      icon: SvgImage(
        svgName: "ic_eye",
        size: 15,
      ),
      content: 'Xem chi tiết'));
  if (model.isActionBoSungNhanSu)
    data.add(ModalBottomSheetItemPair(
        key: "3",
        icon: SvgImage(
          svgName: "ic_add_user",
          size: 15,
        ),
        content: 'Bổ sung thành viên tham gia'));
  if (model.isActionBoSungDiaDiem)
    data.add(ModalBottomSheetItemPair(
        key: "4",
        icon: SvgImage(
          svgName: "ic_location",
          size: 15,
        ),
        content: 'Bổ sung địa điểm công tác'));
  if (model.isActionThayDoiChiHuy)
    data.add(ModalBottomSheetItemPair(
        key: "5",
        icon: SvgImage(
          svgName: "ic_edit_member",
          size: 15,
        ),
        content: 'Thay đổi người chỉ huy trực tiếp'));
  if (model.isActionThongBaoHoanThanh)
    data.add(ModalBottomSheetItemPair(
        key: "6",
        icon: SvgImage(
          svgName: "ic_check",
          size: 15,
        ),
        content: 'Thông báo hoàn thành công việc'));
  if (model.isActionTruongCa)
    data.add(ModalBottomSheetItemPair(
        key: "7",
        icon: SvgImage(
          svgName: "ic_edit_member",
          size: 15,
        ),
        content: 'Thay đổi trưởng ca'));
  if (model.isActionTruongCa)
    data.add(ModalBottomSheetItemPair(
        key: "8",
        icon: SvgImage(
          svgName: "ic_page",
          size: 15,
        ),
        content: 'Thay đổi phân công'));
  if (model.isActionCancel)
    data.add(ModalBottomSheetItemPair(
        key: "9",
        icon: SvgImage(
          svgName: "ic_delete",
          size: 15,
        ),
        content: 'Hủy phiếu công tác'));
  modalBottomSheetDialog.showBottomSheetDialog(data);
}

Future<StatusResponse> _showChangeDirectCommanderDialog(
    BuildContext context, WorkSheet workSheet) async {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _safetyCardNumberTextController =
      TextEditingController();
  TextEditingController _changeReasonTextController = TextEditingController();
  Users _selectedUser;

  ListMemberResponse memberResponse =
      await Provider.of<WorkSheetModel>(context, listen: false)
          .getDirectCommanderList(workSheet.iDChiHuy);

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
                      'Thay đổi chỉ huy trực tiếp',
                      textAlign: TextAlign.center,
                      style: kMediumBlackTextStyle,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: kGrey2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownSearch<Users>(
                      mode: Mode.DIALOG,
                      dropdownButtonBuilder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: SvgImage(
                            svgName: 'ic_dropdown',
                            size: 6.0,
                          ),
                        );
                      },
                      items: memberResponse.data.users,
                      itemAsString: (Users member) => member.name,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kBlue1),
                        ),
                        hintText: 'Chọn chỉ huy mới',
                        hintStyle: kDefaultTextStyle.copyWith(color: kGrey2),
                      ),
                      onChanged: (Users member) {
                        _userNameTextController.text = member.name;
                        _selectedUser = member;
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          contentPadding: EdgeInsets.all(8.0),
                          hintText: 'Tìm kiếm nhân viên',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      controller: _safetyCardNumberTextController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Bậc an toàn điện',
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      controller: _changeReasonTextController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Lý do thay đổi',
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
                          'ĐỒNG Ý',
                          style:
                              kDefaultTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kBlue1),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(color: kBlue1)))),
                      onPressed: () async {
                        if (_selectedUser == null) {
                          ToastMessage.show(
                              'Chọn chỉ huy không để trống', ToastStyle.error);
                          return;
                        }
                        final result = await Provider.of<WorkSheetModel>(
                                context,
                                listen: false)
                            .changeDirectCommander(
                          workSheet.iD,
                          _selectedUser.iD,
                          int.tryParse(_safetyCardNumberTextController.text) ??
                              0,
                          _changeReasonTextController.text,
                        );
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
    Navigator.pop(context);
  }
  return result;
}

Future<StatusResponse> _showChangeShiftLeaderDialog(
    BuildContext context, WorkSheet workSheet) async {
  TextEditingController _shiftLeaderTextController = TextEditingController();
  TextEditingController _contentTextController = TextEditingController();
  ShiftLeaders _selectedShiftLeader;

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
                      'Thay đổi trưởng ca',
                      textAlign: TextAlign.center,
                      style: kMediumBlackTextStyle,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: kGrey2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownSearch<ShiftLeaders>(
                      mode: Mode.DIALOG,
                      dropdownButtonBuilder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: SvgImage(
                            svgName: 'ic_dropdown',
                            size: 6.0,
                          ),
                        );
                      },
                      items: workSheet.users,
                      itemAsString: (ShiftLeaders member) => member.name,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kBlue1),
                        ),
                        hintText: 'Trưởng ca',
                        hintStyle: kDefaultTextStyle.copyWith(color: kGrey2),
                      ),
                      onChanged: (ShiftLeaders member) {
                        _shiftLeaderTextController.text = member.name;
                        _selectedShiftLeader = member;
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
                              borderSide:
                              BorderSide(color: Colors.grey.shade300),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0))),
                          contentPadding: EdgeInsets.all(8.0),
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      controller: _contentTextController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Nội dung',
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
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          'ĐỒNG Ý',
                          style:
                          kDefaultTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(kBlue1),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: kBlue1)))),
                      onPressed: () async {
                        if (_selectedShiftLeader == null) {
                          ToastMessage.show('Chọn trưởng ca không để trống',
                              ToastStyle.error);
                          return;
                        }
                        final result = await Provider.of<WorkSheetModel>(
                            context,
                            listen: false)
                            .changeShiftLeader(
                          workSheet.iD,
                          _selectedShiftLeader.iD,
                          _contentTextController.text,
                        );
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
    Navigator.pop(context);
  }
  return result;
}

Future<StatusResponse> _showChangeAssignmentDialog(
    BuildContext context, WorkSheet workSheet) async {
  TextEditingController _nguoiChoPhepTextController = TextEditingController();
  TextEditingController _nguoiChoPhepTCTextController = TextEditingController();
  TextEditingController _contentTextController = TextEditingController();
  ShiftLeaders _selectedNguoiChoPhep;
  ShiftLeaders _selectedNguoiChoPhepTC;

  WorkSheetModel workSheetModel =
  Provider.of<WorkSheetModel>(context, listen: false);
  await workSheetModel.getWorkSheetDetail(workSheet.iD);

  if (workSheetModel.detailData.thongTinChung.iDNguoiChoPhep != null &&
      workSheetModel.detailData.thongTinChung.iDNguoiChoPhep > 0) {
    _selectedNguoiChoPhep = workSheet.users.firstWhere(
            (user) =>
        workSheetModel.detailData.thongTinChung.iDNguoiChoPhep == user.iD,
        orElse: () => null);
  }

  if (workSheetModel.detailData.thongTinChung.iDNguoiChoPhepTaiCho != null &&
      workSheetModel.detailData.thongTinChung.iDNguoiChoPhepTaiCho > 0) {
    _selectedNguoiChoPhepTC = workSheet.users.firstWhere(
            (user) =>
        workSheetModel.detailData.thongTinChung.iDNguoiChoPhepTaiCho ==
            user.iD,
        orElse: () => null);
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
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Thay đổi phân công',
                      textAlign: TextAlign.center,
                      style: kMediumBlackTextStyle,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: kGrey2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownSearch<ShiftLeaders>(
                      mode: Mode.DIALOG,
                      dropdownButtonBuilder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: SvgImage(
                            svgName: 'ic_dropdown',
                            size: 6.0,
                          ),
                        );
                      },
                      items: workSheet.users,
                      itemAsString: (ShiftLeaders member) => member.name,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kBlue1),
                        ),
                        hintText: 'Người cho phép',
                        hintStyle: kDefaultTextStyle.copyWith(color: kGrey2),
                      ),
                      onChanged: (ShiftLeaders member) {
                        _nguoiChoPhepTextController.text = member.name;
                        _selectedNguoiChoPhep = member;
                      },
                      selectedItem: _selectedNguoiChoPhep,
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey.shade300),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0))),
                          contentPadding: EdgeInsets.all(8.0),
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownSearch<ShiftLeaders>(
                      mode: Mode.DIALOG,
                      dropdownButtonBuilder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: SvgImage(
                            svgName: 'ic_dropdown',
                            size: 6.0,
                          ),
                        );
                      },
                      items: workSheet.users,
                      itemAsString: (ShiftLeaders member) => member.name,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kBlue1),
                        ),
                        hintText: 'Người cho phép tại chỗ',
                        hintStyle: kDefaultTextStyle.copyWith(color: kGrey2),
                      ),
                      onChanged: (ShiftLeaders member) {
                        _nguoiChoPhepTCTextController.text = member.name;
                        _selectedNguoiChoPhepTC = member;
                      },
                      selectedItem: _selectedNguoiChoPhepTC,
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey.shade300),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0))),
                          contentPadding: EdgeInsets.all(8.0),
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      controller: _contentTextController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Nội dung',
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
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          'ĐỒNG Ý',
                          style:
                          kDefaultTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(kBlue1),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: kBlue1)))),
                      onPressed: () async {
                        if (_selectedNguoiChoPhep == null) {
                          ToastMessage.show('Chọn người cho phép không để trống',
                              ToastStyle.error);
                          return;
                        }
                        if (_selectedNguoiChoPhepTC == null) {
                          ToastMessage.show('Chọn người cho phép tại chỗ không để trống',
                              ToastStyle.error);
                          return;
                        }
                        final result = await Provider.of<WorkSheetModel>(
                            context,
                            listen: false)
                            .changeAssignment(
                          workSheet.iD,
                          _selectedNguoiChoPhep.iD,
                          _selectedNguoiChoPhepTC.iD,
                          _contentTextController.text,
                        );
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
    Navigator.pop(context);
  }
  return result;
}

Future<StatusResponse> _showConfirmCancelDialog(
    BuildContext context, WorkSheet workSheet) async {
  final result = await showDialog(
    context: context,
    builder: (BuildContext context) => CustomTwoButtonDialog(
      context: context,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Text(
          'Xác nhận hủy phiếu công tác',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'Bạn có đồng ý hủy phiếu công tác ?',
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
        var result = await Provider.of<WorkSheetModel>(context, listen: false)
            .confirmCancel(workSheet.iD);
        Navigator.of(context).pop(result);
      },
    ),
    barrierDismissible: false,
  );
  if (result != null) {
    Navigator.pop(context);
  }
  return result;
}