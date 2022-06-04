import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/models/base_response.dart';
import 'package:workflow_manager/base/network/api_caller.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/models/request/check_in_out_requests.dart';
import 'package:workflow_manager/models/request/index_data_request.dart';
import 'package:workflow_manager/models/request/mechanical_work_sheet_requests.dart';
import 'package:workflow_manager/models/request/sign_process_request.dart';
import 'package:workflow_manager/models/response/check_in_response.dart';
import 'package:workflow_manager/models/response/check_out_response.dart';
import 'package:workflow_manager/models/response/list_member_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_sheet_detail_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_sheets_response.dart';
import 'package:workflow_manager/models/response/sign_process_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';

class MechanicalWorkSheetModel with ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;
  bool isLoading = false;
  bool isFiltered = false;

  List<MechanicalWorkSheet> _data = [];
  List<MechanicalWorkSheet> filteredData = [];

  MechanicalWorkSheetDetail detailData;
  List<Users> listMembers = [];

  Future<void> getMechanicalWorkSheets(isLoadingDialog,
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
        AppUrl.mechanical_work_sheets, request.getParams(),
        isLoading: isLoadingDialog);
    final MechanicalWorkSheetsResponse response =
        MechanicalWorkSheetsResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      _data = filteredData = response.data.datas;
    } else {
      _data = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //get data, can apply filter
  List<MechanicalWorkSheet> getData() {
    return isFiltered ? filteredData : _data;
  }

  //filter by status for Tab Bar display
  List<MechanicalWorkSheet> getDataByStatus(StatusMechanicalWorkSheet status) {
    return getData().where((_) => _.getStatus() == status).toList();
  }

  //apply filter
  Future<void> filter(FilterPopArguments arguments) async {
    List<MechanicalWorkSheet> result = _data;
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

  Future<StatusResponse> changeDirectCommander(int mechanicalWorkSheetId,
      int userCommanderId, String soTheATD, String changeReason) async {
    MechanicalWorkSheetChangeDirectCommanderRequest request =
        MechanicalWorkSheetChangeDirectCommanderRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.userCommanderId = userCommanderId;
    request.soTheATD = soTheATD;
    request.changeReason = changeReason;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_change_direct_commander,
        request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<void> getMechanicalWorkSheetDetail(int id) async {
    MechanicalWorkSheetDetailRequest request =
        MechanicalWorkSheetDetailRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_detail, request.getParams());
    final MechanicalWorkSheetDetailResponse response =
        MechanicalWorkSheetDetailResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      detailData = response.data;
    }
    notifyListeners();
  }

  Future<BaseResponse> notifyComplete(int mechanicalWorkSheetId) async {
    NotifyCompleteRequest request = NotifyCompleteRequest();
    request.id = mechanicalWorkSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_notify_complete, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<StatusResponse> addMemberJoin(int workSheetId, int memberId,
      String soTheATD, String addDate, String currentDate) async {
    MechanicalWorkSheetAddMemberRequest request =
        MechanicalWorkSheetAddMemberRequest();
    request.workSheetId = workSheetId;
    request.memberId = memberId;
    request.soTheATD = soTheATD;
    request.addDate = addDate;
    request.currentDate = currentDate;

    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_add_member_join, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> deleteMemberJoin(int workSheetId, int memberId) async {
    MechanicalWorkSheetDeleteMemberRequest request =
        MechanicalWorkSheetDeleteMemberRequest();
    request.workSheetId = workSheetId;
    request.memberId = memberId;

    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_delete_member_join, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> addWorkPlace(
      int mechanicalWorkSheetId,
      String workPlace,
      String overview,
      String startDate,
      String endDate) async {
    MechanicalWorkSheetAddWorkPlaceRequest request =
        MechanicalWorkSheetAddWorkPlaceRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.workPlace = workPlace;
    request.overview = overview;
    request.startDate = startDate;
    request.endDate = endDate;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_add_work_place, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> deleteWorkPlace(
      int mechanicalWorkSheetId, int workPlaceId) async {
    MechanicalWorkSheetDeleteWorkPlaceRequest request =
        MechanicalWorkSheetDeleteWorkPlaceRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.workPlaceId = workPlaceId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_delete_work_place, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckInResponse> isCheckIn(
      int mechanicalWorkSheetId, int userId) async {
    MechanicalWorkSheetIsCheckInRequest request =
        MechanicalWorkSheetIsCheckInRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.userId = userId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_is_check_in, request.getParams());
    return IsCheckInResponse.fromJson(jsonData);
  }

  Future<BaseResponse> checkIn(
      int mechanicalWorkSheetId, int userId, int idChuKy) async {
    MechanicalWorkSheetCheckInRequest request =
        MechanicalWorkSheetCheckInRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.userId = userId;
    request.idChuKy = idChuKy;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_check_in, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<IsCheckOutResponse> isCheckOut(
      int mechanicalWorkSheetId, int userId) async {
    MechanicalWorkSheetIsCheckInRequest request =
        MechanicalWorkSheetIsCheckInRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.userId = userId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_is_check_out, request.getParams());
    return IsCheckOutResponse.fromJson(jsonData);
  }

  Future<StatusResponse> checkOut(
      int mechanicalWorkSheetId, int loaiRutKhoi, int idChuKy, int idThamGia) async {
    MechanicalWorkSheetCheckOutRequest request =
        MechanicalWorkSheetCheckOutRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.loaiRutKhoi = loaiRutKhoi;
    request.idChuKy = idChuKy;
    request.idThamGia = idThamGia;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_check_out, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmAttendance(int mechanicalWorkSheetId) async {
    MechanicalWorkSheetConfirmAttendanceRequest request =
        MechanicalWorkSheetConfirmAttendanceRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_confirm_attendance, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmWithdraw(
      int mechanicalWorkSheetId, int userId, int type) async {
    MechanicalWorkSheetConfirmWithdrawRequest request =
        MechanicalWorkSheetConfirmWithdrawRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.userId = userId;
    request.type = type;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_confirm_withdraw, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckInResponse> isConfirmLocation(int mechanicalWorkSheetId) async {
    MechanicalWorkSheetIsCheckInRequest request =
        MechanicalWorkSheetIsCheckInRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_is_confirm_location, request.getParams());
    return IsCheckInResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmLocation(
    int mechanicalWorkSheetId,
    int locationId,
    int typeUser,
    int typeTime,
    int idChuKy,
    String thoiGian,
  ) async {
    MechanicalWorkSheetConfirmLocationRequest request =
        MechanicalWorkSheetConfirmLocationRequest();
    request.mechanicalWorkSheetId = mechanicalWorkSheetId;
    request.typeUser = typeUser;
    request.typeTime = typeTime;
    request.locationId = locationId;
    request.thoiGian = thoiGian;
    request.idChuKy = idChuKy;

    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_confirm_location, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<SignProcessResponse> signProcess(int mechanicalWorkSheetId) async {
    SignProcessRequest request = SignProcessRequest();
    request.id = mechanicalWorkSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_sign_process, request.getParams());
    return SignProcessResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeShiftLeader(
      int mechanicalWorkSheetId, int idTruongCa, String noiDung) async {
    ChangeShiftLeaderRequest request = ChangeShiftLeaderRequest();
    request.id = mechanicalWorkSheetId;
    request.idTruongCa = idTruongCa;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_change_shift_leader, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeAssignment(int mechanicalWorkSheetId, int idNguoiChoPhep,
      int idNguoiChoPhepTaiCho, String noiDung) async {
    ChangeAssignmentRequest request = ChangeAssignmentRequest();
    request.id = mechanicalWorkSheetId;
    request.idNguoiChoPhep = idNguoiChoPhep;
    request.idNguoiChoPhepTaiCho = idNguoiChoPhepTaiCho;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_change_assignment, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmChangeShiftLeader(
      int idChangeShiftLeader) async {
    ConfirmChangeShiftLeaderRequest request = ConfirmChangeShiftLeaderRequest();
    request.idChangeShiftLeader = idChangeShiftLeader;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_confirm_change_shift_leader, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmCancel(int mechanicalWorkSheetId) async {
    ConfirmCancelRequest request = ConfirmCancelRequest();
    request.id = mechanicalWorkSheetId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_cancel, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<ListMemberResponse> getDirectCommanderList(int idChiHuy) async {
    DirectCommanderListRequest request = DirectCommanderListRequest();
    request.idChiHuy = idChiHuy;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_sheet_list_direct_commander, request.getParams());
    return ListMemberResponse.fromJson(jsonData);
  }
}
