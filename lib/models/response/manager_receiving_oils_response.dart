import 'package:workflow_manager/base/models/base_response.dart';

class ManagerReceivingOilsResponse extends BaseResponse {
  Data data;

  ManagerReceivingOilsResponse.fromJson(Map<String, dynamic> json)
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
  List<ManagerReceivingOil> datas;
  int pageSize;
  int pageIndex;
  int pageTotal;
  int recordNumber;
  TrangThais trangThais;
  TrangThais hinhThucVanChuyens;

  Data(
      {this.datas,
        this.pageSize,
        this.pageIndex,
        this.pageTotal,
        this.recordNumber,
        this.trangThais,
        this.hinhThucVanChuyens});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Datas'] != null) {
      datas = <ManagerReceivingOil>[];
      json['Datas'].forEach((v) {
        datas.add(new ManagerReceivingOil.fromJson(v));
      });
    }
    pageSize = json['PageSize'];
    pageIndex = json['PageIndex'];
    pageTotal = json['PageTotal'];
    recordNumber = json['RecordNumber'];
    trangThais = json['TrangThais'] != null
        ? new TrangThais.fromJson(json['TrangThais'])
        : null;
    hinhThucVanChuyens = json['HinhThucVanChuyens'] != null
        ? new TrangThais.fromJson(json['HinhThucVanChuyens'])
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
    if (this.hinhThucVanChuyens != null) {
      data['HinhThucVanChuyens'] = this.hinhThucVanChuyens.toJson();
    }
    return data;
  }
}

enum StatusManagerReceivingOil {
  receiptOfFuel,
  oilSuddenlyBought,
  quarterlyPlan,
}

enum TransportationFormManagerReceivingOil {
  inlandWaterway,
  shippingByWater,
  roadTransportation,
}

class ManagerReceivingOil {
  int iD;
  int iDChannel;
  int iDPhieuTiepDau;
  int type;
  String typeName;
  String soTiepNhan;
  int ngayTiepNhan;
  int nguoiTiepNhan;
  int thoiGianPhuongTienDen;
  int hinhThucVanChuyen;
  String typeNameHinhThucVanChuyen;
  String soHopDong;
  int ngayHopDong;
  String loaiDau;
  String diaDiemGiaoHang;
  int hoanThanhQuyTrinh;
  int createdBy;
  int updatedBy;
  int created;
  int updated;

  StatusManagerReceivingOil getStatus() {
    switch (type) {
      case 1:
        return StatusManagerReceivingOil.receiptOfFuel;
      case 2:
        return StatusManagerReceivingOil.oilSuddenlyBought;
      case 3:
        return StatusManagerReceivingOil.quarterlyPlan;
    }
    return StatusManagerReceivingOil.receiptOfFuel;
  }

  String getStatusName() {
    switch (getStatus()) {
      case StatusManagerReceivingOil.receiptOfFuel:
        return 'Tiếp nhận nhiên liệu';
      case StatusManagerReceivingOil.oilSuddenlyBought:
        return 'Dầu mua đột xuất';
      case StatusManagerReceivingOil.quarterlyPlan:
        return 'Theo kế hoạch tháng quý';
    }
    return "";
  }

  ManagerReceivingOil(
      {this.iD,
        this.iDChannel,
        this.iDPhieuTiepDau,
        this.type,
        this.typeName,
        this.soTiepNhan,
        this.ngayTiepNhan,
        this.nguoiTiepNhan,
        this.thoiGianPhuongTienDen,
        this.hinhThucVanChuyen,
        this.typeNameHinhThucVanChuyen,
        this.soHopDong,
        this.ngayHopDong,
        this.loaiDau,
        this.diaDiemGiaoHang,
        this.hoanThanhQuyTrinh,
        this.createdBy,
        this.updatedBy,
        this.created,
        this.updated});

  ManagerReceivingOil.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDChannel = json['IDChannel'];
    iDPhieuTiepDau = json['IDPhieuTiepDau'];
    type = json['Type'];
    typeName = json['TypeName'];
    soTiepNhan = json['SoTiepNhan'];
    ngayTiepNhan = json['NgayTiepNhan'];
    nguoiTiepNhan = json['NguoiTiepNhan'];
    thoiGianPhuongTienDen = json['ThoiGianPhuongTienDen'];
    hinhThucVanChuyen = json['HinhThucVanChuyen'];
    typeNameHinhThucVanChuyen = json['TypeNameHinhThucVanChuyen'];
    soHopDong = json['SoHopDong'];
    ngayHopDong = json['NgayHopDong'];
    loaiDau = json['LoaiDau'];
    diaDiemGiaoHang = json['DiaDiemGiaoHang'];
    hoanThanhQuyTrinh = json['HoanThanhQuyTrinh'];
    createdBy = json['CreatedBy'];
    updatedBy = json['UpdatedBy'];
    created = json['Created'];
    updated = json['Updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['IDChannel'] = this.iDChannel;
    data['IDPhieuTiepDau'] = this.iDPhieuTiepDau;
    data['Type'] = this.type;
    data['TypeName'] = this.typeName;
    data['SoTiepNhan'] = this.soTiepNhan;
    data['NgayTiepNhan'] = this.ngayTiepNhan;
    data['NguoiTiepNhan'] = this.nguoiTiepNhan;
    data['ThoiGianPhuongTienDen'] = this.thoiGianPhuongTienDen;
    data['HinhThucVanChuyen'] = this.hinhThucVanChuyen;
    data['TypeNameHinhThucVanChuyen'] = this.typeNameHinhThucVanChuyen;
    data['SoHopDong'] = this.soHopDong;
    data['NgayHopDong'] = this.ngayHopDong;
    data['LoaiDau'] = this.loaiDau;
    data['DiaDiemGiaoHang'] = this.diaDiemGiaoHang;
    data['HoanThanhQuyTrinh'] = this.hoanThanhQuyTrinh;
    data['CreatedBy'] = this.createdBy;
    data['UpdatedBy'] = this.updatedBy;
    data['Created'] = this.created;
    data['Updated'] = this.updated;
    return data;
  }

  String getTransportType() {
    switch(hinhThucVanChuyen) {
      case 1:
        return 'Vận chuyển đường thủy nội địa';
      case 2:
        return 'Vận chuyển đường thủy';
      case 3:
        return 'Vận chuyển đường bộ';
    }
    return "";
  }

  String getContractType() {
    switch(type) {
      case 1:
        return 'Tiếp nhận nhiên liệu';
      case 2:
        return 'Dầu mua đột xuất';
      case 3:
        return 'Theo kế hoạch tháng quý';
    }
    return "";
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