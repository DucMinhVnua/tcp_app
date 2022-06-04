import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/models/base_response.dart';
import 'package:workflow_manager/base/network/api_caller.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/models/request/index_data_request.dart';
import 'package:workflow_manager/models/request/manipulation_sheet_requests.dart';
import 'package:workflow_manager/models/response/manipulation_is_order_receiving_response.dart';
import 'package:workflow_manager/models/response/manipulation_sheet_detail_response.dart';
import 'package:workflow_manager/models/response/manipulation_sheets_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';

class ManipulationSheetModel with ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;
  bool isSearching = false;
  bool isLoading = false;
  bool isFiltered = false;

  List<ManipulationSheet> _data = [];
  List<ManipulationSheet> searchedData = [];
  List<ManipulationSheet> filteredData = [];

  ManipulationSheetDetail detailData;

  Future<void> getManipulationSheets(isLoadingDialog,
      [int pageIndex = 1,
      int pageSize = 100,
      int term = 1,
      int status = 1]) async {
    isLoading = true;
    notifyListeners();
    IndexDataRequest2 requestElectrical = IndexDataRequest2();
    requestElectrical.type = 1;
    IndexDataRequest2 requestMechanical = IndexDataRequest2();
    requestMechanical.type = 2;

    final jsonDataElectrical = await _apiService.postFormData(
        AppUrl.manipulation_sheets, requestElectrical.getParams(),
        isLoading: isLoadingDialog);
    final jsonDataMechanical = await _apiService.postFormData(
        AppUrl.manipulation_sheets, requestMechanical.getParams(),
        isLoading: isLoadingDialog);

    final ManipulationSheetsResponse responseElectrical =
        ManipulationSheetsResponse.fromJson(jsonDataElectrical);
    final ManipulationSheetsResponse responseMechanical =
        ManipulationSheetsResponse.fromJson(jsonDataMechanical);

    if (responseElectrical.isSuccess() && responseMechanical.isSuccess()) {
      List<ManipulationSheet> l1 = responseElectrical.data.datas;
      List<ManipulationSheet> l2 = responseMechanical.data.datas;
      l1.forEach((element) => element.status = 1);
      l2.forEach((element) => element.status = 2);
      _data = filteredData = [
        ...l1,
        ...l2,
      ];
    } else {
      _data = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //get data, can apply filter
  List<ManipulationSheet> getData() {
    return isFiltered ? filteredData : _data;
  }

  //filter by status for Tab Bar display
  List<ManipulationSheet> getDataByStatus(StatusManipulationSheet status) {
    return getData().where((_) => _.getStatus() == status).toList();
  }

  //suggestions in appbar search Pattern : noiDungCongTac
  Future<List<ManipulationSheet>> generateSuggestion(String pattern) async {
    return pattern.isEmpty
        ? []
        : _data
            .where((_) => _.code.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
  }

  //search when submit in appbar Pattern : noiDungCongTac
  Future<void> search(String pattern) async {
    searchedData = pattern.isEmpty
        ? []
        : _data
            .where((_) => _.code.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
    notifyListeners();
  }

  //apply filter
  Future<void> filter(FilterPopArguments arguments) async {
    List<ManipulationSheet> result = _data;
    if (arguments.startDate.isNotNullOrEmpty) {
      result = result
          .where((_) =>
              _.thoiGianBatDau >=
              new DateFormat(Constant.ddMMyyyy)
                  .parse(arguments.startDate)
                  .millisecondsSinceEpoch)
          .toList();
    }
    if (arguments.endDate.isNotNullOrEmpty) {
      result = result
          .where((_) =>
              _.thoiGianBatDau <=
              new DateFormat(Constant.ddMMyyyy)
                  .parse(arguments.endDate)
                  .millisecondsSinceEpoch)
          .toList();
    }
    if (arguments.status != 0) {
      result = result.where((_) => _.status == arguments.status).toList();
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

  Future<void> getManipulationSheetDetail(int id) async {
    ManipulationSheetDetailRequest request = ManipulationSheetDetailRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_detail, request.getParams());
    final ManipulationSheetDetailResponse response =
        ManipulationSheetDetailResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      detailData = response.data;
    }
    notifyListeners();
  }

  Future<StatusResponse> updateUnusualEvent(int id, String content) async {
    ManipulationSheetUpdateUnusualEventRequest request =
        ManipulationSheetUpdateUnusualEventRequest();
    request.id = id;
    request.content = content;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_update_unusual_event, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<ManipulationSheetIsOrderReceivingResponse> isOrderReceiving(
      int id, int idSequence) async {
    ManipulationSheetIsOrderReceivingRequest request =
        ManipulationSheetIsOrderReceivingRequest();
    request.id = id;
    request.idSequence = idSequence;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_is_order_receiving, request.getParams());
    return ManipulationSheetIsOrderReceivingResponse.fromJson(jsonData);
  }

  Future<StatusResponse> orderReceiving(
      int id, int idSequence, int idOrdered) async {
    ManipulationSheetOrderReceivingRequest request =
        ManipulationSheetOrderReceivingRequest();
    request.id = id;
    request.idSequence = idSequence;
    request.idOrdered = idOrdered;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_order_receiving, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> orderCommand(int id, int idSequence) async {
    ManipulationSheetIsOrderReceivingRequest request =
        ManipulationSheetIsOrderReceivingRequest();
    request.id = id;
    request.idSequence = idSequence;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_order_command, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<BaseResponse> addSequence(
      int id, String muc, String diaDiem, String buoc, String noiDung) async {
    ManipulationSheetAddSequenceRequest request =
        ManipulationSheetAddSequenceRequest();
    request.id = id;
    request.muc = muc;
    request.diaDiem = diaDiem;
    request.buoc = buoc;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_add_sequence, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<BaseResponse> editSequence(int id, int idSequence, String muc,
      String diaDiem, String buoc, String noiDung) async {
    ManipulationSheetEditSequenceRequest request =
        ManipulationSheetEditSequenceRequest();
    request.id = id;
    request.idSequence = idSequence;
    request.muc = muc;
    request.diaDiem = diaDiem;
    request.buoc = buoc;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_edit_sequence, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<BaseResponse> deleteSequence(int id, int idSequence) async {
    ManipulationSheetDeleteSequenceRequest request =
        ManipulationSheetDeleteSequenceRequest();
    request.id = id;
    request.idSequence = idSequence;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_delete_sequence, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<BaseResponse> notifyComplete(int id) async {
    NotifyCompleteRequest request = NotifyCompleteRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.manipulation_sheet_notify_complete, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }
}
