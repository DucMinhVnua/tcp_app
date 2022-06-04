import 'package:workflow_manager/base/models/base_response.dart';

class MechanicalWorkCommandsResponse extends BaseResponse {
  Data data;

  MechanicalWorkCommandsResponse.fromJson(Map<String, dynamic> json)
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
  List<MechanicalWorkCommand> datas;
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
      datas = <MechanicalWorkCommand>[];
      json['Datas'].forEach((v) {
        datas.add(new MechanicalWorkCommand.fromJson(v));
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

enum StatusMechanicalWorkCommand {
  pending,
  cancelled,
  performTask,
  waitingConfirm,
  notFinished,
  confirmed,
  completedNotDone,
  completedDone,
}

class MechanicalWorkCommand {
  int iD;
  int iDChannel;
  String code;
  String nguoiLap;
  String noiDungCongTac;
  String diaDiem;
  String phamVi;
  int status;
  String statusName;
  int created;
  int thoiGianBatDau;
  int thoiGianKetThuc;
  int ngayLap;
  bool isActionBoSungNhanSu;
  bool isActionBoSungTrinhTu;
  bool isActionThayDoiChiHuy;
  bool isActionTruongCa;
  bool isActionThongBaoHoanThanh;
  bool isActionCancel;
  List<ShiftLeaders> users;
  int iDChiHuy;

  MechanicalWorkCommand(
      {this.iD,
      this.iDChannel,
      this.code,
      this.nguoiLap,
      this.noiDungCongTac,
      this.diaDiem,
      this.phamVi,
      this.status,
      this.statusName,
      this.created,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.ngayLap,
      this.isActionBoSungNhanSu,
      this.isActionBoSungTrinhTu,
      this.isActionThayDoiChiHuy,
      this.isActionTruongCa,
      this.isActionThongBaoHoanThanh,
      this.isActionCancel,
      this.users,
      this.iDChiHuy});

  StatusMechanicalWorkCommand getStatus() {
    switch (status) {
      case 1:
        return StatusMechanicalWorkCommand.pending;
      case 2:
        return StatusMechanicalWorkCommand.cancelled;
      case 3:
        return StatusMechanicalWorkCommand.performTask;
      case 4:
        return StatusMechanicalWorkCommand.waitingConfirm;
      case 5:
        return StatusMechanicalWorkCommand.notFinished;
      case 6:
        return StatusMechanicalWorkCommand.confirmed;
      case 7:
        return StatusMechanicalWorkCommand.completedNotDone;
      case 8:
        return StatusMechanicalWorkCommand.completedDone;
    }
    return StatusMechanicalWorkCommand.pending;
  }

  String getStatusName() {
    switch (getStatus()) {
      case StatusMechanicalWorkCommand.pending:
        return 'Chờ xử lý';
      case StatusMechanicalWorkCommand.cancelled:
        return 'Hủy';
      case StatusMechanicalWorkCommand.performTask:
        return 'Thực hiện công tác';
      case StatusMechanicalWorkCommand.waitingConfirm:
        return 'Chờ xác nhận hoàn thành';
      case StatusMechanicalWorkCommand.notFinished:
        return 'Kết thúc chưa xong';
      case StatusMechanicalWorkCommand.confirmed:
        return 'Đã xác nhận';
      case StatusMechanicalWorkCommand.completedNotDone:
        return 'Kết thúc(Chưa hoàn thành)';
      case StatusMechanicalWorkCommand.completedDone:
        return 'Kết thúc(Hoàn thành)';
    }
    return "";
  }

  MechanicalWorkCommand.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDChannel = json['IDChannel'];
    code = json['Code'];
    nguoiLap = json['NguoiLap'];
    noiDungCongTac = json['NoiDungCongTac'];
    diaDiem = json['DiaDiem'];
    phamVi = json['PhamVi'];
    status = json['Status'];
    statusName = json['StatusName'];
    created = json['Created'];
    thoiGianBatDau = json['ThoiGianBatDau'];
    thoiGianKetThuc = json['ThoiGianKetThuc'];
    ngayLap = json['NgayLap'];
    isActionBoSungNhanSu = json['IsActionBoSungNhanSu'];
    isActionBoSungTrinhTu = json['IsActionBoSungTrinhTu'];
    isActionThayDoiChiHuy = json['IsActionThayDoiChiHuy'];
    isActionTruongCa = json['IsActionTruongCa'];
    isActionThongBaoHoanThanh = json['IsActionThongBaoHoanThanh'];
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
    data['NguoiLap'] = this.nguoiLap;
    data['NoiDungCongTac'] = this.noiDungCongTac;
    data['DiaDiem'] = this.diaDiem;
    data['PhamVi'] = this.phamVi;
    data['Status'] = this.status;
    data['StatusName'] = this.statusName;
    data['Created'] = this.created;
    data['ThoiGianBatDau'] = this.thoiGianBatDau;
    data['ThoiGianKetThuc'] = this.thoiGianKetThuc;
    data['NgayLap'] = this.ngayLap;
    data['IsActionBoSungNhanSu'] = this.isActionBoSungNhanSu;
    data['IsActionBoSungTrinhTu'] = this.isActionBoSungTrinhTu;
    data['IsActionThayDoiChiHuy'] = this.isActionThayDoiChiHuy;
    data['IsActionTruongCa'] = this.isActionTruongCa;
    data['IsActionThongBaoHoanThanh'] = this.isActionThongBaoHoanThanh;
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
