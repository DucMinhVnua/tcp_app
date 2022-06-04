import 'package:workflow_manager/base/extension/string.dart';

class IndexDataRequest {
  int pageIndex;
  int pageSize;
  int term;
  int status;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (pageIndex >= 0) {
      params["PageIndex"] = pageIndex;
    }
    if (pageSize >= 0) {
      params["PageSize"] = pageSize;
    }
    if (pageSize >= 0) {
      params["Term"] = term;
    }
    if (pageSize >= 0) {
      params["Status"] = status;
    }
    return params;
  }
}

class IndexDataRequest2 {
  int type;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (type >= 0) {
      params["Type"] = type;
    }
    return params;
  }
}

class NotifyCompleteRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["ID"] = id;
    }

    return params;
  }
}

class ChangeShiftLeaderRequest {
  int id;
  int idTruongCa;
  String noiDung;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id > 0) {
      params["ID"] = id;
    }
    if (idTruongCa > 0) {
      params["IDTruongCaTo"] = idTruongCa;
    }
    if (noiDung.isNotNullOrEmpty) {
      params["NoiDung"] = noiDung;
    }
    return params;
  }
}

class ChangeAssignmentRequest {
  int id;
  int idNguoiChoPhep;
  int idNguoiChoPhepTaiCho;
  String noiDung;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id > 0) {
      params["ID"] = id;
    }
    if (idNguoiChoPhep > 0) {
      params["IDNCPTo"] = idNguoiChoPhep;
    }
    if (idNguoiChoPhepTaiCho > 0) {
      params["IDNCPTTTo"] = idNguoiChoPhepTaiCho;
    }
    if (noiDung.isNotNullOrEmpty) {
      params["NoiDung"] = noiDung;
    }
    return params;
  }
}

class ConfirmChangeShiftLeaderRequest {
  int idChangeShiftLeader;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (idChangeShiftLeader > 0) {
      params["IDThayDoi"] = idChangeShiftLeader;
    }
    return params;
  }
}

class ConfirmCancelRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["ID"] = id;
    }

    return params;
  }
}

class DirectCommanderListRequest {
  int idChiHuy;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (idChiHuy >= 0) {
      params["IDChiHuy"] = idChiHuy;
    }

    return params;
  }
}