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
import 'package:workflow_manager/models/response/work_commands_response.dart';
import 'package:workflow_manager/models/work_command_model.dart';
import 'package:workflow_manager/routes/route.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

import '../other/bottom_sheet_dialog.dart';
import '../other/search_app_bar.dart';
import 'work_command_detail_screen.dart';

class WorkCommandScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WorkCommandScreenState();
  }
}

class _WorkCommandScreenState extends State<WorkCommandScreen> {
  SearchBar searchBar;

  _WorkCommandScreenState() {
    searchBar = new SearchBar(
        inBar: true,
        buildDefaultAppBar: buildSearchBar,
        suggestionsCallback: (pattern) async {
          return await Provider.of<WorkCommandModel>(context, listen: false)
              .generateSuggestion(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.noiDungCongTac),
          );
        },
        //TODO Find search pattern as Json Models
        suggestionSelectedPattern: "NoiDungCongTac",
        setState: setState,
        hintText: '',
        onSubmitted: (value) {
          Provider.of<WorkCommandModel>(context, listen: false).search(value);
        },
        onOpened: () {
          Provider.of<WorkCommandModel>(context, listen: false).searchedData =
              [];
          Provider.of<WorkCommandModel>(context, listen: false).isSearching =
              true;
        },
        onClosed: () {
          Provider.of<WorkCommandModel>(context, listen: false).isSearching =
              false;
        });
  }

  AppBar buildSearchBar(BuildContext context) {
    return new AppBar(
        elevation: 2,
        backgroundColor: kColorPrimary,
        title: Text('Lệnh công tác'),
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkCommandModel>(context, listen: false)
          .getWorkCommands(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: searchBar.build(context),
        body: Consumer<WorkCommandModel>(
          builder: (_, model, __) => model.isSearching
              ? (model.searchedData == null || model.searchedData.length == 0)
                  ? Center(
                      child: Text(
                        "Không tìm thấy dữ liệu",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : _buildListDataItem(
                      context: context, workCommands: model.searchedData)
              : Column(
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
                          TabBadge(StatusWorkCommand.pending, 'Chờ xử lý'),
                          TabBadge(StatusWorkCommand.cancelled, 'Hủy'),
                          TabBadge(StatusWorkCommand.performTask,
                              'Thực hiện công tác'),
                          TabBadge(StatusWorkCommand.waitingConfirm,
                              'Chờ xác nhận hoàn thành'),
                          TabBadge(StatusWorkCommand.notFinished,
                              'Kết thúc chưa xong'),
                          TabBadge(StatusWorkCommand.confirmed, 'Đã xác nhận'),
                          TabBadge(StatusWorkCommand.completedNotDone,
                              'Kết thúc(Chưa hoàn thành)'),
                          TabBadge(StatusWorkCommand.completedDone,
                              'Kết thúc(Hoàn thành)')
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          WorkCommandTabView(
                            status: StatusWorkCommand.pending,
                          ),
                          WorkCommandTabView(
                            status: StatusWorkCommand.cancelled,
                          ),
                          WorkCommandTabView(
                            status: StatusWorkCommand.performTask,
                          ),
                          WorkCommandTabView(
                            status: StatusWorkCommand.waitingConfirm,
                          ),
                          WorkCommandTabView(
                            status: StatusWorkCommand.notFinished,
                          ),
                          WorkCommandTabView(
                            status: StatusWorkCommand.confirmed,
                          ),
                          WorkCommandTabView(
                            status: StatusWorkCommand.completedNotDone,
                          ),
                          WorkCommandTabView(
                            status: StatusWorkCommand.completedDone,
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

class WorkCommandTabView extends StatefulWidget {
  final StatusWorkCommand status;

  const WorkCommandTabView({Key key, @required this.status}) : super(key: key);

  @override
  WorkCommandTabViewState createState() {
    return new WorkCommandTabViewState();
  }
}

class WorkCommandTabViewState extends State<WorkCommandTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkCommandModel>(
      builder: (_, model, __) => model.isSearching
          ? Container()
          : Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height *
                        kDefaultAppBarBottom,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
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
                                    TextSpan(text: ' lệnh công tác'),
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
                          workCommands: model.getDataByStatus(widget.status)),
                )),
              ],
            ),
    );
  }
}

Widget _buildListDataItem({
  @required BuildContext context,
  @required List<WorkCommand> workCommands,
}) {
  Future<void> _onRefresh() async {
    Provider.of<WorkCommandModel>(context, listen: false)
        .getWorkCommands(true);
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        itemCount: workCommands.length,
        itemBuilder: (context, index) {
          return ListItemInfo(
            itemPairsData: [
              {
                'icon': 'ic_circle',
                'content': workCommands[index].noiDungCongTac,
                'color': kWorkCommandStatusColor[EnumToString.convertToString(
                    workCommands[index].getStatus())],
              },
              {
                'status': workCommands[index].getStatusName(),
                'color': kWorkCommandStatusColor[EnumToString.convertToString(
                    workCommands[index].getStatus())],
              },
              {
                'icon': 'ic_page',
                'content': 'Số lệnh công tác : ${workCommands[index].code}',
              },
              {
                'icon': 'ic_clock',
                'content':
                    'Ngày lập lệnh công tác : ${workCommands[index].ngayLap.toDate(Constant.ddMMyyyy)}',
              },
              {
                'icon': 'ic_avatar',
                'content': 'Người lập : ${workCommands[index].nguoiLap}',
              },
              {
                'icon': 'ic_location',
                'content':
                    'Địa điểm thực hiện : ${workCommands[index].diaDiem}',
              },
              {
                'icon': 'ic_page',
                'content': 'Nội dung : ${workCommands[index].noiDungCongTac}',
              },
            ],
            onTap: () => _showActionsDialog(context, workCommands[index]),
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
  final StatusWorkCommand status;

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
          Consumer<WorkCommandModel>(
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
          arguments:
              FilterPushArguments(pushScreen: FilterPushType.workCommand))
      as FilterPopArguments;
  //Change Tab base on Status
  //TODO Not render Tabbar items
  // DefaultTabController.of(context)
  //     .animateTo(result.status != 0 ? result.status - 1 : 0);
  //Filter data in model
  Provider.of<WorkCommandModel>(context, listen: false).filter(result);
}

void _showActionsDialog(BuildContext context, WorkCommand model) {
  ModalBottomSheetDialog modalBottomSheetDialog = ModalBottomSheetDialog(
    context: context,
    onTapListener: (item) async {
      if (item.key == '2') {
        Navigator.pushNamed(
            context, RouteList.electrical_safety_work_command_detail,
            arguments: WorkCommandArguments(workCommand: model));
      } else if (item.key == '3') {
        Navigator.pushNamed(
            context, RouteList.electrical_safety_work_command_add_member,
            arguments: WorkCommandArguments(workCommand: model));
      } else if (item.key == '4') {
        Navigator.pushNamed(
            context, RouteList.electrical_safety_work_command_add_sequence,
            arguments: WorkCommandArguments(workCommand: model));
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
        final result =
            await Provider.of<WorkCommandModel>(context, listen: false)
                .notifyComplete(model.iD);
        if (result != null) {
          NotificationDialog.show(
              context,
              result.isSuccess() ? 'ic_success' : 'ic_error',
              result.isSuccess() ? 'Thành công' : result.messages);
          Provider.of<WorkCommandModel>(context, listen: false)
              .getWorkCommands(true);
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
                  ? 'Hủy lệnh công tác thành công'
                  : 'Đã xảy ra lỗi, Vui lòng thử lại');
          Provider.of<WorkCommandModel>(context, listen: false)
              .getWorkCommands(true);
        }
      }
    },
  );
  List<ModalBottomSheetItemPair> data = [];
  data.add(ModalBottomSheetItemPair(key: "1", content: model.noiDungCongTac));
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
  if (model.isActionBoSungTrinhTu)
    data.add(ModalBottomSheetItemPair(
        key: "4",
        icon: SvgImage(
          svgName: "ic_add_checked",
          size: 15,
        ),
        content: 'Bổ sung trình tự công việc'));
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
        content: 'Hủy lệnh công tác'));
  modalBottomSheetDialog.showBottomSheetDialog(data);
}

Future<StatusResponse> _showChangeDirectCommanderDialog(
    BuildContext context, WorkCommand workCommand) async {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _safetyCardNumberTextController =
      TextEditingController();
  TextEditingController _changeReasonTextController = TextEditingController();
  Users _selectedUser;

  ListMemberResponse memberResponse =
      await Provider.of<WorkCommandModel>(context, listen: false)
          .getDirectCommanderList(workCommand.iDChiHuy);

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
                        final result = await Provider.of<WorkCommandModel>(
                                context,
                                listen: false)
                            .changeDirectCommander(
                          workCommand.iD,
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
    BuildContext context, WorkCommand workCommand) async {
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
                      items: workCommand.users,
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
                        final result = await Provider.of<WorkCommandModel>(
                                context,
                                listen: false)
                            .changeShiftLeader(
                          workCommand.iD,
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
    BuildContext context, WorkCommand workCommand) async {
  TextEditingController _nguoiChoPhepTextController = TextEditingController();
  TextEditingController _nguoiChoPhepTCTextController = TextEditingController();
  TextEditingController _contentTextController = TextEditingController();
  ShiftLeaders _selectedNguoiChoPhep;
  ShiftLeaders _selectedNguoiChoPhepTC;

  WorkCommandModel workCommandModel =
      Provider.of<WorkCommandModel>(context, listen: false);
  await workCommandModel.getWorkCommandDetail(workCommand.iD);

  if (workCommandModel.detailData.thongTinChung.iDNguoiChoPhep != null &&
      workCommandModel.detailData.thongTinChung.iDNguoiChoPhep > 0) {
    _selectedNguoiChoPhep = workCommand.users.firstWhere(
        (user) =>
            workCommandModel.detailData.thongTinChung.iDNguoiChoPhep == user.iD,
        orElse: () => null);
  }

  if (workCommandModel.detailData.thongTinChung.iDNguoiChoPhepTaiCho != null &&
      workCommandModel.detailData.thongTinChung.iDNguoiChoPhepTaiCho > 0) {
    _selectedNguoiChoPhepTC = workCommand.users.firstWhere(
        (user) =>
            workCommandModel.detailData.thongTinChung.iDNguoiChoPhepTaiCho ==
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
                      items: workCommand.users,
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
                      items: workCommand.users,
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
                        final result = await Provider.of<WorkCommandModel>(
                            context,
                            listen: false)
                            .changeAssignment(
                          workCommand.iD,
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
    BuildContext context, WorkCommand workCommand) async {
  final result = await showDialog(
    context: context,
    builder: (BuildContext context) => CustomTwoButtonDialog(
      context: context,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Text(
          'Xác nhận hủy lệnh công tác',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'Bạn có đồng ý hủy lệnh công tác ?',
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
        final result =
            await Provider.of<WorkCommandModel>(context, listen: false)
                .confirmCancel(workCommand.iD);
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