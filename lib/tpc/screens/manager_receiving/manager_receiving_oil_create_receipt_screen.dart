import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:workflow_manager/models/response/list_department_response.dart';
import 'package:workflow_manager/models/response/login_response.dart';
import 'package:workflow_manager/storage/utils/ImageUtils.dart';
import 'package:workflow_manager/tpc/models/response/upload_response.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class ManagerReceivingOilCreateReceiptScreen extends StatefulWidget {
  @override
  _ManagerReceivingOilCreateReceiptScreenState createState() =>
      _ManagerReceivingOilCreateReceiptScreenState();
}

class _ManagerReceivingOilCreateReceiptScreenState
    extends State<ManagerReceivingOilCreateReceiptScreen> {
  TextEditingController receiptNoTextController = TextEditingController();
  TextEditingController receiptDateTextController = TextEditingController();
  TextEditingController vehicleArrivalTimeTextController =
      TextEditingController();
  TextEditingController transportTypeTextController = TextEditingController();
  TextEditingController placeReceiveTextController = TextEditingController();
  TextEditingController oilTypeTextController = TextEditingController();
  TextEditingController departmentReceiveNotificationsTextController =
      TextEditingController();
  TextEditingController contractNoTextController = TextEditingController();
  TextEditingController contractDateTextController = TextEditingController();
  TextEditingController contractTypeTextController = TextEditingController();

  //TODO add ID DEPTS
  List<String> transportTypeList = [
    "Vận chuyển đường thủy nội địa",
    "Vận chuyển đường thủy",
    "Vận chuyển đường bộ"
  ];
  List<String> contractTypeList = [
    "Tiếp nhận nhiên liệu",
    "Dầu mua đột xuất",
    "Theo kế hoạch tháng quý"
  ];
  List<String> receivingOilSheetList = [
    "Phiếu tiếp nhận dầu ",
  ];

  List<Depts> _departmentList = [];
  List<String> _departmentNames = [];
  List<int> _departmentIds = [];
  List<String> _departmentNameSelected = [];

  int transportType;
  int contractType;

  // Validate
  bool receiptNoValidation = false;
  bool receiptDateValidation = false;

  // bool receiverValidation = false;
  bool vehicleArrivalTimeValidation = false;
  bool transportTypeValidation = false;
  bool placeReceiveValidation = false;
  bool oilTypeValidation = false;
  bool departmentReceiveNotificationsValidation = false;
  bool contractTypeValidation = false;

  User _currentUser;

  final _multiKey = GlobalKey<DropdownSearchState<String>>();

  List<UploadModel> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getListDept();
      getCurrentUser();
    });
  }

  @override
  void dispose() {
    receiptNoTextController.dispose();
    receiptDateTextController.dispose();
    // receiverTextController.dispose();
    vehicleArrivalTimeTextController.dispose();
    transportTypeTextController.dispose();
    placeReceiveTextController.dispose();
    oilTypeTextController.dispose();
    departmentReceiveNotificationsTextController.dispose();
    contractNoTextController.dispose();
    contractDateTextController.dispose();
    contractTypeTextController.dispose();

    super.dispose();
  }

  Future<void> getCurrentUser() async {
    _currentUser = await SharedPreferencesClass.getUser();
    setState(() {});
  }

  Future<void> getListDept() async {
    final response =
        await Provider.of<ManagerReceivingOilModel>(context, listen: false)
            .getListDepartment(1000);
    if (response.isSuccess()) {
      _departmentList = response.data.depts;
      if (_departmentList.isNotEmpty) {
        if (_departmentNames.isNotEmpty) {
          _departmentNames.clear();
        }
        for (int i = 0; i < _departmentList.length; i++) {
          _departmentNames.add(_departmentList[i].name);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tạo mới tiếp nhận hồ sơ"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Huỷ",
                  style: kDefaultTextStyle.copyWith(color: Colors.white)),
              // style: TextButton.styleFrom(primary: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Số tiếp nhận',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: receiptNoTextController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                    errorText: receiptNoValidation
                        ? 'Số tiếp nhận không được để trống'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Ngày tiếp nhận',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: receiptDateTextController,
                  readOnly: true,
                  onTap: () {
                    DateTimePickerWidget(
                            context: context,
                            format: Constant.ddMMyyyyHHmm2,
                            onDateTimeSelected: (value) {
                              setState(() {
                                receiptDateTextController.text = value;
                              });
                            },
                            maxTime:
                                DateTime.now().add(const Duration(days: 30)),
                            minTime:
                                DateTime.now().add(const Duration(days: -30)))
                        .showDateTimePicker();
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    suffixIconConstraints:
                        BoxConstraints(minHeight: 16.3, minWidth: 17),
                    suffixIcon: SvgImage(svgName: 'ic_date_picker'),
                    contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                    errorText: receiptDateValidation
                        ? 'Ngày tiếp nhận không được để trống'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Người tiếp nhận',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 8.0, right: 20.0),
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
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Thời gian phương tiện đến',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: vehicleArrivalTimeTextController,
                  readOnly: true,
                  onTap: () {
                    DateTimePickerWidget(
                            context: context,
                            format: Constant.ddMMyyyyHHmm2,
                            onDateTimeSelected: (value) {
                              setState(() {
                                vehicleArrivalTimeTextController.text = value;
                              });
                            },
                            maxTime:
                                DateTime.now().add(const Duration(days: 30)),
                            minTime:
                                DateTime.now().add(const Duration(days: -30)))
                        .showDateTimePicker();
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    suffixIconConstraints:
                        BoxConstraints(minHeight: 16.3, minWidth: 17),
                    suffixIcon: SvgImage(svgName: 'ic_date_picker'),
                    contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                    errorText: vehicleArrivalTimeValidation
                        ? 'Thời gian phương tiện đến không được để trống'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Hình thức vận chuyển',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  maxHeight: 170.0,
                  dropdownButtonBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SvgImage(
                        svgName: 'ic_dropdown',
                        size: 6.0,
                      ),
                    );
                  },
                  items: transportTypeList,
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    errorText: transportTypeValidation
                        ? 'Hình thức vận chuyển không được để trống'
                        : null,
                  ),
                  onChanged: (transportTypeName) {
                    transportTypeTextController.text = transportTypeName;
                    transportType =
                        transportTypeList.indexOf(transportTypeName) + 1;
                  },
                  showSearchBox: false,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Địa điểm giao hàng',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: placeReceiveTextController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                    errorText: placeReceiveValidation
                        ? 'Địa điểm giao hàng không được để trống'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Loại dầu',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: oilTypeTextController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                    errorText: oilTypeValidation
                        ? 'Loại dầu không được để trống'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Đơn vị nhận thông báo',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 5.0, right: 20.0),
                child: DropdownSearch<String>.multiSelection(
                  showSelectedItems: true,
                  key: _multiKey,
                  validator: (List<String> v) {
                    return v == null || v.isEmpty ? "required field" : null;
                  },
                  dropdownBuilder: (context, selectedItems) {
                    _departmentNameSelected = selectedItems;

                    Widget item(String i) {
                      return Container(
                        margin: EdgeInsets.only(right: 4.0),
                        child: Text(
                          '$i, ',
                          textAlign: TextAlign.center,
                          style: kDefaultTextStyle,
                        ),
                      );
                    }

                    return Wrap(
                        children: selectedItems.map((e) => item(e)).toList());
                  },
                  dropdownButtonBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SvgImage(
                        svgName: 'ic_dropdown',
                        size: 6.0,
                      ),
                    );
                  },
                  popupCustomMultiSelectionWidget: (context, list) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: OutlinedButton(
                            onPressed: () {
                              _departmentNameSelected = _departmentNames;
                              _multiKey.currentState?.popupSelectAllItems();
                            },
                            child: const Text('Chọn tất cả'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: OutlinedButton(
                            onPressed: () {
                              if (_departmentNameSelected.isNotEmpty) {
                                _departmentNameSelected.clear();
                              }
                              _multiKey.currentState?.popupDeselectAllItems();
                            },
                            child: const Text('Bỏ chọn'),
                          ),
                        ),
                      ],
                    );
                  },
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8, bottom: 12),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    errorText: departmentReceiveNotificationsValidation
                        ? 'Đơn vị nhận thông báo không được để trống'
                        : null,
                  ),
                  mode: Mode.MENU,
                  items: _departmentNames,
                  popupItemBuilder: (context, String item, bool isSelected) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                                isSelected
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: isSelected ? kBlue1 : kGrey6),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                item,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: kDefaultTextStyle,
                              ),
                            ))
                          ]),
                    );
                  },
                  popupSelectionWidget:
                      (context, String item, bool isSelected) {
                    return Container();
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Text(
                  'Số hợp đồng',
                  style: kSmallGreyTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: contractNoTextController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Text(
                  'Ngày hợp đồng',
                  style: kSmallGreyTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: contractDateTextController,
                  readOnly: true,
                  onTap: () {
                    DateTimePickerWidget(
                            context: context,
                            format: Constant.ddMMyyyyHHmm2,
                            onDateTimeSelected: (value) {
                              setState(() {
                                contractDateTextController.text = value;
                              });
                            },
                            maxTime:
                                DateTime.now().add(const Duration(days: 30)),
                            minTime:
                                DateTime.now().add(const Duration(days: -30)))
                        .showDateTimePicker();
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    suffixIconConstraints:
                        BoxConstraints(minHeight: 16.3, minWidth: 17),
                    suffixIcon: SvgImage(svgName: 'ic_date_picker'),
                    contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Loại',
                      style: kSmallGreyTextStyle,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '*',
                      style: kSmallGreyTextStyle.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  maxHeight: 170.0,
                  dropdownButtonBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SvgImage(
                        svgName: 'ic_dropdown',
                        size: 6.0,
                      ),
                    );
                  },
                  items: contractTypeList,
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kGrey1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue1),
                    ),
                    labelStyle: kDefaultTextStyle,
                    isDense: true,
                    errorText: contractTypeValidation
                        ? 'Loại không được để trống'
                        : null,
                  ),
                  onChanged: (transportTypeName) {
                    contractTypeTextController.text = transportTypeName;
                    setState(() {
                      contractType =
                          contractTypeList.indexOf(transportTypeName) + 1;
                    });
                  },
                  showSearchBox: false,
                ),
              ),
              Visibility(
                visible: contractType == 2,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
                  child: Row(
                    children: [
                      Text(
                        'Phiếu tiếp nhận dầu',
                        style: kSmallGreyTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: contractType == 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownSearch<String>(
                    mode: Mode.MENU,
                    maxHeight: 170.0,
                    dropdownButtonBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: SvgImage(
                          svgName: 'ic_dropdown',
                          size: 6.0,
                        ),
                      );
                    },
                    selectedItem: 'Phiếu tiếp nhận dầu',
                    showSelectedItems: true,
                    items: receivingOilSheetList,
                    dropdownSearchDecoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGrey1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kBlue1),
                      ),
                      labelStyle: kDefaultTextStyle,
                      isDense: true,
                    ),
                    showSearchBox: false,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
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
              for (UploadModel model in uploadedFiles)
                buildUploadedModelCard(model),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DottedBorder(
                        dashPattern: [8, 5],
                        color: kGrey6,
                        strokeWidth: 1.0,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(8.0),
                        child: TextButton(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 16.0),
                                  SvgImage(
                                    svgName: 'ic_attach',
                                    size: 16.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'File đính kèm',
                                    style: kDefaultTextStyle.copyWith(
                                        color: kGrey7),
                                  ),
                                ],
                              )),
                          onPressed: () {
                            attachedAndUploadFile();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 12.0, right: 20.0),
                child: Text(
                  'Accepted format: PNG, JPEG, or PDF. Up to 5MB',
                  style: kSmallGreyTextStyle.copyWith(
                      color: kGrey8, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 36.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'THÊM',
                            style: kDefaultTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
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
                          if (receiptNoTextController.text.isEmpty ||
                              receiptDateTextController.text.isEmpty ||
                              vehicleArrivalTimeTextController.text.isEmpty ||
                              transportTypeTextController.text.isEmpty ||
                              placeReceiveTextController.text.isEmpty ||
                              oilTypeTextController.text.isEmpty ||
                              _departmentNameSelected.isNullOrEmpty ||
                              contractTypeTextController.text.isEmpty) {
                            setState(() {
                              receiptNoValidation =
                                  receiptNoTextController.text.isEmpty;
                              receiptDateValidation =
                                  receiptDateTextController.text.isEmpty;
                              vehicleArrivalTimeValidation =
                                  vehicleArrivalTimeTextController.text.isEmpty;
                              transportTypeValidation =
                                  transportTypeTextController.text.isEmpty;
                              placeReceiveValidation =
                                  placeReceiveTextController.text.isEmpty;
                              oilTypeValidation =
                                  oilTypeTextController.text.isEmpty;
                              departmentReceiveNotificationsValidation =
                                  _departmentNameSelected.isNullOrEmpty;
                              contractTypeValidation =
                                  contractTypeTextController.text.isEmpty;
                            });
                            return;
                          } else {
                            if (_currentUser == null) {
                              ToastMessage.show(
                                  'Không tìm thấy user', ToastStyle.error);
                              return;
                            }
                            if (_departmentIds.isNotEmpty) {
                              _departmentIds.clear();
                            }
                            for (var i = 0; i < _departmentList.length; i++) {
                              for (var j = 0;
                                  j < _departmentNameSelected.length;
                                  j++) {
                                if (_departmentNameSelected[j] ==
                                    _departmentList[i].name) {
                                  _departmentIds.add(_departmentList[i].iD);
                                }
                              }
                            }

                            final response =
                                await Provider.of<ManagerReceivingOilModel>(
                                        context,
                                        listen: false)
                                    .createReceipt(
                              receiptNoTextController.text,
                              receiptDateTextController.text,
                              _currentUser.iDUserDocPro,
                              vehicleArrivalTimeTextController.text,
                              transportType,
                              oilTypeTextController.text,
                              _departmentIds,
                              contractNoTextController.text,
                              contractDateTextController.text,
                              contractType,
                              placeReceiveTextController.text,
                              uploadedFiles.isNullOrEmpty
                                  ? []
                                  : uploadedFiles
                                      .map((_) => _.fileName)
                                      .toList(),
                              uploadedFiles.isNullOrEmpty
                                  ? []
                                  : uploadedFiles
                                      .map((_) => _.filePath)
                                      .toList(),
                            );
                            Navigator.of(context).pop(response);
                            NotificationDialog.show(
                                context,
                                response.isSuccess()
                                    ? 'ic_success'
                                    : 'ic_error',
                                response.isSuccess()
                                    ? 'Tạo hồ sơ thành công'
                                    : 'Đã xảy ra lỗi, Vui lòng thử lại');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> attachedAndUploadFile() async {
    UploadModel uploaded = await FileUtils.instance.uploadFileFromSdcard(
        context,
        fileType: FileType.custom,
        allowExtentions: ['jpg', 'pdf', 'png', 'jpeg']);
    if (uploaded != null &&
        uploaded.uploadStatus == UploadStatus.upload_success) {
      setState(() {
        uploadedFiles.add(uploaded);
      });
    }
  }

  Widget buildUploadedModelCard(UploadModel model) {
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
              child: Text(model.fileName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: kDefaultTextStyle.copyWith(
                      fontWeight: FontWeight.w700, color: kColorPrimary)),
            ),
            SvgImage(
              svgName: "ic_delete",
              onTap: () {
                setState(() {
                  uploadedFiles.remove(model);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
