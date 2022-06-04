import 'package:workflow_manager/base/extension/list.dart';
import 'package:workflow_manager/base/extension/string.dart';

class ManagerReceivingOilDetailRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["ID"] = id;
    }

    return params;
  }
}

class ManagerReceivingOilCreateReceiptRequest {
  String receiptNo;
  String receiptDate;
  int receiver;
  String vehicleArrivalTime;
  int transportType;
  String oilType;
  List<int> departmentReceiveNotifications;
  String contractNo;
  String contractDate;
  int contractType;
  String deliveryPlace;
  List<String> fileName;
  List<String> filePath;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (receiptNo.isNotNullOrEmpty) {
      params["SoTiepNhan"] = receiptNo;
    }
    if (receiptDate.isNotNullOrEmpty) {
      params["NgayTiepNhan"] = receiptDate;
    }
    if (receiver > 0) {
      params["NguoiTiepNhan"] = receiver;
    }
    if (vehicleArrivalTime.isNotNullOrEmpty) {
      params["ThoiGianPhuongTienDen"] = vehicleArrivalTime;
    }
    if (transportType > 0) {
      params["HinhThucVanChuyen"] = transportType;
    }
    if (oilType.isNotNullOrEmpty) {
      params["LoaiDau"] = oilType;
    }
    if (!departmentReceiveNotifications.isNullOrEmpty) {
      params["IDDept"] = departmentReceiveNotifications;
    }
    if (contractNo.isNotNullOrEmpty) {
      params["SoHopDong"] = contractNo;
    }
    if (contractDate.isNotNullOrEmpty) {
      params["NgayHopDong"] = contractDate;
    }
    if (contractType > 0) {
      params["Type"] = contractType;
    }
    if (deliveryPlace.isNotNullOrEmpty) {
      params["DiaDiemGiaoHang"] = deliveryPlace;
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

class ManagerReceivingOilRequireReceiveRequest {
  int id;
  String notificationContent;
  int requireSender;
  String requireTime;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["ID"] = id;
    }
    if (notificationContent.isNotNullOrEmpty) {
      params["NoiDungThongBao"] = notificationContent;
    }
    if (requireSender >= 0) {
      params["NguoiGuiYeuCau"] = requireSender;
    }
    if (requireTime.isNotNullOrEmpty) {
      params["ThoiGianYeuCau"] = requireTime;
    }

    return params;
  }
}

class ManagerReceivingOilNoticeCompleteRequest {
  int id;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (id >= 0) {
      params["IDHoSoTiepNhan"] = id;
    }
    return params;
  }
}

class ListDepartmentRequest {
  int pageSize;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (pageSize > 0) {
      params["PageSize"] = pageSize;
    }
    return params;
  }
}
