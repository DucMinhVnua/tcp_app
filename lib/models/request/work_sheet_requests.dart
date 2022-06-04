import 'package:workflow_manager/base/extension/string.dart';

class WorkSheetAddMemberRequest {
  int workSheetId;
  int memberId;
  int safetyLevel;
  String addDate;
  String currentDate;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId > 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (memberId > 0) {
      params["HoVaTen"] = memberId;
    }
    if (safetyLevel > 0) {
      params["BacAnToanDien"] = safetyLevel;
    }
    if (addDate.isNotNullOrEmpty) {
      params["Ngay"] = addDate;
    }
    if (currentDate.isNotNullOrEmpty) {
      params["NgaySearch"] = addDate;
    }
    return params;
  }
}

class WorkSheetDeleteMemberRequest {
  int workSheetId;
  int memberId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId > 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (memberId > 0) {
      params["IDNhanVienThamGia"] = memberId;
    }
    return params;
  }
}

class WorkSheetDetailRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["IDPhieuCongTac"] = id;
    }

    return params;
  }
}

class WorkSheetChangeDirectCommanderRequest {
  int workSheetId;
  int userCommanderId;
  int safetyCardNumber;
  String changeReason;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId > 0) {
      params["ID"] = workSheetId;
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

class WorkSheetAddWorkPlaceRequest {
  int workSheetId;
  String workPlace;
  String overview;
  String startDate;
  String endDate;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId > 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (workPlace.isNotNullOrEmpty) {
      params["DiaDiemCongTac"] = workPlace;
    }
    if (overview.isNotNullOrEmpty) {
      params["MoTa"] = overview;
    }
    if (startDate.isNotNullOrEmpty) {
      params["ThoiGianBatDau "] = startDate;
    }
    if (endDate.isNotNullOrEmpty) {
      params["ThoiGianKetThuc"] = endDate;
    }
    return params;
  }
}

class WorkSheetDeleteWorkPlaceRequest {
  int workSheetId;
  int workPlaceId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId > 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (workPlaceId > 0) {
      params["IDDiaDiemCongTac"] = workPlaceId;
    }
    return params;
  }
}

class WorkSheetConfirmAttendanceRequest {
  int workSheetId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId >= 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    return params;
  }
}

class WorkSheetConfirmWithdrawRequest {
  int workSheetId;
  int userId;
  int type;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId >= 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (userId >= 0) {
      params["IDThamGia"] = userId;
    }
    if (type >= 0) {
      params["Type"] = type;
    }
    return params;
  }
}

class WorkSheetConfirmLocationRequest {
  int workSheetId;
  int locationId;
  int typeUser;
  int typeTime;
  int idChuKy;
  String thoiGian;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId >= 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (locationId >= 0) {
      params["IDDiaDiem"] = locationId;
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
    return params;
  }
}