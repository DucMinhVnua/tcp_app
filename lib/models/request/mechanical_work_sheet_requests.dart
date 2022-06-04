import 'package:workflow_manager/base/extension/string.dart';

class MechanicalWorkSheetAddMemberRequest {
  int workSheetId;
  int memberId;
  String soTheATD;
  String addDate;
  String currentDate;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId > 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (memberId > 0) {
      params["HoVaTenCNH"] = memberId;
    }
    if (soTheATD.isNotNullOrEmpty) {
      params["SoTheATD"] = soTheATD;
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

class MechanicalWorkSheetDeleteMemberRequest {
  int workSheetId;
  int memberId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId > 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (memberId > 0) {
      params["IDThanhVienThamGia"] = memberId;
    }
    return params;
  }
}

class MechanicalWorkSheetDetailRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["IDPhieuCongTacCNH"] = id;
    }

    return params;
  }
}

class MechanicalWorkSheetChangeDirectCommanderRequest {
  int mechanicalWorkSheetId;
  int userCommanderId;
  String soTheATD;
  String changeReason;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId > 0) {
      params["ID"] = mechanicalWorkSheetId;
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


class MechanicalWorkSheetAddWorkPlaceRequest {
  int mechanicalWorkSheetId;
  String workPlace;
  String overview;
  String startDate;
  String endDate;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId > 0) {
      params["IDPhieuCongTac"] = mechanicalWorkSheetId;
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

class MechanicalWorkSheetDeleteWorkPlaceRequest {
  int mechanicalWorkSheetId;
  int workPlaceId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId > 0) {
      params["IDPhieuCongTac"] = mechanicalWorkSheetId;
    }
    if (workPlaceId > 0) {
      params["IDDiaDiemCongTac"] = workPlaceId;
    }
    return params;
  }
}

class MechanicalWorkSheetConfirmAttendanceRequest {
  int mechanicalWorkSheetId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId >= 0) {
      params["IDPhieuCongTacCNH"] = mechanicalWorkSheetId;
    }
    return params;
  }
}

class MechanicalWorkSheetConfirmWithdrawRequest {
  int mechanicalWorkSheetId;
  int userId;
  int type;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId >= 0) {
      params["IDPhieuCongTacCNH"] = mechanicalWorkSheetId;
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

class MechanicalWorkSheetConfirmLocationRequest {
  int mechanicalWorkSheetId;
  int locationId;
  int typeUser;
  int typeTime;
  int idChuKy;
  String thoiGian;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId >= 0) {
      params["IDPhieuCongTacCNH"] = mechanicalWorkSheetId;
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