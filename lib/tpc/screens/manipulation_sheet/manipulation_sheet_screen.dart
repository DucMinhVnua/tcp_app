import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/manipulation_sheet_model.dart';
import 'package:workflow_manager/models/response/manipulation_sheets_response.dart';
import 'package:workflow_manager/routes/route.dart';
import 'package:workflow_manager/tpc/screens/manipulation_sheet/manipulation_sheet_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/other/bottom_sheet_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/search_app_bar.dart';

class ManipulationSheetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManipulationSheetScreenState();
  }
}

class _ManipulationSheetScreenState extends State<ManipulationSheetScreen> {
  SearchBar searchBar;

  _ManipulationSheetScreenState() {
    searchBar = new SearchBar(
        inBar: true,
        buildDefaultAppBar: buildSearchBar,
        suggestionsCallback: (pattern) async {
          return await Provider.of<ManipulationSheetModel>(context,
                  listen: false)
              .generateSuggestion(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.code),
          );
        },
        //TODO Find search pattern as Json Models
        suggestionSelectedPattern: "Code",
        setState: setState,
        hintText: '',
        onSubmitted: (value) {
          Provider.of<ManipulationSheetModel>(context, listen: false)
              .search(value);
        },
        onOpened: () {
          Provider.of<ManipulationSheetModel>(context, listen: false)
              .searchedData = [];
          Provider.of<ManipulationSheetModel>(context, listen: false)
              .isSearching = true;
        },
        onClosed: () {
          Provider.of<ManipulationSheetModel>(context, listen: false)
              .isSearching = false;
        });
  }

  AppBar buildSearchBar(BuildContext context) {
    return new AppBar(
        elevation: 2,
        backgroundColor: kColorPrimary,
        title: Text('Phiếu thao tác'),
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ManipulationSheetModel>(context, listen: false)
          .getManipulationSheets(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: searchBar.build(context),
        body: Consumer<ManipulationSheetModel>(
          builder: (_, model, __) => model.isSearching
              ? (model.searchedData == null || model.searchedData.length == 0)
                  ? Center(
                      child: Text(
                        "Không tìm thấy dữ liệu",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : _buildListDataItem(
                      context: context, manipulationSheets: model.searchedData)
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
                          TabBadge(StatusManipulationSheet.electrical_safety,
                              'Điện'),
                          TabBadge(StatusManipulationSheet.mechanical_safety,
                              'Cơ nhiệt hóa'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          MechanicalWorkCommandTabView(
                            status: StatusManipulationSheet.electrical_safety,
                          ),
                          MechanicalWorkCommandTabView(
                            status: StatusManipulationSheet.mechanical_safety,
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

class MechanicalWorkCommandTabView extends StatefulWidget {
  final StatusManipulationSheet status;

  const MechanicalWorkCommandTabView({Key key, @required this.status})
      : super(key: key);

  @override
  MechanicalWorkCommandTabViewState createState() {
    return new MechanicalWorkCommandTabViewState();
  }
}

class MechanicalWorkCommandTabViewState
    extends State<MechanicalWorkCommandTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ManipulationSheetModel>(
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
                                    TextSpan(text: ' phiếu thao tác'),
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
                          manipulationSheets:
                              model.getDataByStatus(widget.status)),
                )),
              ],
            ),
    );
  }
}

Widget _buildListDataItem({
  @required BuildContext context,
  @required List<ManipulationSheet> manipulationSheets,
}) {
  Future<void> _onRefresh() async {
    Provider.of<ManipulationSheetModel>(context, listen: false)
        .getManipulationSheets(true);
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        itemCount: manipulationSheets.length,
        itemBuilder: (context, index) {
          return ListItemInfo(
            itemPairsData: [
              {
                'icon': 'ic_circle',
                'content': manipulationSheets[index].code,
                'color': kManipulationSheetsStatusColor[
                    EnumToString.convertToString(
                        manipulationSheets[index].getStatus())],
              },
              {
                'status': manipulationSheets[index].getStatusName(),
                'color': kManipulationSheetsStatusColor[
                    EnumToString.convertToString(
                        manipulationSheets[index].getStatus())],
              },
              {
                'icon': 'ic_avatar',
                'content':
                    'Người giám sát : ${manipulationSheets[index].nguoiGiamSat}',
              },
              {
                'icon': 'ic_avatar',
                'content':
                    'Người thao tác : ${manipulationSheets[index].nguoiThaoTac}',
              },
              {
                'icon': 'ic_clock',
                'content':
                    'Ngày lập phiếu : ${manipulationSheets[index].ngayLap.toDate(Constant.ddMMyyyy)}',
              },
            ],
            onTap: () => _showActionsDialog(context, manipulationSheets[index]),
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
  final StatusManipulationSheet status;

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
          Consumer<ManipulationSheetModel>(
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
              FilterPushArguments(pushScreen: FilterPushType.manipulationSheet))
      as FilterPopArguments;
  //Change Tab base on Status
  // DefaultTabController.of(context)
  //     .animateTo(result.status != 0 ? result.status - 1 : 0);
  //Filter data in model
  Provider.of<ManipulationSheetModel>(context, listen: false).filter(result);
}

void _showActionsDialog(BuildContext context, ManipulationSheet model) {
  ModalBottomSheetDialog modalBottomSheetDialog = ModalBottomSheetDialog(
    context: context,
    onTapListener: (item) async {
      if (item.key == '2') {
        Navigator.pushNamed(context, RouteList.manipulation_sheet_detail,
            arguments: ManipulationSheetArguments(manipulationSheet: model));
      } else if (item.key == '3') {
        Navigator.pop(context);
        final result =
            await Provider.of<ManipulationSheetModel>(context, listen: false)
                .notifyComplete(model.iD);
        if (result != null) {
          NotificationDialog.show(
              context,
              result.isSuccess() ? 'ic_success' : 'ic_error',
              result.isSuccess() ? 'Thành công' : result.messages);
          Provider.of<ManipulationSheetModel>(context, listen: false)
              .getManipulationSheets(true);
        }
      }
    },
  );
  List<ModalBottomSheetItemPair> data = [];
  data.add(ModalBottomSheetItemPair(key: "1", content: model.code));
  data.add(ModalBottomSheetItemPair(
      key: "2",
      icon: SvgImage(
        svgName: "ic_eye",
        size: 15,
      ),
      content: 'Xem chi tiết'));
  if (model.isActionThongBaoHoanThanh)
    data.add(ModalBottomSheetItemPair(
        key: "3",
        icon: SvgImage(
          svgName: "ic_check",
          size: 15,
        ),
        content: 'Thông báo hoàn thành công việc'));
  modalBottomSheetDialog.showBottomSheetDialog(data);
}
