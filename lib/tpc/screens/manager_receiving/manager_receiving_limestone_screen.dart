import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/manager_receiving_limestone_model.dart';
import 'package:workflow_manager/models/response/manager_receiving_lime_stones_response.dart';
import 'package:workflow_manager/routes/route.dart';
import 'package:workflow_manager/tpc/screens/other/bottom_sheet_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/search_app_bar.dart';

import 'manager_receiving_limestone_detail_screen.dart';

class ManagerReceivingLimestoneScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManagerReceivingLimestoneScreenState();
  }
}

class _ManagerReceivingLimestoneScreenState
    extends State<ManagerReceivingLimestoneScreen> {
  SearchBar searchBar;

  _ManagerReceivingLimestoneScreenState() {
    searchBar = new SearchBar(
        inBar: true,
        buildDefaultAppBar: buildSearchBar,
        suggestionsCallback: (pattern) async {
          return await Provider.of<ManagerReceivingLimestoneModel>(context,
                  listen: false)
              .generateSuggestion(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.soPhieuYeuCau),
          );
        },
        //TODO Find search pattern as Json Models
        suggestionSelectedPattern: "SoPhieuYeuCau",
        setState: setState,
        hintText: '',
        onSubmitted: (value) {
          Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
              .search(value);
        },
        onOpened: () {
          Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
              .searchedData = [];
          Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
              .isSearching = true;
        },
        onClosed: () {
          Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
              .isSearching = false;
        });
  }

  AppBar buildSearchBar(BuildContext context) {
    return new AppBar(
        elevation: 2,
        backgroundColor: kColorPrimary,
        title: Text('Tiếp nhận yêu cầu cấp Đá vôi'),
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  void onRefresh() {
    Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
        .getManagerReceivingLimestones(true);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: searchBar.build(context),
        body: Consumer<ManagerReceivingLimestoneModel>(
          builder: (_, model, __) => model.isSearching
              ? (model.searchedData == null || model.searchedData.length == 0)
                  ? Center(
                      child: Text(
                        "Không tìm thấy dữ liệu",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : _buildListDataItem(
                      context: context,
                      managerReceivingLimestones: model.searchedData)
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
                        isScrollable: false,
                        physics: ClampingScrollPhysics(),
                        tabs: [
                          TabBadge(StatusManagerLimestone.notComplete,
                              'Chưa hoàn thành'),
                          TabBadge(
                              StatusManagerLimestone.complete, 'Đã hoàn thành'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          ManagerReceivingLimestoneTabView(
                            status: StatusManagerLimestone.notComplete,
                          ),
                          ManagerReceivingLimestoneTabView(
                            status: StatusManagerLimestone.complete,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(context,
                  RouteList.manager_receiving_limestone_create_receipt);
              if (result != null) {
                onRefresh();
              }
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}

class ManagerReceivingLimestoneTabView extends StatefulWidget {
  final StatusManagerLimestone status;

  const ManagerReceivingLimestoneTabView({Key key, @required this.status})
      : super(key: key);

  @override
  ManagerReceivingLimestoneTabViewState createState() {
    return new ManagerReceivingLimestoneTabViewState();
  }
}

class ManagerReceivingLimestoneTabViewState
    extends State<ManagerReceivingLimestoneTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerReceivingLimestoneModel>(
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
                                    TextSpan(text: ' phiếu tiếp nhận hồ sơ'),
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
                          managerReceivingLimestones:
                              model.getDataByStatus(widget.status)),
                )),
              ],
            ),
    );
  }
}

Widget _buildListDataItem({
  @required BuildContext context,
  @required List<ManagerReceivingLimestone> managerReceivingLimestones,
}) {
  Future<void> _onRefresh() async {
    Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
        .getManagerReceivingLimestones(true);
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        itemCount: managerReceivingLimestones.length,
        itemBuilder: (context, index) {
          return ListItemInfo(
            itemPairsData: [
              {
                'content':
                    'Số phiếu yêu cầu : ${managerReceivingLimestones[index].soPhieuYeuCau}',
                'color': kManagerReceivingLimestoneStatusStatus[
                    EnumToString.convertToString(
                        managerReceivingLimestones[index].getStatus())],
              },
              {
                'status': managerReceivingLimestones[index].getStatusName(),
                'color': kManagerReceivingLimestoneStatusStatus[
                    EnumToString.convertToString(
                        managerReceivingLimestones[index].getStatus())],
              },
              {
                'icon': 'ic_clock',
                'content':
                    'Ngày tiếp nhận : ${managerReceivingLimestones[index].ngayGuiYeuCau.toDate(Constant.ddMMyyyy)}',
              },
              {
                'icon': 'ic_page',
                'content':
                    'Số hợp đồng : ${managerReceivingLimestones[index].soHopDong}',
              },
              {
                'icon': 'ic_clock',
                'content':
                    'Ngày hợp đồng : ${managerReceivingLimestones[index].ngayHopDong.toDate(Constant.ddMMyyyy)}',
              },
              {
                'icon': 'ic_page',
                'content':
                    'Số lượng : ${managerReceivingLimestones[index].soLuong}',
              },
              {
                'icon': 'ic_page',
                'content': 'Giá : ${managerReceivingLimestones[index].gia}',
              },
              {
                'icon': 'ic_location',
                'content':
                    'Địa điểm giao hàng : ${managerReceivingLimestones[index].diaDiemGiaoHang}',
              },
            ],
            onTap: () =>
                _showActionsDialog(context, managerReceivingLimestones[index]),
            showActions: false,
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
  final StatusManagerLimestone status;

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
          Consumer<ManagerReceivingLimestoneModel>(
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
      arguments: FilterPushArguments(
          pushScreen: FilterPushType.receivingLimestone)) as FilterPopArguments;
  //Change Tab base on Status
  // DefaultTabController.of(context)
  //     .animateTo(result.status != 0 ? result.status - 1 : 0);
  //Filter data in model
  Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
      .filter(result);
}

void _showActionsDialog(BuildContext context, ManagerReceivingLimestone model) {
  ModalBottomSheetDialog modalBottomSheetDialog = ModalBottomSheetDialog(
    context: context,
    onTapListener: (item) async {
      if (item.key == '2') {
        Navigator.pushNamed(
            context, RouteList.manager_receiving_limestone_detail,
            arguments: ManagerReceivingLimestoneArguments(
                managerReceivingLimestone: model));
      } else if (item.key == '3') {
        Navigator.pop(context);
        final response = await Provider.of<ManagerReceivingLimestoneModel>(
                context,
                listen: false)
            .sendNoticeComplete(model.iD);
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
        Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
            .getManagerReceivingLimestones(true);
      }
    },
  );
  List<ModalBottomSheetItemPair> data = [];
  data.add(ModalBottomSheetItemPair(key: "1", content: model.soPhieuYeuCau));
  data.add(ModalBottomSheetItemPair(
      key: "2",
      icon: SvgImage(
        svgName: "ic_eye",
        size: 15,
      ),
      content: 'Xem chi tiết'));
  if (model.isXacNhanHoanThanh)
    data.add(ModalBottomSheetItemPair(
        key: "3",
        icon: SvgImage(
          svgName: "ic_check",
          size: 15,
        ),
        content: 'Thông báo xác nhận hoàn thành'));
  modalBottomSheetDialog.showBottomSheetDialog(data);
}
