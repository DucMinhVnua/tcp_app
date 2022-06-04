import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/models/base_response.dart';
import 'package:workflow_manager/base/network/api_caller.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/models/request/check_in_out_requests.dart';
import 'package:workflow_manager/models/request/sign_process_request.dart';
import 'package:workflow_manager/models/request/work_sheet_requests.dart';
import 'package:workflow_manager/models/response/check_in_response.dart';
import 'package:workflow_manager/models/response/check_out_response.dart';
import 'package:workflow_manager/models/response/list_member_response.dart';
import 'package:workflow_manager/models/response/sign_process_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/models/response/work_sheet_detail_response.dart';
import 'package:workflow_manager/models/response/work_sheets_response.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';

import 'request/index_data_request.dart';

class WorkSheetModel with ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;
  bool isLoading = false;
  bool isFiltered = false;

  List<WorkSheet> _data = [];
  List<WorkSheet> filteredData = [];

  WorkSheetDetail detailData;
  List<Users> listMembers = [];

  Future<void> getWorkSheets(isLoadingDialog,
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
        AppUrl.work_sheets, request.getParams(),
        isLoading: isLoadingDialog);
    final WorkSheetsResponse response = WorkSheetsResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      _data = filteredData = response.data.datas;
    } else {
      _data = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //get data, can apply filter
  List<WorkSheet> getData() {
    return isFiltered ? filteredData : _data;
  }

  //filter by status for Tab Bar display
  List<WorkSheet> getDataByStatus(StatusWorkSheet status) {
    return getData().where((_) => _.getStatus() == status).toList();
  }

  //apply filter
  Future<void> filter(FilterPopArguments arguments) async {
    List<WorkSheet> result = _data;
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

  Future<StatusResponse> changeDirectCommander(int workSheetId,
      int userCommanderId, int safetyCardNumber, String changeReason) async {
    WorkSheetChangeDirectCommanderRequest request =
        WorkSheetChangeDirectCommanderRequest();
    request.workSheetId = workSheetId;
    request.userCommanderId = userCommanderId;
    request.safetyCardNumber = safetyCardNumber;
    request.changeReason = changeReason;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_change_direct_commander, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<BaseResponse> notifyComplete(int workSheetId) async {
    NotifyCompleteRequest request = NotifyCompleteRequest();
    request.id = workSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_notify_complete, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<void> getWorkSheetDetail(int id) async {
    WorkSheetDetailRequest request = WorkSheetDetailRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_detail, request.getParams());
    final WorkSheetDetailResponse response =
        WorkSheetDetailResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      detailData = response.data;
    }
    notifyListeners();
  }

  Future<StatusResponse> addMemberJoin(int workSheetId, int memberId,
      int safetyLevel, String addDate, String currentDate) async {
    WorkSheetAddMemberRequest request = WorkSheetAddMemberRequest();
    request.workSheetId = workSheetId;
    request.memberId = memberId;
    request.safetyLevel = safetyLevel;
    request.addDate = addDate;
    request.currentDate = currentDate;

    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_add_member_join, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> deleteMemberJoin(int workSheetId, int memberId) async {
    WorkSheetDeleteMemberRequest request = WorkSheetDeleteMemberRequest();
    request.workSheetId = workSheetId;
    request.memberId = memberId;

    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_delete_member_join, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> addWorkPlace(int workSheetId, String workPlace,
      String overview, String startDate, String endDate) async {
    WorkSheetAddWorkPlaceRequest request = WorkSheetAddWorkPlaceRequest();
    request.workSheetId = workSheetId;
    request.workPlace = workPlace;
    request.overview = overview;
    request.startDate = startDate;
    request.endDate = endDate;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_add_work_place, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> deleteWorkPlace(
      int workSheetId, int workPlaceId) async {
    WorkSheetDeleteWorkPlaceRequest request = WorkSheetDeleteWorkPlaceRequest();
    request.workSheetId = workSheetId;
    request.workPlaceId = workPlaceId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_delete_work_place, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckInResponse> isCheckIn(int workSheetId, int userId) async {
    WorkSheetIsCheckInRequest request = WorkSheetIsCheckInRequest();
    request.workSheetId = workSheetId;
    request.userId = userId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_is_check_in, request.getParams());
    return IsCheckInResponse.fromJson(jsonData);
  }

  Future<BaseResponse> checkIn(int workSheetId, int userId, int idChuKy) async {
    WorkSheetCheckInRequest request = WorkSheetCheckInRequest();
    request.workSheetId = workSheetId;
    request.userId = userId;
    request.idChuKy = idChuKy;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_check_in, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<IsCheckOutResponse> isCheckOut(int workSheetId, int userId) async {
    WorkSheetIsCheckInRequest request = WorkSheetIsCheckInRequest();
    request.workSheetId = workSheetId;
    request.userId = userId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_is_check_out, request.getParams());
    return IsCheckOutResponse.fromJson(jsonData);
  }

  Future<StatusResponse> checkOut(
      int workSheetId, int loaiRutKhoi, int idChuKy, int idThamGia) async {
    WorkSheetCheckOutRequest request = WorkSheetCheckOutRequest();
    request.workSheetId = workSheetId;
    request.loaiRutKhoi = loaiRutKhoi;
    request.idChuKy = idChuKy;
    request.idThamGia = idThamGia;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_check_out, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmAttendance(int workSheetId) async {
    WorkSheetConfirmAttendanceRequest request =
        WorkSheetConfirmAttendanceRequest();
    request.workSheetId = workSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_confirm_attendance, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmWithdraw(
      int workSheetId, int userId, int type) async {
    WorkSheetConfirmWithdrawRequest request = WorkSheetConfirmWithdrawRequest();
    request.workSheetId = workSheetId;
    request.userId = userId;
    request.type = type;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_confirm_withdraw, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckInResponse> isConfirmLocation(int workSheetId) async {
    WorkSheetIsCheckInRequest request = WorkSheetIsCheckInRequest();
    request.workSheetId = workSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_is_confirm_location, request.getParams());
    return IsCheckInResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmLocation(
    int workSheetId,
    int locationId,
    int typeUser,
    int typeTime,
    int idChuKy,
    String thoiGian,
  ) async {
    WorkSheetConfirmLocationRequest request = WorkSheetConfirmLocationRequest();
    request.workSheetId = workSheetId;
    request.typeUser = typeUser;
    request.typeTime = typeTime;
    request.locationId = locationId;
    request.thoiGian = thoiGian;
    request.idChuKy = idChuKy;

    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_confirm_location, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<SignProcessResponse> signProcess(int workSheetId) async {
    SignProcessRequest request = SignProcessRequest();
    request.id = workSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_sign_process, request.getParams());
    return SignProcessResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeShiftLeader(
      int workSheetId, int idTruongCa, String noiDung) async {
    ChangeShiftLeaderRequest request = ChangeShiftLeaderRequest();
    request.id = workSheetId;
    request.idTruongCa = idTruongCa;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_change_shift_leader, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeAssignment(int workSheetId, int idNguoiChoPhep,
      int idNguoiChoPhepTaiCho, String noiDung) async {
    ChangeAssignmentRequest request = ChangeAssignmentRequest();
    request.id = workSheetId;
    request.idNguoiChoPhep = idNguoiChoPhep;
    request.idNguoiChoPhepTaiCho = idNguoiChoPhepTaiCho;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_change_assignment, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmChangeShiftLeader(
      int idChangeShiftLeader) async {
    ConfirmChangeShiftLeaderRequest request = ConfirmChangeShiftLeaderRequest();
    request.idChangeShiftLeader = idChangeShiftLeader;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_confirm_change_shift_leader, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmCancel(int workSheetId) async {
    ConfirmCancelRequest request = ConfirmCancelRequest();
    request.id = workSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_cancel, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<ListMemberResponse> getDirectCommanderList(int idChiHuy) async {
    DirectCommanderListRequest request = DirectCommanderListRequest();
    request.idChiHuy = idChiHuy;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_sheet_list_direct_commander, request.getParams());
    return ListMemberResponse.fromJson(jsonData);
  }
}
