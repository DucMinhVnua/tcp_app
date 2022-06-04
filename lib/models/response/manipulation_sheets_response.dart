import 'package:workflow_manager/base/models/base_response.dart';

class ManipulationSheetsResponse extends BaseResponse {
  Data data;

  ManipulationSheetsResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<ManipulationSheet> datas;
  int pageSize;
  int pageIndex;
  int pageTotal;
  int recordNumber;

  Data(
      {this.datas,
      this.pageSize,
      this.pageIndex,
      this.pageTotal,
      this.recordNumber});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Datas'] != null) {
      datas = <ManipulationSheet>[];
      json['Datas'].forEach((v) {
        datas.add(new ManipulationSheet.fromJson(v));
      });
    }
    pageSize = json['PageSize'];
    pageIndex = json['PageIndex'];
    pageTotal = json['PageTotal'];
    recordNumber = json['RecordNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datas != null) {
      data['Datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    data['PageSize'] = this.pageSize;
    data['PageIndex'] = this.pageIndex;
    data['PageTotal'] = this.pageTotal;
    data['RecordNumber'] = this.recordNumber;
    return data;
  }
}

enum StatusManipulationSheet {
  electrical_safety,
  mechanical_safety,
}

class ManipulationSheet {
  int iD;
  int iDChannel;
  String code;
  String nguoiGiamSat;
  String nguoiThaoTac;
  int created;
  int thoiGianBatDau;
  int thoiGianKetThuc;
  int ngayLap;
  bool isActionThongBaoHoanThanh;

  int status = 1;

  StatusManipulationSheet getStatus() {
    switch (status) {
      case 1:
        return StatusManipulationSheet.electrical_safety;
      case 2:
        return StatusManipulationSheet.mechanical_safety;
    }
    return StatusManipulationSheet.electrical_safety;
  }

  String getStatusName() {
    switch (getStatus()) {
      case StatusManipulationSheet.electrical_safety:
        return 'Điện';
      case StatusManipulationSheet.mechanical_safety:
        return 'Cơ nhiệt hóa';
    }
    return "";
  }

  ManipulationSheet(
      {this.iD,
      this.iDChannel,
      this.code,
      this.nguoiGiamSat,
      this.nguoiThaoTac,
      this.created,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.ngayLap,
      this.isActionThongBaoHoanThanh});

  ManipulationSheet.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDChannel = json['IDChannel'];
    code = json['Code'];
    nguoiGiamSat = json['NguoiGiamSat'];
    nguoiThaoTac = json['NguoiThaoTac'];
    created = json['Created'];
    thoiGianBatDau = json['ThoiGianBatDau'];
    thoiGianKetThuc = json['ThoiGianKetThuc'];
    ngayLap = json['NgayLap'];
    isActionThongBaoHoanThanh = json['IsActionThongBaoHoanThanh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['IDChannel'] = this.iDChannel;
    data['Code'] = this.code;
    data['NguoiGiamSat'] = this.nguoiGiamSat;
    data['NguoiThaoTac'] = this.nguoiThaoTac;
    data['Created'] = this.created;
    data['ThoiGianBatDau'] = this.thoiGianBatDau;
    data['ThoiGianKetThuc'] = this.thoiGianKetThuc;
    data['NgayLap'] = this.ngayLap;
    data['IsActionThongBaoHoanThanh'] = this.isActionThongBaoHoanThanh;
    return data;
  }
}
