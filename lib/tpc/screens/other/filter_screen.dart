import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/base/ui/date_time_picker_widget.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';

final Map<int, String> filterStatusMap1 = {
  0: "Toàn bộ",
  1: "Chờ xử lý",
  2: "Hủy",
  3: "Thực hiện công tác",
  4: "Chờ xác nhận hoàn thành",
  5: "Kết thúc chưa xong",
  6: "Đã xác nhận",
  7: "Kết thúc(Chưa hoàn thành)",
  8: "Kết thúc(Hoàn thành)"
};

final Map<int, String> filterStatusMap5 = {
  0: "Toàn bộ",
  1: "Đang cấp phép",
  2: "Thực hiện lại công tác",
  3: "Thực hiện công tác",
  4: "Chờ xác nhận hoàn thành",
  5: "Kết thúc chưa xong",
  6: "Đã xác nhận",
  7: "Hoàn thành",
  8: "Hủy",
};

final Map<int, String> filterStatusMap2 = {
  0: "Toàn bộ",
  1: "Tiếp nhận nhiên liệu",
  2: "Dầu mua đột xuất",
  3: "Theo kế hoạch tháng quý"
};

final Map<int, String> filterStatusMap3 = {
  0: "Toàn bộ",
  1: "Điện",
  2: "Cơ nhiệt hóa",
};

final Map<int, String> filterStatusMap4 = {
  0: "Toàn bộ",
  1: "Chưa hoàn thành",
  2: "Đã hoàn thành",
};

enum FilterPushType {
  workCommand,
  workSheet,
  receivingOil,
  receivingLimestone,
  manipulationSheet
}

class FilterPushArguments {
  FilterPushType pushScreen;

  FilterPushArguments({
    this.pushScreen,
  });
}

class FilterPopArguments {
  String startDate;
  String endDate;
  int status;
  String location;

  FilterPopArguments(
      [this.startDate = '',
      this.endDate = '',
      this.status = 0,
      this.location = '']);

  void clearFilter() {
    this.startDate = '';
    this.endDate = '';
    this.status = 0;
    this.location = '';
  }
}

class FilterScreen extends StatefulWidget {
  final FilterPushType pushScreen;

  const FilterScreen({
    this.pushScreen,
  });

  @override
  State<StatefulWidget> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterPopArguments _filterArguments = FilterPopArguments();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _willPopCallback() async {
    _submitFilter();
    return true;
  }

  void _submitFilter() {
    Navigator.pop(context, _filterArguments);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lọc'),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  _filterArguments.clearFilter();
                  ToastMessage.show('Đã xóa bộ lọc', ToastStyle.normal);
                });
              },
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: new Text(
                      "Xóa",
                      style: kDefaultTextStyle.copyWith(color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            _buildFilterField(SvgImage(svgName: 'ic_date_picker'), 'Từ ngày',
                _filterArguments.startDate, () {
              DateTimePickerWidget(
                      context: context,
                      format: Constant.ddMMyyyy,
                      onDateTimeSelected: (value) {
                        setState(() {
                          _filterArguments.startDate = value;
                        });
                      },
                      maxTime: DateTime.now().add(const Duration(days: 30)),
                      minTime: DateTime.now().add(const Duration(days: -30)))
                  .showDateTimePicker();
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 2,
                color: kGrey2,
              ),
            ),
            _buildFilterField(SvgImage(svgName: 'ic_date_picker'), 'Đến ngày',
                _filterArguments.endDate, () {
              DateTimePickerWidget(
                      context: context,
                      format: Constant.ddMMyyyy,
                      onDateTimeSelected: (value) {
                        setState(() {
                          _filterArguments.endDate = value;
                        });
                      },
                      maxTime: DateTime.now().add(const Duration(days: 30)),
                      minTime: DateTime.now().add(const Duration(days: -30)))
                  .showDateTimePicker();
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 2,
                color: kGrey2,
              ),
            ),
            _buildFilterStatusField(widget.pushScreen),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 2,
                color: kGrey2,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () => {
                      _submitFilter(),
                    },
                    child: Text(
                      'Áp dụng',
                      style: kDefaultTextStyle.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterField(SvgImage icon, String label, String value,
      GestureTapCallback onTabCallback) {
    return InkWell(
      onTap: onTabCallback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(children: [
          Expanded(
              flex: 5,
              child: Text(
                label,
                style: kDefaultTextStyle.copyWith(fontSize: 15),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  style:
                      kDefaultTextStyle.copyWith(fontSize: 14, color: kGrey2),
                ),
              )),
          Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: icon,
              )),
        ]),
      ),
    );
  }

  Widget _buildFilterStatusField(FilterPushType pushType) {
    switch (pushType) {
      case FilterPushType.workCommand:
        return _buildDropdownStatus(filterStatusMap1.values.toList(),
            (selected) {
          _filterArguments.status = filterStatusMap1.keys.firstWhere(
              (key) => filterStatusMap1[key] == selected,
              orElse: () => 0);
        });
        break;
      case FilterPushType.workSheet:
        return _buildDropdownStatus(filterStatusMap5.values.toList(),
            (selected) {
          _filterArguments.status = filterStatusMap5.keys.firstWhere(
              (key) => filterStatusMap5[key] == selected,
              orElse: () => 0);
        });
      case FilterPushType.manipulationSheet:
        return _buildDropdownStatus(filterStatusMap3.values.toList(),
            (selected) {
          _filterArguments.status = filterStatusMap3.keys.firstWhere(
              (key) => filterStatusMap3[key] == selected,
              orElse: () => 0);
        });
        break;
      case FilterPushType.receivingOil:
        return _buildDropdownStatus(filterStatusMap2.values.toList(),
            (selected) {
          _filterArguments.status = filterStatusMap2.keys.firstWhere(
              (key) => filterStatusMap2[key] == selected,
              orElse: () => 0);
        });
      case FilterPushType.receivingLimestone:
        return _buildDropdownStatus(filterStatusMap4.values.toList(),
            (selected) {
          _filterArguments.status = filterStatusMap4.keys.firstWhere(
              (key) => filterStatusMap4[key] == selected,
              orElse: () => 0);
        });
    }
    return Container();
  }

  Widget _buildDropdownStatus(List<String> listStatus, ValueChanged onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5,
      ),
      child: DropdownSearch<String>(
        mode: Mode.MENU,
        showSelectedItems: true,
        selectedItem: listStatus[0],
        dropdownButtonBuilder: (context) {
          return Container();
        },
        dropdownBuilder: (context, selectedItem) {
          return Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Text(
                    'Trạng thái',
                    style: kDefaultTextStyle.copyWith(fontSize: 15),
                  )),
              Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      selectedItem,
                      style: kDefaultTextStyle.copyWith(
                          fontSize: 14, color: kGrey2),
                    ),
                  )),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(right: 3),
                    alignment: Alignment.centerRight,
                    child: SvgImage(svgName: 'ic_arrow_right'),
                  )),
            ],
          );
        },
        items: listStatus,
        dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          hintStyle: kDefaultTextStyle.copyWith(color: kGrey2),
        ),
        onChanged: onChanged,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          enableSuggestions: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade300,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.all(8.0),
            hintText: '',
          ),
        ),
      ),
    );
  }
}
