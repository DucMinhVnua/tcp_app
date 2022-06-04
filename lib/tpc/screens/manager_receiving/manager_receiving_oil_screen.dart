import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/manager_receiving_oil_model.dart';
import 'package:workflow_manager/models/response/manager_receiving_oils_response.dart';
import 'package:workflow_manager/routes/route.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_oil_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/other/bottom_sheet_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/search_app_bar.dart';

class ManagerReceivingOilScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManagerReceivingOilScreenState();
  }
}

class _ManagerReceivingOilScreenState extends State<ManagerReceivingOilScreen> {
  SearchBar searchBar;

  _ManagerReceivingOilScreenState() {
    searchBar = new SearchBar(
        inBar: true,
        buildDefaultAppBar: buildSearchBar,
        suggestionsCallback: (pattern) async {
          return await Provider.of<ManagerReceivingOilModel>(context,
                  listen: false)
              .generateSuggestion(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.typeName),
          );
        },
        //TODO Find search pattern as Json Models
        suggestionSelectedPattern: "TypeName",
        setState: setState,
        hintText: '',
        onSubmitted: (value) {
          Provider.of<ManagerReceivingOilModel>(context, listen: false)
              .search(value);
        },
        onOpened: () {
          Provider.of<ManagerReceivingOilModel>(context, listen: false)
              .searchedData = [];
          Provider.of<ManagerReceivingOilModel>(context, listen: false)
              .isSearching = true;
        },
        onClosed: () {
          Provider.of<ManagerReceivingOilModel>(context, listen: false)
              .isSearching = false;
        });
  }

  AppBar buildSearchBar(BuildContext context) {
    return new AppBar(
        elevation: 2,
        backgroundColor: kColorPrimary,
        title: Text('Tiếp nhận hồ sơ dầu'),
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
    Provider.of<ManagerReceivingOilModel>(context, listen: false)
        .getManagerReceivingOils(true);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: searchBar.build(context),
        body: Consumer<ManagerReceivingOilModel>(
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
                      managerReceivingOils: model.searchedData)
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
                          TabBadge(StatusManagerReceivingOil.receiptOfFuel,
                              'Tiếp nhận nhiên liệu'),
                          TabBadge(StatusManagerReceivingOil.oilSuddenlyBought,
                              'Dầu mua đột xuất'),
                          TabBadge(StatusManagerReceivingOil.quarterlyPlan,
                              'Theo kế hoạch tháng quý'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          ManagerReceivingOilTabView(
                            status: StatusManagerReceivingOil.receiptOfFuel,
                          ),
                          ManagerReceivingOilTabView(
                            status: StatusManagerReceivingOil.oilSuddenlyBought,
                          ),
                          ManagerReceivingOilTabView(
                            status: StatusManagerReceivingOil.quarterlyPlan,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(
                  context, RouteList.manager_receiving_oil_create_receipt);
              if (result != null) {
                onRefresh();
              }
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}

class ManagerReceivingOilTabView extends StatefulWidget {
  final StatusManagerReceivingOil status;

  const ManagerReceivingOilTabView({Key key, @required this.status})
      : super(key: key);

  @override
  ManagerReceivingOilTabViewState createState() {
    return new ManagerReceivingOilTabViewState();
  }
}

class ManagerReceivingOilTabViewState
    extends State<ManagerReceivingOilTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerReceivingOilModel>(
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
                          managerReceivingOils:
                              model.getDataByStatus(widget.status)),
                )),
              ],
            ),
    );
  }
}

Widget _buildListDataItem({
  @required BuildContext context,
  @required List<ManagerReceivingOil> managerReceivingOils,
}) {
  Future<void> _onRefresh() async {
    Provider.of<ManagerReceivingOilModel>(context, listen: false)
        .getManagerReceivingOils(true);
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        itemCount: managerReceivingOils.length,
        itemBuilder: (context, index) {
          return ListItemInfo(
            itemPairsData: [
              {
                'content':
                    'Số tiếp nhận : ${managerReceivingOils[index].soTiepNhan}',
                'color': kManagerReceivingOilStatusColor[
                    EnumToString.convertToString(
                        managerReceivingOils[index].getStatus())],
              },
              {
                'status': managerReceivingOils[index].getStatusName(),
                'color': kManagerReceivingOilStatusColor[
                    EnumToString.convertToString(
                        managerReceivingOils[index].getStatus())],
              },
              {
                'icon': 'ic_page',
                'content':
                    'Loại : ${managerReceivingOils[index].getContractType()}',
              },
              {
                'icon': 'ic_clock',
                'content':
                    'Ngày tiếp nhận : ${managerReceivingOils[index].ngayTiepNhan.toDate(Constant.ddMMyyyy)}',
              },
              {
                'icon': 'ic_square',
                'content': 'Loại dầu : ${managerReceivingOils[index].loaiDau}',
              },
              {
                'icon': 'ic_delivery',
                'content':
                    'Hình thức vận chuyển : ${managerReceivingOils[index].getTransportType()}',
              },
              {
                'icon': 'ic_location',
                'content':
                    'Địa điểm giao hàng : ${managerReceivingOils[index].diaDiemGiaoHang}',
              },
              {
                'icon': 'ic_clock',
                'content':
                    'Thời gian phương tiện đến : ${managerReceivingOils[index].thoiGianPhuongTienDen.toDate(Constant.ddMMyyyy)}',
              },
            ],
            onTap: () =>
                _showActionsDialog(context, managerReceivingOils[index]),
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
  final StatusManagerReceivingOil status;

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
          Consumer<ManagerReceivingOilModel>(
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
              FilterPushArguments(pushScreen: FilterPushType.receivingOil))
      as FilterPopArguments;
  //Change Tab base on Status
  // DefaultTabController.of(context)
  //     .animateTo(result.status != 0 ? result.status - 1 : 0);
  //Filter data in model
  Provider.of<ManagerReceivingOilModel>(context, listen: false).filter(result);
}

void _showActionsDialog(BuildContext context, ManagerReceivingOil model) {
  ModalBottomSheetDialog modalBottomSheetDialog = ModalBottomSheetDialog(
    context: context,
    onTapListener: (item) async {
      if (item.key == '2') {
        Navigator.pushNamed(context, RouteList.manager_receiving_oil_detail,
            arguments:
                ManagerReceivingOilArguments(managerReceivingOil: model));
      }
    },
  );
  List<ModalBottomSheetItemPair> data = [];
  data.add(ModalBottomSheetItemPair(key: "1", content: model.soTiepNhan));
  data.add(ModalBottomSheetItemPair(
      key: "2",
      icon: SvgImage(
        svgName: "ic_eye",
        size: 15,
      ),
      content: 'Xem chi tiết'));
  modalBottomSheetDialog.showBottomSheetDialog(data);
}
