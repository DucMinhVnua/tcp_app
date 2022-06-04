import 'package:workflow_manager/base/models/base_response.dart';

class MechanicalWorkSheetsResponse extends BaseResponse {
  Data data;

  MechanicalWorkSheetsResponse.fromJson(Map<String, dynamic> json)
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
  List<MechanicalWorkSheet> datas;
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
      datas = new List<MechanicalWorkSheet>();
      json['Datas'].forEach((v) {
        datas.add(new MechanicalWorkSheet.fromJson(v));
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

enum StatusMechanicalWorkSheet {
  pending,
  rePerformTask,
  performTask,
  waitingConfirm,
  notFinished,
  confirmed,
  completed,
  cancelled,
}

class MechanicalWorkSheet {
  int iD;
  int iDChannel;
  String code;
  String tenLanhDaoCongViec;
  String tenChiHuy;
  String diaDiem;
  String phamVi;
  String noiDung;
  String soLuongNhanVienCongTac;
  int status;
  String statusName;
  int created;
  int thoiGianBatDau;
  int thoiGianKetThuc;
  int ngayLapPhieu;
  bool isActionBoSungNhanSu;
  bool isActionBoSungDiaDiem;
  bool isActionThayDoiChiHuy;
  bool isActionThongBaoHoanThanh;
  bool isActionTruongCa;
  bool isActionCancel;
  List<ShiftLeaders> users;
  int iDChiHuy;

  StatusMechanicalWorkSheet getStatus() {
    switch (status) {
      case 1:
        return StatusMechanicalWorkSheet.pending;
      case 2:
        return StatusMechanicalWorkSheet.rePerformTask;
      case 3:
        return StatusMechanicalWorkSheet.performTask;
      case 4:
        return StatusMechanicalWorkSheet.waitingConfirm;
      case 5:
        return StatusMechanicalWorkSheet.notFinished;
      case 6:
        return StatusMechanicalWorkSheet.confirmed;
      case 7:
        return StatusMechanicalWorkSheet.completed;
      case 8:
        return StatusMechanicalWorkSheet.cancelled;
    }
    return StatusMechanicalWorkSheet.pending;
  }

  String getStatusName() {
    switch (getStatus()) {
      case StatusMechanicalWorkSheet.pending:
        return 'Đang cấp phép';
      case StatusMechanicalWorkSheet.rePerformTask:
        return 'Thực hiện lại công tác';
      case StatusMechanicalWorkSheet.performTask:
        return 'Thực hiện công tác';
      case StatusMechanicalWorkSheet.waitingConfirm:
        return 'Chờ xác nhận hoàn thành';
      case StatusMechanicalWorkSheet.notFinished:
        return 'Kết thúc chưa xong';
      case StatusMechanicalWorkSheet.confirmed:
        return 'Đã xác nhận';
      case StatusMechanicalWorkSheet.completed:
        return 'Hoàn thành';
      case StatusMechanicalWorkSheet.cancelled:
        return 'Hủy';
    }
    return "";
  }

  MechanicalWorkSheet(
      {this.iD,
      this.iDChannel,
      this.code,
      this.tenLanhDaoCongViec,
      this.tenChiHuy,
      this.diaDiem,
      this.phamVi,
      this.noiDung,
      this.soLuongNhanVienCongTac,
      this.status,
      this.statusName,
      this.created,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.ngayLapPhieu,
      this.isActionBoSungNhanSu,
      this.isActionBoSungDiaDiem,
      this.isActionThayDoiChiHuy,
      this.isActionThongBaoHoanThanh,
      this.isActionTruongCa,
      this.isActionCancel,
      this.users,
      this.iDChiHuy});

  MechanicalWorkSheet.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDChannel = json['IDChannel'];
    code = json['Code'];
    tenLanhDaoCongViec = json['TenLanhDaoCongViec'];
    tenChiHuy = json['TenChiHuy'];
    diaDiem = json['DiaDiem'];
    phamVi = json['PhamVi'];
    noiDung = json['NoiDung'];
    soLuongNhanVienCongTac = json['SoLuongNhanVienCongTac'];
    status = json['Status'];
    statusName = json['StatusName'];
    created = json['Created'];
    thoiGianBatDau = json['ThoiGianBatDau'];
    thoiGianKetThuc = json['ThoiGianKetThuc'];
    ngayLapPhieu = json['NgayLapPhieu'];
    isActionBoSungNhanSu = json['IsActionBoSungNhanSu'];
    isActionBoSungDiaDiem = json['IsActionBoSungDiaDiem'];
    isActionThayDoiChiHuy = json['IsActionThayDoiChiHuy'];
    isActionThongBaoHoanThanh = json['IsActionThongBaoHoanThanh'];
    isActionTruongCa = json['IsActionTruongCa'];
    isActionCancel = json['IsActionCancel'];
    if (json['Users'] != null) {
      users = <ShiftLeaders>[];
      json['Users'].forEach((v) {
        users.add(new ShiftLeaders.fromJson(v));
      });
    }
    iDChiHuy = json['IDChiHuy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['IDChannel'] = this.iDChannel;
    data['Code'] = this.code;
    data['TenLanhDaoCongViec'] = this.tenLanhDaoCongViec;
    data['TenChiHuy'] = this.tenChiHuy;
    data['DiaDiem'] = this.diaDiem;
    data['PhamVi'] = this.phamVi;
    data['NoiDung'] = this.noiDung;
    data['SoLuongNhanVienCongTac'] = this.soLuongNhanVienCongTac;
    data['Status'] = this.status;
    data['StatusName'] = this.statusName;
    data['Created'] = this.created;
    data['ThoiGianBatDau'] = this.thoiGianBatDau;
    data['ThoiGianKetThuc'] = this.thoiGianKetThuc;
    data['NgayLapPhieu'] = this.ngayLapPhieu;
    data['IsActionBoSungNhanSu'] = this.isActionBoSungNhanSu;
    data['IsActionBoSungDiaDiem'] = this.isActionBoSungDiaDiem;
    data['IsActionThayDoiChiHuy'] = this.isActionThayDoiChiHuy;
    data['IsActionThongBaoHoanThanh'] = this.isActionThongBaoHoanThanh;
    data['IsActionTruongCa'] = this.isActionTruongCa;
    data['IsActionCancel'] = this.isActionCancel;
    if (this.users != null) {
      data['Users'] = this.users.map((v) => v.toJson()).toList();
    }
    data['IDChiHuy'] = this.iDChiHuy;
    return data;
  }
}

class ShiftLeaders {
  int iD;
  String name;

  ShiftLeaders({this.iD, this.name});

  ShiftLeaders.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    return data;
  }
}

class TrangThais {
  String s1;
  String s2;
  String s3;
  String s4;
  String s5;
  String s6;
  String s7;
  String s8;

  TrangThais(
      {this.s1, this.s2, this.s3, this.s4, this.s5, this.s6, this.s7, this.s8});

  TrangThais.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
    s6 = json['6'];
    s7 = json['7'];
    s8 = json['8'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    data['6'] = this.s6;
    data['7'] = this.s7;
    data['8'] = this.s8;
    return data;
  }
}
