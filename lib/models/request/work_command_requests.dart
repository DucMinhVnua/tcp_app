import 'package:workflow_manager/base/extension/string.dart';

class WorkCommandAddMemberRequest {
  int workCommandId;
  int memberId;
  int safetyLevel;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId > 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (memberId > 0) {
      params["HoVaTen"] = memberId;
    }
    if (safetyLevel > 0) {
      params["BacAnToanDien"] = safetyLevel;
    }
    return params;
  }
}

class WorkCommandDeleteMemberRequest {
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

class WorkCommandAddSequenceRequest {
  int workCommandId;
  String workSequence;
  String safetyCondition;
  String startTime;
  String endTime;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId > 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (workSequence.isNotNullOrEmpty) {
      params["TrinhTuCongTac"] = workSequence;
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

class WorkCommandDeleteSequenceRequest {
  int workCommandId;
  int workSequenceId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId > 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (workSequenceId > 0) {
      params["IDTrinhTuThucHien"] = workSequenceId;
    }
    return params;
  }
}

class WorkCommandDetailRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["IDLenhCongTac"] = id;
    }

    return params;
  }
}

class WorkCommandChangeDirectCommanderRequest {
  int workCommandId;
  int userCommanderId;
  int safetyCardNumber;
  String changeReason;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId > 0) {
      params["ID"] = workCommandId;
    }
    if (userCommanderId > 0) {
      params["ChiHuyMoi"] = userCommanderId;
    }
    if (safetyCardNumber > 0) {
      params["BacAnToanDien"] = safetyCardNumber;
    }
    if (changeReason.isNotNullOrEmpty) {
      params["LyDo"] = changeReason;
    }
    return params;
  }
}

class WorkCommandConfirmAttendanceRequest {
  int workCommandId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId >= 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    return params;
  }
}

class WorkCommandConfirmWithdrawRequest {
  int workCommandId;
  int userId;
  int type;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId >= 0) {
      params["IDLenhCongTac"] = workCommandId;
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

class WorkCommandConfirmSequenceRequest {
  int workCommandId;
  int sequenceId;
  int typeUser;
  int typeTime;
  int idChuKy;
  String thoiGian;
  String trinhTuCongTacNCPTC;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId >= 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (sequenceId >= 0) {
      params["IDTrinhTu"] = sequenceId;
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