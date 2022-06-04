import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/network/api_caller.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/models/request/index_data_request.dart';
import 'package:workflow_manager/models/request/manager_receiving_limestone_requests.dart';
import 'package:workflow_manager/models/response/list_require_receiver_response.dart';
import 'package:workflow_manager/models/response/list_require_supply_limestone_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_lime_stones_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_limestone_detail_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';

class ManagerReceivingLimestoneModel with ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;

  bool isSearching = false;
  bool isLoading = false;
  bool isFiltered = false;

  List<ManagerReceivingLimestone> _data = [];
  List<ManagerReceivingLimestone> searchedData = [];
  List<ManagerReceivingLimestone> filteredData = [];

  ManagerReceivingLimestoneDetail detailData;
  ListRequireSupplyLimestone listRequireSupplyLimestone;

  // ListRequireReceiver listRequireReceiver;

  Future<void> getManagerReceivingLimestones(isLoadingDialog,
      [int pageIndex = 1,
      int pageSize = 1000,
      int term = 1,
      int status = 1]) async {
    isLoading = true;
    notifyListeners();
    IndexDataRequest request = IndexDataRequest();
    request.pageIndex = pageIndex;
    request.pageSize = pageSize;
    // request.term = term;
    // request.status = status;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_limestone, request.getParams(),
        isLoading: isLoadingDialog);
    final ManagerReceivingLimestonesResponse response =
        ManagerReceivingLimestonesResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      _data = filteredData = response.data.datas;
    } else {
      _data = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //get data, can apply filter
  List<ManagerReceivingLimestone> getData() {
    return isFiltered ? filteredData : _data;
  }

  //filter by status for Tab Bar display
  List<ManagerReceivingLimestone> getDataByStatus(
      StatusManagerLimestone status) {
    return getData().where((_) => _.getStatus() == status).toList();
  }

  //suggestions in appbar search Pattern : noiDungCongTac
  Future<List<ManagerReceivingLimestone>> generateSuggestion(
      String pattern) async {
    return pattern.isEmpty
        ? []
        : _data
            .where((_) =>
                _.soPhieuYeuCau.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
  }

  //search when submit in appbar Pattern : noiDungCongTac
  Future<void> search(String pattern) async {
    searchedData = pattern.isEmpty
        ? []
        : _data
            .where((_) =>
                _.soPhieuYeuCau.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
    notifyListeners();
  }

  //apply filter
  Future<void> filter(FilterPopArguments arguments) async {
    List<ManagerReceivingLimestone> result = _data;
    if (arguments.startDate.isNotNullOrEmpty) {
      result = result
          .where((_) =>
              _.ngayGuiYeuCau >=
              new DateFormat(Constant.ddMMyyyy)
                  .parse(arguments.startDate)
                  .millisecondsSinceEpoch)
          .toList();
    }
    if (arguments.endDate.isNotNullOrEmpty) {
      result = result
          .where((_) =>
              _.ngayGuiYeuCau <=
              new DateFormat(Constant.ddMMyyyy)
                  .parse(arguments.endDate)
                  .millisecondsSinceEpoch)
          .toList();
    }
    if (arguments.status != 0) {
      result = result
          .where((_) => (_.isXacNhanHoanThanh ? 1 : 2) == arguments.status)
          .toList();
    }
    if (result.length != _data.length) {
      isFiltered = true;
      filteredData = result;
      ToastMessage.show('Lọc thành công', ToastStyle.success);
    } else {
      isFiltered = false;
      filteredData = _data;
    }
    notifyListeners();
  }

  Future<void> getManagerReceivingLimestoneDetail(int id) async {
    ManagerReceivingLimestoneDetailRequest request =
        ManagerReceivingLimestoneDetailRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_limestone_detail, request.getParams());
    final ManagerReceivingLimestoneDetailResponse response =
        ManagerReceivingLimestoneDetailResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      detailData = response.data;
    }
    notifyListeners();
  }

  Future<void> createReceipt() async {
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_limestone_create_receipt,
        new Map<String, dynamic>());
    final ListRequireSupplyLimestoneResponse response =
        ListRequireSupplyLimestoneResponse.fromJson(jsonData);
    if (response.isSuccess()) {
      listRequireSupplyLimestone = response.data;
    }
    notifyListeners();
  }

  Future<StatusResponse> saveReceipt(
    int receiptId,
    String receiptDate,
    String requireNo,
    List<String> fileName,
    List<String> filePath,
  ) async {
    ManagerReceivingLimestoneSaveReceiptRequest request =
        ManagerReceivingLimestoneSaveReceiptRequest();
    request.receiptId = receiptId;
    request.receiptDate = receiptDate;
    request.requireNo = requireNo;
    request.fileName = fileName;
    request.filePath = filePath;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_limestone_save_receipt, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<ListRequireReceiverResponse> createRequire(int receiptId) async {
    ManagerReceivingLimestoneCreateRequireRequest request =
        ManagerReceivingLimestoneCreateRequireRequest();
    request.receiptId = receiptId;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_limestone_create_require, request.getParams());
    return ListRequireReceiverResponse.fromJson(jsonData);
  }

  Future<StatusResponse> sendRequireReceiveBefore(int id, String requireTime,
      String notificationContent, int requireReceiver) async {
    ManagerReceivingLimestoneRequireReceiveRequest request =
        ManagerReceivingLimestoneRequireReceiveRequest();
    request.id = id;
    request.requireTime = requireTime;
    request.notificationContent = notificationContent;
    request.requireReceiver = requireReceiver;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_limestone_require_before, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> sendNoticeComplete(int id) async {
    ManagerReceivingLimestoneNoticeCompleteRequest request =
        ManagerReceivingLimestoneNoticeCompleteRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_limestone_notice_complete,
        request.getParams());
    return StatusResponse.fromJson(jsonData);
  }
}
