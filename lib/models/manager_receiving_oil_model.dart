import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/network/api_caller.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/models/request/index_data_request.dart';
import 'package:workflow_manager/models/request/manager_receiving_oil_requests.dart';
import 'package:workflow_manager/models/response/list_department_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_oil_detail_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_oils_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';

class ManagerReceivingOilModel with ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;

  bool isSearching = false;
  bool isLoading = false;
  bool isFiltered = false;

  List<ManagerReceivingOil> _data = [];
  List<ManagerReceivingOil> searchedData = [];
  List<ManagerReceivingOil> filteredData = [];

  ManagerReceivingOilDetail detailData;
  ListDepartment listDepartment;

  Future<void> getManagerReceivingOils(isLoadingDialog,
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
        AppUrl.manager_receiving_oil, request.getParams(),
        isLoading: isLoadingDialog);
    final ManagerReceivingOilsResponse response =
        ManagerReceivingOilsResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      _data = filteredData = response.data.datas;
    } else {
      _data = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //get data, can apply filter
  List<ManagerReceivingOil> getData() {
    return isFiltered ? filteredData : _data;
  }

  //filter by status for Tab Bar display
  List<ManagerReceivingOil> getDataByStatus(StatusManagerReceivingOil status) {
    return getData().where((_) => _.getStatus() == status).toList();
  }

  //suggestions in appbar search Pattern : noiDungCongTac
  Future<List<ManagerReceivingOil>> generateSuggestion(String pattern) async {
    return pattern.isEmpty
        ? []
        : _data
            .where(
                (_) => _.typeName.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
  }

  //search when submit in appbar Pattern : noiDungCongTac
  Future<void> search(String pattern) async {
    searchedData = pattern.isEmpty
        ? []
        : _data
            .where(
                (_) => _.typeName.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
    notifyListeners();
  }

  //apply filter
  Future<void> filter(FilterPopArguments arguments) async {
    List<ManagerReceivingOil> result = _data;
    if (arguments.startDate.isNotNullOrEmpty) {
      result = result
          .where((_) =>
              _.ngayHopDong >=
              new DateFormat(Constant.ddMMyyyy)
                  .parse(arguments.startDate)
                  .millisecondsSinceEpoch)
          .toList();
    }
    if (arguments.endDate.isNotNullOrEmpty) {
      result = result
          .where((_) =>
              _.ngayHopDong <=
              new DateFormat(Constant.ddMMyyyy)
                  .parse(arguments.endDate)
                  .millisecondsSinceEpoch)
          .toList();
    }
    if (arguments.status != 0) {
      result = result.where((_) => _.type == arguments.status).toList();
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

  Future<void> getManagerReceivingOilDetail(int id) async {
    ManagerReceivingOilDetailRequest request =
        ManagerReceivingOilDetailRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_oil_detail, request.getParams());
    final ManagerReceivingOilDetailResponse response =
        ManagerReceivingOilDetailResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      detailData = response.data;
    }
    notifyListeners();
  }

  Future<StatusResponse> createReceipt(
    String receiptNo,
    String receiptDate,
    int receiver,
    String vehicleArrivalTime,
    int transportType,
    String oilType,
    List<int> departmentReceiveNotifications,
    String contractNo,
    String contractDate,
    int contractType,
    String deliveryPlace,
    List<String> fileName,
    List<String> filePath,
  ) async {
    ManagerReceivingOilCreateReceiptRequest request =
        ManagerReceivingOilCreateReceiptRequest();
    request.receiptNo = receiptNo;
    request.receiptDate = receiptDate;
    request.receiver = receiver;
    request.vehicleArrivalTime = vehicleArrivalTime;
    request.transportType = transportType;
    request.oilType = oilType;
    request.departmentReceiveNotifications = departmentReceiveNotifications;
    request.contractNo = contractNo;
    request.contractDate = contractDate;
    request.contractType = contractType;
    request.deliveryPlace = deliveryPlace;
    request.fileName = fileName;
    request.filePath = filePath;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_oil_create_receipt, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> sendRequireReceiveBefore(int id,
      String notificationContent, int requireSender, String requireTime) async {
    ManagerReceivingOilRequireReceiveRequest request =
        ManagerReceivingOilRequireReceiveRequest();
    request.id = id;
    request.notificationContent = notificationContent;
    request.requireSender = requireSender;
    request.requireTime = requireTime;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_oil_require_before, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> sendRequireReceiveAfter(int id,
      String notificationContent, int requireSender, String requireTime) async {
    ManagerReceivingOilRequireReceiveRequest request =
        ManagerReceivingOilRequireReceiveRequest();
    request.id = id;
    request.notificationContent = notificationContent;
    request.requireSender = requireSender;
    request.requireTime = requireTime;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_oil_require_after, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> sendNoticeComplete(int id) async {
    ManagerReceivingOilNoticeCompleteRequest request =
        ManagerReceivingOilNoticeCompleteRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.manager_receiving_oil_notice_complete, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<ListDepartmentResponse> getListDepartment(int pageSize) async {
    ListDepartmentRequest request = ListDepartmentRequest();
    request.pageSize = pageSize;
    final jsonData = await _apiService.postFormData(
        AppUrl.get_list_department, request.getParams());
    return ListDepartmentResponse.fromJson(jsonData);
  }
}
