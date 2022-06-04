class WorkCommandIsCheckInRequest {
  int workCommandId;
  int sequenceId;  //Use in confirm sequence api

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId >= 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (sequenceId != null && sequenceId >= 0) {
      params["IDTrinhTu"] = sequenceId;
    }
    return params;
  }
}

class WorkCommandCheckInRequest {
  int workCommandId;
  int idChuKy;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId >= 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    return params;
  }
}

class WorkCommandCheckOutRequest {
  int workCommandId;
  int loaiRutKhoi;
  int idChuKy;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workCommandId >= 0) {
      params["IDLenhCongTac"] = workCommandId;
    }
    if (loaiRutKhoi >= 0) {
      params["LoaiRutKhoi"] = loaiRutKhoi;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    return params;
  }
}

class WorkSheetIsCheckInRequest {
  int workSheetId;
  int userId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId >= 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (userId != null && userId >= 0) {
      params["IDThamGia"] = userId;
    }
    return params;
  }
}

class WorkSheetCheckInRequest {
  int workSheetId;
  int userId;
  int idChuKy;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId >= 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (userId >= 0) {
      params["IDThamGia"] = userId;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    return params;
  }
}

class WorkSheetCheckOutRequest {
  int workSheetId;
  int loaiRutKhoi;
  int idChuKy;
  int idThamGia;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (workSheetId >= 0) {
      params["IDPhieuCongTac"] = workSheetId;
    }
    if (loaiRutKhoi >= 0) {
      params["LoaiRutKhoi"] = loaiRutKhoi;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    if (idThamGia >= 0) {
      params["IDThamGia"] = idThamGia;
    }
    return params;
  }
}

class MechanicalWorkCommandIsCheckInRequest {
  int mechanicalWorkCommandId;
  int diaryId;  //Use in confirm diary api

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkCommandId >= 0) {
      params["IDLenhCongTacCNH"] = mechanicalWorkCommandId;
    }
    if (diaryId != null && diaryId >= 0) {
      params["IDNhatKy"] = diaryId;
    }

    return params;
  }
}

class MechanicalWorkCommandCheckInRequest {
  int mechanicalWorkCommandId;
  int idChuKy;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkCommandId >= 0) {
      params["IDLenhCongTacCNH"] = mechanicalWorkCommandId;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    return params;
  }
}

class MechanicalWorkCommandCheckOutRequest {
  int mechanicalWorkCommandId;
  int loaiRutKhoi;
  int idChuKy;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkCommandId >= 0) {
      params["IDLenhCongTacCNH"] = mechanicalWorkCommandId;
    }
    if (loaiRutKhoi >= 0) {
      params["LoaiRutKhoi"] = loaiRutKhoi;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    return params;
  }
}

class MechanicalWorkSheetIsCheckInRequest {
  int mechanicalWorkSheetId;
  int userId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId >= 0) {
      params["IDPhieuCongTacCNH"] = mechanicalWorkSheetId;
    }
    if (userId != null && userId >= 0) {
      params["IDThamGia"] = userId;
    }
    return params;
  }
}

class MechanicalWorkSheetCheckInRequest {
  int mechanicalWorkSheetId;
  int userId;
  int idChuKy;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId >= 0) {
      params["IDPhieuCongTacCNH"] = mechanicalWorkSheetId;
    }
    if (userId >= 0) {
      params["IDThamGia"] = userId;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    return params;
  }
}

class MechanicalWorkSheetCheckOutRequest {
  int mechanicalWorkSheetId;
  int loaiRutKhoi;
  int idChuKy;
  int idThamGia;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (mechanicalWorkSheetId >= 0) {
      params["IDPhieuCongTacCNH"] = mechanicalWorkSheetId;
    }
    if (loaiRutKhoi >= 0) {
      params["LoaiRutKhoi"] = loaiRutKhoi;
    }
    if (idChuKy >= 0) {
      params["IDChuKy"] = idChuKy;
    }
    if (idThamGia >= 0) {
      params["IDThamGia"] = idThamGia;
    }
    return params;
  }
}