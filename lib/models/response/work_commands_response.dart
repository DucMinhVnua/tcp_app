import 'package:workflow_manager/base/models/base_response.dart';

class WorkCommandsResponse extends BaseResponse {
  Data data;

  WorkCommandsResponse.fromJson(Map<String, dynamic> json)
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
  List<WorkCommand> datas;
  int pageSize;
  int pageIndex;
  int pageTotal;
  int recordNumber;
  Status status;

  Data(
      {this.datas,
      this.pageSize,
      this.pageIndex,
      this.pageTotal,
      this.recordNumber,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Datas'] != null) {
      datas = <WorkCommand>[];
      json['Datas'].forEach((v) {
        datas.add(new WorkCommand.fromJson(v));
      });
    }
    pageSize = json['PageSize'];
    pageIndex = json['PageIndex'];
    pageTotal = json['PageTotal'];
    recordNumber = json['RecordNumber'];
    status = json['TrangThais'] != null
        ? new Status.fromJson(json['TrangThais'])
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
    if (this.status != null) {
      data['TrangThais'] = this.status.toJson();
    }
    return data;
  }
}

enum StatusWorkCommand {
  pending,
  cancelled,
  performTask,
  waitingConfirm,
  notFinished,
  confirmed,
  completedNotDone,
  completedDone,
}

class WorkCommand {
  int iD;
  int iDChannel;
  String code;
  String nguoiLap;
  String noiDungCongTac;
  String diaDiem;
  int soNguoiThamGia;
  int status;
  String statusName;
  int created;
  int thoiGianBatDau;
  int ngayLap;
  bool isActionBoSungNhanSu;
  bool isActionBoSungTrinhTu;
  bool isActionThayDoiChiHuy;
  bool isActionTruongCa;
  bool isActionThongBaoHoanThanh;
  bool isActionCancel;
  List<ShiftLeaders> users;
  int iDChiHuy;

  StatusWorkCommand getStatus() {
    switch (status) {
      case 1:
        return StatusWorkCommand.pending;
      case 2:
        return StatusWorkCommand.cancelled;
      case 3:
        return StatusWorkCommand.performTask;
      case 4:
        return StatusWorkCommand.waitingConfirm;
      case 5:
        return StatusWorkCommand.notFinished;
      case 6:
        return StatusWorkCommand.confirmed;
      case 7:
        return StatusWorkCommand.completedNotDone;
      case 8:
        return StatusWorkCommand.completedDone;
    }
    return StatusWorkCommand.pending;
  }

  String getStatusName() {
    switch (getStatus()) {
      case StatusWorkCommand.pending:
        return 'Chờ xử lý';
      case StatusWorkCommand.cancelled:
        return 'Hủy';
      case StatusWorkCommand.performTask:
        return 'Thực hiện công tác';
      case StatusWorkCommand.waitingConfirm:
        return 'Chờ xác nhận hoàn thành';
      case StatusWorkCommand.notFinished:
        return 'Kết thúc chưa xong';
      case StatusWorkCommand.confirmed:
        return 'Đã xác nhận';
      case StatusWorkCommand.completedNotDone:
        return 'Kết thúc(Chưa hoàn thành)';
      case StatusWorkCommand.completedDone:
        return 'Kết thúc(Hoàn thành)';
    }
    return "";
  }

  WorkCommand(
      {this.iD,
        this.iDChannel,
        this.code,
        this.nguoiLap,
        this.noiDungCongTac,
        this.diaDiem,
        this.soNguoiThamGia,
        this.status,
        this.statusName,
        this.created,
        this.thoiGianBatDau,
        this.ngayLap,
        this.isActionBoSungNhanSu,
        this.isActionBoSungTrinhTu,
        this.isActionThayDoiChiHuy,
        this.isActionTruongCa,
        this.isActionThongBaoHoanThanh,
        this.isActionCancel,
        this.users,
        this.iDChiHuy});

  WorkCommand.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDChannel = json['IDChannel'];
    code = json['Code'];
    nguoiLap = json['NguoiLap'];
    noiDungCongTac = json['NoiDungCongTac'];
    diaDiem = json['DiaDiem'];
    soNguoiThamGia = json['SoNguoiThamGia'];
    status = json['Status'];
    statusName = json['StatusName'];
    created = json['Created'];
    thoiGianBatDau = json['ThoiGianBatDau'];
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
    data['SoNguoiThamGia'] = this.soNguoiThamGia;
    data['Status'] = this.status;
    data['StatusName'] = this.statusName;
    data['Created'] = this.created;
    data['ThoiGianBatDau'] = this.thoiGianBatDau;
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

class Status {
  String s1;
  String s2;
  String s3;
  String s4;
  String s5;
  String s6;
  String s7;
  String s8;

  Status(
      {this.s1, this.s2, this.s3, this.s4, this.s5, this.s6, this.s7, this.s8});

  Status.fromJson(Map<String, dynamic> json) {
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
