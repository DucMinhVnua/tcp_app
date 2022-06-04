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
import 'package:workflow_manager/models/request/mechanical_work_command_requests.dart';
import 'package:workflow_manager/models/request/sign_process_request.dart';
import 'package:workflow_manager/models/response/check_in_response.dart';
import 'package:workflow_manager/models/response/check_out_response.dart';
import 'package:workflow_manager/models/response/list_member_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_command_detail_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_commands_response.dart';
import 'package:workflow_manager/models/response/sign_process_response.dart';
import 'package:workflow_manager/models/response/status_response.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';

class MechanicalWorkCommandModel with ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;
  bool isSearching = false;
  bool isLoading = false;
  bool isFiltered = false;

  List<MechanicalWorkCommand> _data = [];
  List<MechanicalWorkCommand> searchedData = [];
  List<MechanicalWorkCommand> filteredData = [];

  MechanicalWorkCommandDetail detailData;

  List<Users> listMembers = [];

  Future<void> getMechanicalWorkCommands(isLoadingDialog,
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
        AppUrl.mechanical_work_commands, request.getParams(),
        isLoading: isLoadingDialog);
    final MechanicalWorkCommandsResponse response =
        MechanicalWorkCommandsResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      _data = filteredData = response.data.datas;
    } else {
      _data = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //get data, can apply filter
  List<MechanicalWorkCommand> getData() {
    return isFiltered ? filteredData : _data;
  }

  //filter by status for Tab Bar display
  List<MechanicalWorkCommand> getDataByStatus(
      StatusMechanicalWorkCommand status) {
    return getData().where((_) => _.getStatus() == status).toList();
  }

  //suggestions in appbar search Pattern : noiDungCongTac
  Future<List<MechanicalWorkCommand>> generateSuggestion(String pattern) async {
    return pattern.isEmpty
        ? []
        : _data
            .where((_) => _.noiDungCongTac.toLowerCase().contains(pattern))
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
    List<MechanicalWorkCommand> result = _data;
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

  Future<StatusResponse> changeDirectCommander(int mechanicalWorkCommandId,
      int userCommanderId, String soTheATD, String changeReason) async {
    MechanicalWorkCommandChangeDirectCommanderRequest request =
        MechanicalWorkCommandChangeDirectCommanderRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    request.userCommanderId = userCommanderId;
    request.soTheATD = soTheATD;
    request.changeReason = changeReason;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_change_direct_commander,
        request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckInResponse> isCheckIn(int mechanicalWorkCommandId) async {
    MechanicalWorkCommandIsCheckInRequest request =
        MechanicalWorkCommandIsCheckInRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_is_check_in, request.getParams());
    return IsCheckInResponse.fromJson(jsonData);
  }

  Future<BaseResponse> checkIn(int mechanicalWorkCommandId, int idChuKy) async {
    MechanicalWorkCommandCheckInRequest request =
        MechanicalWorkCommandCheckInRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    request.idChuKy = idChuKy;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_check_in, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<void> getMechanicalWorkCommandDetail(int id) async {
    MechanicalWorkCommandDetailRequest request =
        MechanicalWorkCommandDetailRequest();
    request.id = id;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_detail, request.getParams());
    final MechanicalWorkCommandDetailResponse response =
        MechanicalWorkCommandDetailResponse.fromJson(jsonData);

    if (response.isSuccess()) {
      detailData = response.data;
    }
    notifyListeners();
  }

  Future<StatusResponse> addWorkDiary(int workCommandId, String workDiary,
      String safetyCondition, String startTime, String endTime) async {
    MechanicalWorkCommandAddDiaryRequest request =
        MechanicalWorkCommandAddDiaryRequest();
    request.workCommandId = workCommandId;
    request.workDiary = workDiary;
    request.safetyCondition = safetyCondition;
    request.startTime = startTime;
    request.endTime = endTime;

    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_add_work_diary, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> deleteWorkSequence(
      int workCommandId, int workSequenceId) async {
    MechanicalWorkCommandDeleteSequenceRequest request =
        MechanicalWorkCommandDeleteSequenceRequest();
    request.workCommandId = workCommandId;
    request.workSequenceId = workSequenceId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_delete_work_diary,
        request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<BaseResponse> notifyComplete(int mechanicalWorkCommandId) async {
    NotifyCompleteRequest request = NotifyCompleteRequest();
    request.id = mechanicalWorkCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_notify_complete, request.getParams());
    return BaseResponse.fromJson(jsonData);
  }

  Future<ListMemberResponse> getMemberList() async {
    final jsonData = await _apiService.get(AppUrl.get_list_member,
        params: new Map<String, dynamic>());
    return ListMemberResponse.fromJson(jsonData);
  }

  Future<StatusResponse> addMemberJoin(
      int workCommandId, int memberId, String soTheATD) async {
    MechanicalWorkCommandAddMemberRequest request =
        MechanicalWorkCommandAddMemberRequest();
    request.workCommandId = workCommandId;
    request.memberId = memberId;
    request.soTheATD = soTheATD;

    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_add_member_join, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> deleteMemberJoin(
      int workCommandId, int memberId) async {
    MechanicalWorkCommandDeleteMemberRequest request =
        MechanicalWorkCommandDeleteMemberRequest();
    request.workCommandId = workCommandId;
    request.memberId = memberId;

    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_delete_member_join, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckOutResponse> isCheckOut(int mechanicalWorkCommandId) async {
    MechanicalWorkCommandIsCheckInRequest request =
        MechanicalWorkCommandIsCheckInRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_is_check_out, request.getParams());
    return IsCheckOutResponse.fromJson(jsonData);
  }

  Future<StatusResponse> checkOut(
      int mechanicalWorkCommandId, int loaiRutKhoi, int idChuKy) async {
    MechanicalWorkCommandCheckOutRequest request =
        MechanicalWorkCommandCheckOutRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    request.loaiRutKhoi = loaiRutKhoi;
    request.idChuKy = idChuKy;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_check_out, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmAttendance(int mechanicalWorkCommandId) async {
    MechanicalWorkCommandConfirmAttendanceRequest request =
        MechanicalWorkCommandConfirmAttendanceRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_confirm_attendance, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmWithdraw(
      int mechanicalWorkCommandId, int userId, int type) async {
    MechanicalWorkCommandConfirmWithdrawRequest request =
        MechanicalWorkCommandConfirmWithdrawRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    request.userId = userId;
    request.type = type;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_confirm_withdraw, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<IsCheckInResponse> isConfirmDiary(
      int mechanicalWorkCommandId, int diaryId) async {
    MechanicalWorkCommandIsCheckInRequest request =
        MechanicalWorkCommandIsCheckInRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    request.diaryId = diaryId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_is_confirm_diary, request.getParams());
    return IsCheckInResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmDiary(
    int mechanicalWorkCommandId,
    int diaryId,
    int typeUser,
    int typeTime,
    int idChuKy,
    String thoiGian,
    String trinhTuCongTacNCPTC,
  ) async {
    MechanicalWorkCommandConfirmLocationRequest request =
        MechanicalWorkCommandConfirmLocationRequest();
    request.mechanicalWorkCommandId = mechanicalWorkCommandId;
    request.typeUser = typeUser;
    request.typeTime = typeTime;
    request.diaryId = diaryId;
    request.thoiGian = thoiGian;
    request.trinhTuCongTacNCPTC = trinhTuCongTacNCPTC;
    request.idChuKy = idChuKy;

    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_confirm_diary, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<SignProcessResponse> signProcess(int mechanicalWorkCommandId) async {
    SignProcessRequest request = SignProcessRequest();
    request.id = mechanicalWorkCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_sign_process, request.getParams());
    return SignProcessResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeShiftLeader(
      int mechanicalWorkCommandId, int idTruongCa, String noiDung) async {
    ChangeShiftLeaderRequest request = ChangeShiftLeaderRequest();
    request.id = mechanicalWorkCommandId;
    request.idTruongCa = idTruongCa;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_change_shift_leader, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> changeAssignment(int mechanicalWorkCommandId, int idNguoiChoPhep,
      int idNguoiChoPhepTaiCho, String noiDung) async {
    ChangeAssignmentRequest request = ChangeAssignmentRequest();
    request.id = mechanicalWorkCommandId;
    request.idNguoiChoPhep = idNguoiChoPhep;
    request.idNguoiChoPhepTaiCho = idNguoiChoPhepTaiCho;
    request.noiDung = noiDung;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_change_assignment, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmChangeShiftLeader(
      int idChangeShiftLeader) async {
    ConfirmChangeShiftLeaderRequest request = ConfirmChangeShiftLeaderRequest();
    request.idChangeShiftLeader = idChangeShiftLeader;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_confirm_change_shift_leader, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<StatusResponse> confirmCancel(int mechanicalWorkCommandId) async {
    ConfirmCancelRequest request = ConfirmCancelRequest();
    request.id = mechanicalWorkCommandId;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_cancel, request.getParams());
    return StatusResponse.fromJson(jsonData);
  }

  Future<ListMemberResponse> getDirectCommanderList(int idChiHuy) async {
    DirectCommanderListRequest request = DirectCommanderListRequest();
    request.idChiHuy = idChiHuy;
    final jsonData = await _apiService.postFormData(
        AppUrl.mechanical_work_command_list_direct_commander, request.getParams());
    return ListMemberResponse.fromJson(jsonData);
  }
}
