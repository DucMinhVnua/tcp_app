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
import 'package:workflow_manager/models/request/work_command_requests.dart';
import 'package:workflow_manager/models/response/check_in_response.dart';
import 'package:workflow_manager/models/response/check_out_response.dart';
import 'package:workflow_manager/models/response/list_member_response.dart';
import 'package:workflow_manager/models/response/sign_process_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/models/response/work_command_detail_response.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';

import 'request/index_data_request.dart';
import 'response/work_command_detail_response.dart';
import 'response/work_commands_response.dart';

class WorkCommandModel with ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;
  bool isSearching = false;
  bool isLoading = false;
  bool isFiltered = false;

  List<WorkCommand> _data = [];
  List<WorkCommand> searchedData = [];
  List<WorkCommand> filteredData = [];
  WorkCommandDetail detailData;

  Future<void> getWorkCommands(isLoadingDialog,
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
        AppUrl.work_commands, request.getParams(),
        isLoading: isLoadingDialog);
    final WorkCommandsResponse response =
        WorkCommandsResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      _data = filteredData = response.data.datas;
    } else {
      _data = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //get data, can apply filter
  List<WorkCommand> getData() {
    return isFiltered ? filteredData : _data;
  }

  //filter by status for Tab Bar display
  List<WorkCommand> getDataByStatus(StatusWorkCommand status) {
    return getData().where((_) => _.getStatus() == status).toList();
  }

  //suggestions in appbar search Pattern : noiDungCongTac
  Future<List<WorkCommand>> generateSuggestion(String pattern) async {
    return pattern.isEmpty
        ? []
        : _data
            .where((_) =>
                _.noiDungCongTac.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
  }

  //search when submit in appbar Pattern : noiDungCongTac
  Future<void> search(String pattern) async {
    searchedData = pattern.isEmpty
        ? []
        : _data
            .where((_) =>
                _.noiDungCongTac.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
    notifyListeners();
  }

  //apply filter
  Future<void> filter(FilterPopArguments arguments) async {
    List<WorkCommand> result = _data;
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

  Future<void> getWorkCommandDetail(int id) async {
    WorkCommandDetailRequest request = WorkCommandDetailRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_detail, request.getParams());
    final WorkCommandDetailResponse response =
        WorkCommandDetailResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      detailData = response.data;
    }
    notifyListeners();
  }

  Future<StatusResponse> addWorkSequence(int workCommandId, String workSequence,
      String safetyCondition, String startTime, String endTime) async {
    WorkCommandAddSequenceRequest request = WorkCommandAddSequenceRequest();
    request.workCommandId = workCommandId;
    request.workSequence = workSequence;
    request.safetyCondition = safetyCondition;
    request.startTime = startTime;
    request.endTime = endTime;

    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_add_work_sequence, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> deleteWorkSequence(
      int workCommandId, int workSequenceId) async {
    WorkCommandDeleteSequenceRequest request =
        WorkCommandDeleteSequenceRequest();
    request.workCommandId = workCommandId;
    request.workSequenceId = workSequenceId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_delete_work_sequence, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<BaseResponse> notifyComplete(int workCommandId) async {
    NotifyCompleteRequest request = NotifyCompleteRequest();
    request.id = workCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_notify_complete, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeDirectCommander(int workCommandId,
      int userCommanderId, int safetyCardNumber, String changeReason) async {
    WorkCommandChangeDirectCommanderRequest request =
        WorkCommandChangeDirectCommanderRequest();
    request.workCommandId = workCommandId;
    request.userCommanderId = userCommanderId;
    request.safetyCardNumber = safetyCardNumber;
    request.changeReason = changeReason;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_change_direct_commander, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> addMemberJoin(
      int workCommandId, int memberId, int safetyLevel) async {
    WorkCommandAddMemberRequest request = WorkCommandAddMemberRequest();
    request.workCommandId = workCommandId;
    request.memberId = memberId;
    request.safetyLevel = safetyLevel;

    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_add_member_join, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> deleteMemberJoin(
      int workCommandId, int memberId) async {
    WorkCommandDeleteMemberRequest request = WorkCommandDeleteMemberRequest();
    request.workCommandId = workCommandId;
    request.memberId = memberId;

    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_delete_member_join, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckInResponse> isCheckIn(int workCommandId) async {
    WorkCommandIsCheckInRequest request = WorkCommandIsCheckInRequest();
    request.workCommandId = workCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_is_check_in, request.getParams());
    return IsCheckInResponse.fromJson(jsonData);
  }

  Future<BaseResponse> checkIn(int workCommandId, int idChuKy) async {
    WorkCommandCheckInRequest request = WorkCommandCheckInRequest();
    request.workCommandId = workCommandId;
    request.idChuKy = idChuKy;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_check_in, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<IsCheckOutResponse> isCheckOut(int workCommandId) async {
    WorkCommandIsCheckInRequest request = WorkCommandIsCheckInRequest();
    request.workCommandId = workCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_is_check_out, request.getParams());
    return IsCheckOutResponse.fromJson(jsonData);
  }

  Future<StatusResponse> checkOut(
      int workCommandId, int loaiRutKhoi, int idChuKy) async {
    WorkCommandCheckOutRequest request = WorkCommandCheckOutRequest();
    request.workCommandId = workCommandId;
    request.loaiRutKhoi = loaiRutKhoi;
    request.idChuKy = idChuKy;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_check_out, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmAttendance(int workCommandId) async {
    WorkCommandConfirmAttendanceRequest request =
        WorkCommandConfirmAttendanceRequest();
    request.workCommandId = workCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_confirm_attendance, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmWithdraw(
      int workCommandId, int userId, int type) async {
    WorkCommandConfirmWithdrawRequest request =
        WorkCommandConfirmWithdrawRequest();
    request.workCommandId = workCommandId;
    request.userId = userId;
    request.type = type;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_confirm_withdraw, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckInResponse> isConfirmSequence(
      int workCommandId, int sequenceId) async {
    WorkCommandIsCheckInRequest request = WorkCommandIsCheckInRequest();
    request.workCommandId = workCommandId;
    request.sequenceId = sequenceId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_is_confirm_sequence, request.getParams());
    return IsCheckInResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmSequence(
    int workCommandId,
    int sequenceId,
    int typeUser,
    int typeTime,
    int idChuKy,
    String thoiGian,
    String trinhTuCongTacNCPTC,
  ) async {
    WorkCommandConfirmSequenceRequest request =
        WorkCommandConfirmSequenceRequest();
    request.workCommandId = workCommandId;
    request.sequenceId = sequenceId;
    request.typeUser = typeUser;
    request.typeTime = typeTime;
    request.thoiGian = thoiGian;
    request.trinhTuCongTacNCPTC = trinhTuCongTacNCPTC;
    request.idChuKy = idChuKy;

    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_confirm_sequence, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<SignProcessResponse> signProcess(int workCommandId) async {
    SignProcessRequest request = SignProcessRequest();
    request.id = workCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_sign_process, request.getParams());
    return SignProcessResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeShiftLeader(
      int workCommandId, int idTruongCa, String noiDung) async {
    ChangeShiftLeaderRequest request = ChangeShiftLeaderRequest();
    request.id = workCommandId;
    request.idTruongCa = idTruongCa;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_change_shift_leader, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeAssignment(int workCommandId, int idNguoiChoPhep,
      int idNguoiChoPhepTaiCho, String noiDung) async {
    ChangeAssignmentRequest request = ChangeAssignmentRequest();
    request.id = workCommandId;
    request.idNguoiChoPhep = idNguoiChoPhep;
    request.idNguoiChoPhepTaiCho = idNguoiChoPhepTaiCho;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_change_assignment, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmChangeShiftLeader(
      int idChangeShiftLeader) async {
    ConfirmChangeShiftLeaderRequest request = ConfirmChangeShiftLeaderRequest();
    request.idChangeShiftLeader = idChangeShiftLeader;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_confirm_change_shift_leader, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmCancel(int workCommandId) async {
    ConfirmCancelRequest request = ConfirmCancelRequest();
    request.id = workCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_cancel, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<ListMemberResponse> getDirectCommanderList(int idChiHuy) async {
    DirectCommanderListRequest request = DirectCommanderListRequest();
    request.idChiHuy = idChiHuy;
    final jsonData = await _apiService.postFormData(
        AppUrl.work_command_list_direct_commander, request.getParams());
    return ListMemberResponse.fromJson(jsonData);
  }
}
