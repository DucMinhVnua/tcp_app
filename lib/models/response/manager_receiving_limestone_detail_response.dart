import 'package:workflow_manager/base/models/base_response.dart';

class ManagerReceivingLimestoneDetailResponse extends BaseResponse {
  ManagerReceivingLimestoneDetail data;

  ManagerReceivingLimestoneDetailResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data = json['Data'] != null
        ? new ManagerReceivingLimestoneDetail.fromJson(json['Data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class ManagerReceivingLimestoneDetail {
  int code;
  ThongTinChung thongTinChung;
  List<DanhSachGuiYeuCauTruocVaTrongTiepNhan>
      danhSachGuiYeuCauTruocVaTrongTiepNhan;

  ManagerReceivingLimestoneDetail(
      {this.code,
      this.thongTinChung,
      this.danhSachGuiYeuCauTruocVaTrongTiepNhan});

  ManagerReceivingLimestoneDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    thongTinChung = json['ThongTinChung'] != null
        ? new ThongTinChung.fromJson(json['ThongTinChung'])
        : null;
    if (json['DanhSachGuiYeuCauTruocVaTrongTiepNhan'] != null) {
      danhSachGuiYeuCauTruocVaTrongTiepNhan =
          new List<DanhSachGuiYeuCauTruocVaTrongTiepNhan>();
      json['DanhSachGuiYeuCauTruocVaTrongTiepNhan'].forEach((v) {
        danhSachGuiYeuCauTruocVaTrongTiepNhan
            .add(new DanhSachGuiYeuCauTruocVaTrongTiepNhan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.thongTinChung != null) {
      data['ThongTinChung'] = this.thongTinChung.toJson();
    }
    if (this.danhSachGuiYeuCauTruocVaTrongTiepNhan != null) {
      data['DanhSachGuiYeuCauTruocVaTrongTiepNhan'] = this
          .danhSachGuiYeuCauTruocVaTrongTiepNhan
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ThongTinChung {
  String soPhieuYeuCau;
  int ngayGuiYeuCau;
  int thoiGianGiaoHangTuNgay;
  int thoiGianGiaoHangDenNgay;
  String phieuTiepNhanDaVoi;
  String soHopDong;
  int ngayHopDong;
  String diaDiemGiaoHang;

  ThongTinChung(
      {this.soPhieuYeuCau,
        this.ngayGuiYeuCau,
        this.thoiGianGiaoHangTuNgay,
        this.thoiGianGiaoHangDenNgay,
        this.phieuTiepNhanDaVoi,
        this.soHopDong,
        this.ngayHopDong,
        this.diaDiemGiaoHang});

  ThongTinChung.fromJson(Map<String, dynamic> json) {
    soPhieuYeuCau = json['SoPhieuYeuCau'];
    ngayGuiYeuCau = json['NgayGuiYeuCau'];
    thoiGianGiaoHangTuNgay = json['ThoiGianGiaoHangTuNgay'];
    thoiGianGiaoHangDenNgay = json['ThoiGianGiaoHangDenNgay'];
    phieuTiepNhanDaVoi = json['PhieuTiepNhanDaVoi'];
    soHopDong = json['SoHopDong'];
    ngayHopDong = json['NgayHopDong'];
    diaDiemGiaoHang = json['DiaDiemGiaoHang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SoPhieuYeuCau'] = this.soPhieuYeuCau;
    data['NgayGuiYeuCau'] = this.ngayGuiYeuCau;
    data['ThoiGianGiaoHangTuNgay'] = this.thoiGianGiaoHangTuNgay;
    data['ThoiGianGiaoHangDenNgay'] = this.thoiGianGiaoHangDenNgay;
    data['PhieuTiepNhanDaVoi'] = this.phieuTiepNhanDaVoi;
    data['SoHopDong'] = this.soHopDong;
    data['NgayHopDong'] = this.ngayHopDong;
    data['DiaDiemGiaoHang'] = this.diaDiemGiaoHang;
    return data;
  }
}

class DanhSachGuiYeuCauTruocVaTrongTiepNhan {
  int iDServicerecord;
  String noiDungThongBao;
  int thoiGianYeuCau;
  String nguoiGuiYeuCau;
  String nguoiNhanYeuCau;
  String trangThai;
  List<DanhSachFile> danhSachFile;

  DanhSachGuiYeuCauTruocVaTrongTiepNhan(
      {this.iDServicerecord,
      this.noiDungThongBao,
      this.thoiGianYeuCau,
      this.nguoiGuiYeuCau,
      this.nguoiNhanYeuCau,
      this.trangThai,
      this.danhSachFile});

  DanhSachGuiYeuCauTruocVaTrongTiepNhan.fromJson(Map<String, dynamic> json) {
    iDServicerecord = json['IDServicerecord'];
    noiDungThongBao = json['NoiDungThongBao'];
    thoiGianYeuCau = json['ThoiGianYeuCau'];
    nguoiGuiYeuCau = json['NguoiGuiYeuCau'];
    nguoiNhanYeuCau = json['NguoiNhanYeuCau'];
    trangThai = json['TrangThai'];
    if (json['DanhSachFile'] != null) {
      danhSachFile = new List<DanhSachFile>();
      json['DanhSachFile'].forEach((v) {
        danhSachFile.add(new DanhSachFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDServicerecord'] = this.iDServicerecord;
    data['NoiDungThongBao'] = this.noiDungThongBao;
    data['ThoiGianYeuCau'] = this.thoiGianYeuCau;
    data['NguoiGuiYeuCau'] = this.nguoiGuiYeuCau;
    data['NguoiNhanYeuCau'] = this.nguoiNhanYeuCau;
    data['TrangThai'] = this.trangThai;
    if (this.danhSachFile != null) {
      data['DanhSachFile'] = this.danhSachFile.map((v) => v.toJson()).toList();
    }
    return data;
  }

  StatusRequire getStatus() {
    switch (trangThai) {
      case 'Đang lấy mẫu':
        return StatusRequire.inProgress;
      case 'Hoàn thành lấy mẫu':
        return StatusRequire.finished;
    }
    return StatusRequire.inProgress;
  }
}

class DanhSachFile {
  String fileName;
  String nguoiTai;
  int ngayTaiLen;
  String linkDownLoad;

  DanhSachFile(
      {this.fileName, this.nguoiTai, this.ngayTaiLen, this.linkDownLoad});

  DanhSachFile.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
    nguoiTai = json['NguoiTai'];
    ngayTaiLen = json['NgayTaiLen'];
    linkDownLoad = json['LinkDownLoad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['NguoiTai'] = this.nguoiTai;
    data['NgayTaiLen'] = this.ngayTaiLen;
    data['LinkDownLoad'] = this.linkDownLoad;
    return data;
  }
}
enum StatusRequire { inProgress, finished }