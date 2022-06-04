import 'package:workflow_manager/base/extension/string.dart';

class MechanicalWorkCommandChangeDirectCommanderRequest {
  int mechanicalWorkCommandId;
  int userCommanderId;
  String soTheATD;
  String changeReason;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkCommandId > 0) {
      params["ID"] = mechanicalWorkCommandId;
    }
    if (userCommanderId > 0) {
      params["ChiHuyMoi"] = userCommanderId;
    }
    if (soTheATD.isNotNullOrEmpty) {
      params["SoTheATD"] = soTheATD;
    }
    if (changeReason.isNotNullOrEmpty) {
      params["LyDo"] = changeReason;
    }
    return params;
  }
}

class MechanicalWorkCommandAddMemberRequest {
  int workCommandId;
  int memberId;
  String soTheATD;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId > 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (memberId > 0) {
      params["HoVaTen"] = memberId;
    }
    if (soTheATD.isNotNullOrEmpty) {
      params["SoTheATD"] = soTheATD;
    }
    return params;
  }
}

class MechanicalWorkCommandDeleteMemberRequest {
  int workCommandId;
  int memberId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId > 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (memberId > 0) {
      params["IDNhanSuThamGia"] = memberId;
    }
    return params;
  }
}

class MechanicalWorkCommandAddDiaryRequest {
  int workCommandId;
  String workDiary;
  String safetyCondition;
  String startTime;
  String endTime;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId > 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (workDiary.isNotNullOrEmpty) {
      params["TrinhTuCongTac"] = workDiary;
    }
    if (safetyCondition.isNotNullOrEmpty) {
      params["DieuKienAnToan"] = safetyCondition;
    }
    if (startTime.isNotNullOrEmpty) {
      params["ThoiGianBatDau"] = startTime;
    }
    if (endTime.isNotNullOrEmpty) {
      params["ThoiGianKetThuc"] = endTime;
    }
    return params;
  }
}

class MechanicalWorkCommandDeleteSequenceRequest {
  int workCommandId;
  int workSequenceId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId > 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (workSequenceId > 0) {
      params["IDNhatKy"] = workSequenceId;
    }
    return params;
  }
}

class MechanicalWorkCommandDetailRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["IDLenhCongTacCNH"] = id;
    }
    return params;
  }
}

class MechanicalWorkCommandConfirmAttendanceRequest {
  int mechanicalWorkCommandId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkCommandId >= 0) {
      params["IDLenhCongTacCNH"] = mechanicalWorkCommandId;
    }
    return params;
  }
}

class MechanicalWorkCommandConfirmWithdrawRequest {
  int mechanicalWorkCommandId;
  int userId;
  int type;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkCommandId >= 0) {
      params["IDLenhCongTacCNH"] = mechanicalWorkCommandId;
    }
    if (userId >= 0) {
      params["IDNhanVien"] = userId;
    }
    if (type >= 0) {
      params["Type"] = type;
    }
    return params;
  }
}

class MechanicalWorkCommandConfirmLocationRequest {
  int mechanicalWorkCommandId;
  int diaryId;
  int typeUser;
  int typeTime;
  int idChuKy;
  String thoiGian;
  String trinhTuCongTacNCPTC;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkCommandId >= 0) {
      params["IDLenhCongTacCNH"] = mechanicalWorkCommandId;
    }
    if (diaryId >= 0) {
      params["IDNhatKy"] = diaryId;
    }
    if (typeUser >= 0) {
      params["TypeUser"] = typeUser;
    }
    if (typeTime >= 0) {
      params["TypeTime"] = typeTime;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    if (thoiGian.isNotNullOrEmpty) {
      params["ThoiGian"] = thoiGian;
    }
    if (trinhTuCongTacNCPTC.isNotNullOrEmpty) {
      params["TrinhTuCongTacNCPTC"] = trinhTuCongTacNCPTC;
    }
    return params;
  }
}
