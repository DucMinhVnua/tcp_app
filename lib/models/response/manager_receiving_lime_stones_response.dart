import 'package:workflow_manager/base/models/base_response.dart';

class ManagerReceivingLimestonesResponse extends BaseResponse {
  Data data;

  ManagerReceivingLimestonesResponse.fromJson(Map<String, dynamic> json)
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
  List<ManagerReceivingLimestone> datas;
  int pageSize;
  int pageIndex;
  int pageTotal;
  int recordNumber;
  TrangThais trangThais;

  Data(
      {this.datas,
      this.pageSize,
      this.pageIndex,
      this.pageTotal,
      this.recordNumber,
      this.trangThais});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Datas'] != null) {
      datas = new List<ManagerReceivingLimestone>();
      json['Datas'].forEach((v) {
        datas.add(new ManagerReceivingLimestone.fromJson(v));
      });
    }
    pageSize = json['PageSize'];
    pageIndex = json['PageIndex'];
    pageTotal = json['PageTotal'];
    recordNumber = json['RecordNumber'];
    trangThais = json['TrangThais'] != null
        ? new TrangThais.fromJson(json['TrangThais'])
        : null;
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
    if (this.trangThais != null) {
      data['TrangThais'] = this.trangThais.toJson();
    }
    return data;
  }
}

enum StatusManagerLimestone {
  notComplete,
  complete,
}

class ManagerReceivingLimestone {
  int iD;
  String soPhieuYeuCau;
  int ngayGuiYeuCau;
  String soHopDong;
  int ngayHopDong;
  double soLuong;
  double gia;
  int thoiGianGiaoHangTuNgay;
  int thoiGianGiaoHangDenNgay;
  String diaDiemGiaoHang;
  bool isXacNhanHoanThanh;

  StatusManagerLimestone getStatus() {
    if (!isXacNhanHoanThanh) {
      return StatusManagerLimestone.complete;
    }
    return StatusManagerLimestone.notComplete;
  }

  String getStatusName() {
    switch (getStatus()) {
      case StatusManagerLimestone.complete:
        return 'Đã hoàn thành';
      case StatusManagerLimestone.notComplete:
        return 'Chưa hoàn thành';
    }
    return "";
  }

  ManagerReceivingLimestone(
      {this.iD,
      this.soPhieuYeuCau,
      this.ngayGuiYeuCau,
      this.soHopDong,
      this.ngayHopDong,
      this.soLuong,
      this.gia,
      this.thoiGianGiaoHangTuNgay,
      this.thoiGianGiaoHangDenNgay,
      this.diaDiemGiaoHang,
      this.isXacNhanHoanThanh});

  ManagerReceivingLimestone.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    soPhieuYeuCau = json['SoPhieuYeuCau'];
    ngayGuiYeuCau = json['NgayGuiYeuCau'];
    soHopDong = json['SoHopDong'];
    ngayHopDong = json['NgayHopDong'];
    soLuong = json['SoLuong'];
    gia = json['Gia'];
    thoiGianGiaoHangTuNgay = json['ThoiGianGiaoHangTuNgay'];
    thoiGianGiaoHangDenNgay = json['ThoiGianGiaoHangDenNgay'];
    diaDiemGiaoHang = json['DiaDiemGiaoHang'];
    isXacNhanHoanThanh = json['IsXacNhanHoanThanh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['SoPhieuYeuCau'] = this.soPhieuYeuCau;
    data['NgayGuiYeuCau'] = this.ngayGuiYeuCau;
    data['SoHopDong'] = this.soHopDong;
    data['NgayHopDong'] = this.ngayHopDong;
    data['SoLuong'] = this.soLuong;
    data['Gia'] = this.gia;
    data['ThoiGianGiaoHangTuNgay'] = this.thoiGianGiaoHangTuNgay;
    data['ThoiGianGiaoHangDenNgay'] = this.thoiGianGiaoHangDenNgay;
    data['DiaDiemGiaoHang'] = this.diaDiemGiaoHang;
    data['IsXacNhanHoanThanh'] = this.isXacNhanHoanThanh;
    return data;
  }
}

class TrangThais {
  String s1;
  String s2;
  String s3;

  TrangThais({this.s1, this.s2, this.s3});

  TrangThais.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    return data;
  }
}
