import 'package:workflow_manager/base/extension/string.dart';

class ManipulationSheetDetailRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["IDPhieuThaoTac"] = id;
    }

    return params;
  }
}

class ManipulationSheetUpdateUnusualEventRequest {
  int id;
  String content;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id > 0) {
      params["IDPhieuThaoTac"] = id;
    }
    if (content.isNotNullOrEmpty) {
      params["SuKienBatThuong"] = content;
    }
    return params;
  }
}

class ManipulationSheetIsOrderReceivingRequest {
  int id;
  int idSequence;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id > 0) {
      params["IDPhieuThaoTac"] = id;
    }
    if (idSequence > 0) {
      params["IDTrinhTu"] = idSequence;
    }
    return params;
  }
}

class ManipulationSheetOrderReceivingRequest {
  int id;
  int idSequence;
  int idOrdered;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id > 0) {
      params["IDPhieuThaoTac"] = id;
    }
    if (idSequence > 0) {
      params["IDTrinhTu"] = idSequence;
    }
    if (idOrdered > 0) {
      params["DaThucHien"] = idOrdered;
    }
    return params;
  }
}

class ManipulationSheetAddSequenceRequest {
  int id;
  String muc;
  String diaDiem;
  String buoc;
  String noiDung;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id > 0) {
      params["IDPhieuThaoTac"] = id;
    }
    if (muc.isNotNullOrEmpty) {
      params["Muc"] = muc;
    }
    if (diaDiem.isNotNullOrEmpty) {
      params["DiaDiem"] = diaDiem;
    }
    if (buoc.isNotNullOrEmpty) {
      params["Buoc"] = buoc;
    }
    if (noiDung.isNotNullOrEmpty) {
      params["NoiDung"] = noiDung;
    }
    return params;
  }
}

class ManipulationSheetEditSequenceRequest {
  int id;
  int idSequence;
  String muc;
  String diaDiem;
  String buoc;
  String noiDung;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id > 0) {
      params["IDPhieuThaoTac"] = id;
    }
    if (idSequence > 0) {
      params["IDTrinhTu"] = idSequence;
    }
    if (muc.isNotNullOrEmpty) {
      params["Muc"] = muc;
    }
    if (diaDiem.isNotNullOrEmpty) {
      params["DiaDiem"] = diaDiem;
    }
    if (buoc.isNotNullOrEmpty) {
      params["Buoc"] = buoc;
    }
    if (noiDung.isNotNullOrEmpty) {
      params["NoiDung"] = noiDung;
    }
    return params;
  }
}

class ManipulationSheetDeleteSequenceRequest {
  int id;
  int idSequence;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id > 0) {
      params["IDPhieuThaoTac"] = id;
    }
    if (idSequence > 0) {
      params["IDTrinhTu"] = idSequence;
    }
    return params;
  }
}