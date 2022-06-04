import 'package:workflow_manager/base/extension/list.dart';
import 'package:workflow_manager/base/extension/string.dart';

class ManagerReceivingLimestoneDetailRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["ID"] = id;
    }

    return params;
  }
}

class ManagerReceivingLimestoneSaveReceiptRequest {
  int receiptId;
  String receiptDate;
  String requireNo;
  List<String> fileName;
  List<String> filePath;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (receiptId > 0) {
      params["IDPhieuTiepDaVoi"] = receiptId;
    }
    if (receiptDate.isNotNullOrEmpty) {
      params["NgayGuiYeuCau"] = receiptDate;
    }
    if (requireNo.isNotNullOrEmpty) {
      params["SoYeuCau"] = requireNo;
    }
    if (!fileName.isNullOrEmpty) {
      params["FileName"] = fileName;
    }
    if (!filePath.isNullOrEmpty) {
      params["FilePath"] = filePath;
    }
    return params;
  }
}

class ManagerReceivingLimestoneCreateRequireRequest {
  int receiptId;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (receiptId >= 0) {
      params["IDHoSoTiepNhan"] = receiptId;
    }
    return params;
  }
}

class ManagerReceivingLimestoneRequireReceiveRequest {
  int id;
  String requireTime;
  String notificationContent;
  int requireReceiver;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["IDHoSoTiepNhan"] = id;
    }
    if (requireTime.isNotNullOrEmpty) {
      params["ThoiGianYeuCau"] = requireTime;
    }
    if (notificationContent.isNotNullOrEmpty) {
      params["NoiDungThongBao"] = notificationContent;
    }
    if (requireReceiver >= 0) {
      params["NguoiNhanYeuCau"] = requireReceiver;
    }
    return params;
  }
}

class ManagerReceivingLimestoneNoticeCompleteRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["IDHoSoTiepNhan"] = id;
    }
    return params;
  }
}
