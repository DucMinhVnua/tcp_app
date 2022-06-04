import 'package:workflow_manager/base/models/base_response.dart';

class WorkCommandDetailResponse extends BaseResponse {
  WorkCommandDetail data;

  WorkCommandDetailResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data = json['Data'] != null ? new WorkCommandDetail.fromJson(json['Data']) : null;
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

class WorkCommandDetail {
  int code;
  ThongTinChung thongTinChung;
  bool isActionCheckin;
  bool isXacNhanCoMatDayDu;
  List<DanhSachNhanVien> danhSachNhanVien;
  List<DanhSachTrinhTuCongViec> danhSachTrinhTuCongViec;
  List<DanhSachCapNhapNguoiChiHuy> danhSachCapNhapNguoiChiHuy;
  List<DanhSachLichSuDoiCa> danhSachLichSuDoiCa;

  WorkCommandDetail(
      {this.code,
        this.thongTinChung,
        this.isActionCheckin,
        this.isXacNhanCoMatDayDu,
        this.danhSachNhanVien,
        this.danhSachTrinhTuCongViec,
        this.danhSachCapNhapNguoiChiHuy,
        this.danhSachLichSuDoiCa});

  WorkCommandDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    thongTinChung = json['ThongTinChung'] != null
        ? new ThongTinChung.fromJson(json['ThongTinChung'])
        : null;
    isActionCheckin = json['IsActionCheckin'];
    isXacNhanCoMatDayDu = json['IsXacNhanCoMatDayDu'];
    if (json['DanhSachNhanVien'] != null) {
      danhSachNhanVien = <DanhSachNhanVien>[];
      json['DanhSachNhanVien'].forEach((v) {
        danhSachNhanVien.add(new DanhSachNhanVien.fromJson(v));
      });
    }
    if (json['DanhSachTrinhTuCongViec'] != null) {
      danhSachTrinhTuCongViec = <DanhSachTrinhTuCongViec>[];
      json['DanhSachTrinhTuCongViec'].forEach((v) {
        danhSachTrinhTuCongViec.add(new DanhSachTrinhTuCongViec.fromJson(v));
      });
    }
    if (json['DanhSachCapNhapNguoiChiHuy'] != null) {
      danhSachCapNhapNguoiChiHuy = <DanhSachCapNhapNguoiChiHuy>[];
      json['DanhSachCapNhapNguoiChiHuy'].forEach((v) {
        danhSachCapNhapNguoiChiHuy
            .add(new DanhSachCapNhapNguoiChiHuy.fromJson(v));
      });
    }
    if (json['DanhSachLichSuDoiCa'] != null) {
      danhSachLichSuDoiCa = <DanhSachLichSuDoiCa>[];
      json['DanhSachLichSuDoiCa'].forEach((v) {
        danhSachLichSuDoiCa.add(new DanhSachLichSuDoiCa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.thongTinChung != null) {
      data['ThongTinChung'] = this.thongTinChung.toJson();
    }
    data['IsActionCheckin'] = this.isActionCheckin;
    data['IsXacNhanCoMatDayDu'] = this.isXacNhanCoMatDayDu;
    if (this.danhSachNhanVien != null) {
      data['DanhSachNhanVien'] =
          this.danhSachNhanVien.map((v) => v.toJson()).toList();
    }
    if (this.danhSachTrinhTuCongViec != null) {
      data['DanhSachTrinhTuCongViec'] =
          this.danhSachTrinhTuCongViec.map((v) => v.toJson()).toList();
    }
    if (this.danhSachCapNhapNguoiChiHuy != null) {
      data['DanhSachCapNhapNguoiChiHuy'] =
          this.danhSachCapNhapNguoiChiHuy.map((v) => v.toJson()).toList();
    }
    if (this.danhSachLichSuDoiCa != null) {
      data['DanhSachLichSuDoiCa'] =
          this.danhSachLichSuDoiCa.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThongTinChung {
  int iD;
  int iDServiceRecord;
  int iDChannel;
  String code;
  int ngayLap;
  String nguoiChiHuy;
  String nguoiChoPhepTaiCho;
  String nguoiGiamSatATD;
  String nguoiChoPhep;
  int soNguoiThamGia;
  int thoiGianBatDau;
  String diaDiem;
  String noiDungCongTac;
  String dieuKienVeATD;
  int iDNguoiChoPhep;
  int iDNguoiChoPhepTaiCho;

  ThongTinChung(
      {this.iD,
        this.iDServiceRecord,
        this.iDChannel,
        this.code,
        this.ngayLap,
        this.nguoiChiHuy,
        this.nguoiChoPhepTaiCho,
        this.nguoiGiamSatATD,
        this.nguoiChoPhep,
        this.soNguoiThamGia,
        this.thoiGianBatDau,
        this.diaDiem,
        this.noiDungCongTac,
        this.dieuKienVeATD,
        this.iDNguoiChoPhep,
        this.iDNguoiChoPhepTaiCho});

  ThongTinChung.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDServiceRecord = json['IDServiceRecord'];
    iDChannel = json['IDChannel'];
    code = json['Code'];
    ngayLap = json['NgayLap'];
    nguoiChiHuy = json['NguoiChiHuy'];
    nguoiChoPhepTaiCho = json['NguoiChoPhepTaiCho'];
    nguoiGiamSatATD = json['NguoiGiamSatATD'];
    nguoiChoPhep = json['NguoiChoPhep'];
    soNguoiThamGia = json['SoNguoiThamGia'];
    thoiGianBatDau = json['ThoiGianBatDau'];
    diaDiem = json['DiaDiem'];
    noiDungCongTac = json['NoiDungCongTac'];
    dieuKienVeATD = json['DieuKienVeATD'];
    iDNguoiChoPhep = json['IDNguoiChoPhep'];
    iDNguoiChoPhepTaiCho = json['IDNguoiChoPhepTaiCho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['IDServiceRecord'] = this.iDServiceRecord;
    data['IDChannel'] = this.iDChannel;
    data['Code'] = this.code;
    data['NgayLap'] = this.ngayLap;
    data['NguoiChiHuy'] = this.nguoiChiHuy;
    data['NguoiChoPhepTaiCho'] = this.nguoiChoPhepTaiCho;
    data['NguoiGiamSatATD'] = this.nguoiGiamSatATD;
    data['NguoiChoPhep'] = this.nguoiChoPhep;
    data['SoNguoiThamGia'] = this.soNguoiThamGia;
    data['ThoiGianBatDau'] = this.thoiGianBatDau;
    data['DiaDiem'] = this.diaDiem;
    data['NoiDungCongTac'] = this.noiDungCongTac;
    data['DieuKienVeATD'] = this.dieuKienVeATD;
    data['IDNguoiChoPhep'] = this.iDNguoiChoPhep;
    data['IDNguoiChoPhepTaiCho'] = this.iDNguoiChoPhepTaiCho;
    return data;
  }
}

class DanhSachNhanVien {
  int iDNhanVien;
  String hoVaTen;
  int bacAnToanDien;
  int thoiGianDenLamViec;
  int thoiGianRutKhoi;
  bool isXacNhanRutKhoi;
  bool isChiHuyXacNhan;
  bool isNguoiChoPhepTaiChoXacNhan;
  bool isNguoiChoPhepXacNhan;

  DanhSachNhanVien(
      {this.iDNhanVien,
        this.hoVaTen,
        this.bacAnToanDien,
        this.thoiGianDenLamViec,
        this.thoiGianRutKhoi,
        this.isXacNhanRutKhoi,
        this.isChiHuyXacNhan,
        this.isNguoiChoPhepTaiChoXacNhan,
        this.isNguoiChoPhepXacNhan});

  DanhSachNhanVien.fromJson(Map<String, dynamic> json) {
    iDNhanVien = json['IDNhanVien'];
    hoVaTen = json['HoVaTen'];
    bacAnToanDien = json['BacAnToanDien'];
    thoiGianDenLamViec = json['ThoiGianDenLamViec'];
    thoiGianRutKhoi = json['ThoiGianRutKhoi'];
    isXacNhanRutKhoi = json['IsXacNhanRutKhoi'];
    isChiHuyXacNhan = json['IsChiHuyXacNhan'];
    isNguoiChoPhepTaiChoXacNhan = json['IsNguoiChoPhepTaiChoXacNhan'];
    isNguoiChoPhepXacNhan = json['IsNguoiChoPhepXacNhan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDNhanVien'] = this.iDNhanVien;
    data['HoVaTen'] = this.hoVaTen;
    data['BacAnToanDien'] = this.bacAnToanDien;
    data['ThoiGianDenLamViec'] = this.thoiGianDenLamViec;
    data['ThoiGianRutKhoi'] = this.thoiGianRutKhoi;
    data['IsXacNhanRutKhoi'] = this.isXacNhanRutKhoi;
    data['IsChiHuyXacNhan'] = this.isChiHuyXacNhan;
    data['IsNguoiChoPhepTaiChoXacNhan'] = this.isNguoiChoPhepTaiChoXacNhan;
    data['IsNguoiChoPhepXacNhan'] = this.isNguoiChoPhepXacNhan;
    return data;
  }
}

class DanhSachTrinhTuCongViec {
  int iDTrinhTu;
  String trinhTuThaoTac;
  String trinhTuCongTacNCPTC;
  String dieuKienAnToan;
  int thoiGianBatDau;
  int thoiGianKetThuc;
  String nguoiChiHuyXacNhanBD;
  String nguoiChiHuyXacNhanKT;
  String nguoiChoPhepXacNhanBD;
  String nguoiChoPhepXacNhanKT;
  String nguoiChoPhepTaiChoBD;
  String nguoiChoPhepTaiChoKT;
  bool isChiHuyXacNhanBD;
  bool isNguoiChoPhepXacNhanBD;
  bool isNguoiChoPhepTaiChoXacNhanBD;
  bool isChiHuyXacNhanKT;
  bool isNguoiChoPhepXacNhanKT;
  bool isNguoiChoPhepTaiChoXacNhanKT;

  DanhSachTrinhTuCongViec(
      {this.iDTrinhTu,
        this.trinhTuThaoTac,
        this.trinhTuCongTacNCPTC,
        this.dieuKienAnToan,
        this.thoiGianBatDau,
        this.thoiGianKetThuc,
        this.nguoiChiHuyXacNhanBD,
        this.nguoiChiHuyXacNhanKT,
        this.nguoiChoPhepXacNhanBD,
        this.nguoiChoPhepXacNhanKT,
        this.nguoiChoPhepTaiChoBD,
        this.nguoiChoPhepTaiChoKT,
        this.isChiHuyXacNhanBD,
        this.isNguoiChoPhepXacNhanBD,
        this.isNguoiChoPhepTaiChoXacNhanBD,
        this.isChiHuyXacNhanKT,
        this.isNguoiChoPhepXacNhanKT,
        this.isNguoiChoPhepTaiChoXacNhanKT});

  DanhSachTrinhTuCongViec.fromJson(Map<String, dynamic> json) {
    iDTrinhTu = json['IDTrinhTu'];
    trinhTuThaoTac = json['TrinhTuThaoTac'];
    trinhTuCongTacNCPTC = json['TrinhTuCongTacNCPTC'];
    dieuKienAnToan = json['DieuKienAnToan'];
    thoiGianBatDau = json['ThoiGianBatDau'];
    thoiGianKetThuc = json['ThoiGianKetThuc'];
    nguoiChiHuyXacNhanBD = json['NguoiChiHuyXacNhanBD'];
    nguoiChiHuyXacNhanKT = json['NguoiChiHuyXacNhanKT'];
    nguoiChoPhepXacNhanBD = json['NguoiChoPhepXacNhanBD'];
    nguoiChoPhepXacNhanKT = json['NguoiChoPhepXacNhanKT'];
    nguoiChoPhepTaiChoBD = json['NguoiChoPhepTaiChoBD'];
    nguoiChoPhepTaiChoKT = json['NguoiChoPhepTaiChoKT'];
    isChiHuyXacNhanBD = json['IsChiHuyXacNhanBD'];
    isNguoiChoPhepXacNhanBD = json['IsNguoiChoPhepXacNhanBD'];
    isNguoiChoPhepTaiChoXacNhanBD = json['IsNguoiChoPhepTaiChoXacNhanBD'];
    isChiHuyXacNhanKT = json['IsChiHuyXacNhanKT'];
    isNguoiChoPhepXacNhanKT = json['IsNguoiChoPhepXacNhanKT'];
    isNguoiChoPhepTaiChoXacNhanKT = json['IsNguoiChoPhepTaiChoXacNhanKT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDTrinhTu'] = this.iDTrinhTu;
    data['TrinhTuThaoTac'] = this.trinhTuThaoTac;
    data['TrinhTuCongTacNCPTC'] = this.trinhTuCongTacNCPTC;
    data['DieuKienAnToan'] = this.dieuKienAnToan;
    data['ThoiGianBatDau'] = this.thoiGianBatDau;
    data['ThoiGianKetThuc'] = this.thoiGianKetThuc;
    data['NguoiChiHuyXacNhanBD'] = this.nguoiChiHuyXacNhanBD;
    data['NguoiChiHuyXacNhanKT'] = this.nguoiChiHuyXacNhanKT;
    data['NguoiChoPhepXacNhanBD'] = this.nguoiChoPhepXacNhanBD;
    data['NguoiChoPhepXacNhanKT'] = this.nguoiChoPhepXacNhanKT;
    data['NguoiChoPhepTaiChoBD'] = this.nguoiChoPhepTaiChoBD;
    data['NguoiChoPhepTaiChoKT'] = this.nguoiChoPhepTaiChoKT;
    data['IsChiHuyXacNhanBD'] = this.isChiHuyXacNhanBD;
    data['IsNguoiChoPhepXacNhanBD'] = this.isNguoiChoPhepXacNhanBD;
    data['IsNguoiChoPhepTaiChoXacNhanBD'] = this.isNguoiChoPhepTaiChoXacNhanBD;
    data['IsChiHuyXacNhanKT'] = this.isChiHuyXacNhanKT;
    data['IsNguoiChoPhepXacNhanKT'] = this.isNguoiChoPhepXacNhanKT;
    data['IsNguoiChoPhepTaiChoXacNhanKT'] = this.isNguoiChoPhepTaiChoXacNhanKT;
    return data;
  }
}

class DanhSachCapNhapNguoiChiHuy {
  int iD;
  String chiHuyTrucTiepCu;
  String chiHuyTrucTiepMoi;
  String lyDo;
  String trangThai;
  int thoiGianThongBaoDoiCa;
  int thoiGianXacNhan;
  bool isXacNhan;

  DanhSachCapNhapNguoiChiHuy(
      {this.iD,
        this.chiHuyTrucTiepCu,
        this.chiHuyTrucTiepMoi,
        this.lyDo,
        this.trangThai,
        this.thoiGianThongBaoDoiCa,
        this.thoiGianXacNhan,
        this.isXacNhan});

  DanhSachCapNhapNguoiChiHuy.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    chiHuyTrucTiepCu = json['ChiHuyTrucTiepCu'];
    chiHuyTrucTiepMoi = json['ChiHuyTrucTiepMoi'];
    lyDo = json['LyDo'];
    trangThai = json['TrangThai'];
    thoiGianThongBaoDoiCa = json['ThoiGianThongBaoDoiCa'];
    thoiGianXacNhan = json['ThoiGianXacNhan'];
    isXacNhan = json['IsXacNhan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ChiHuyTrucTiepCu'] = this.chiHuyTrucTiepCu;
    data['ChiHuyTrucTiepMoi'] = this.chiHuyTrucTiepMoi;
    data['LyDo'] = this.lyDo;
    data['TrangThai'] = this.trangThai;
    data['ThoiGianThongBaoDoiCa'] = this.thoiGianThongBaoDoiCa;
    data['ThoiGianXacNhan'] = this.thoiGianXacNhan;
    data['IsXacNhan'] = this.isXacNhan;
    return data;
  }

  StatusConfirmCommander getStatus() {
    if (trangThai == 'Đã xác nhận') {
      return StatusConfirmCommander.confirmed;
    } else {
      return StatusConfirmCommander.notConfirm;
    }
  }

}

class DanhSachLichSuDoiCa {
  int iD;
  String truongCaCu;
  String truongCaMoi;
  String noiDung;

  DanhSachLichSuDoiCa(
      {this.iD, this.truongCaCu, this.truongCaMoi, this.noiDung});

  DanhSachLichSuDoiCa.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    truongCaCu = json['TruongCaCu'];
    truongCaMoi = json['TruongCaMoi'];
    noiDung = json['NoiDung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TruongCaCu'] = this.truongCaCu;
    data['TruongCaMoi'] = this.truongCaMoi;
    data['NoiDung'] = this.noiDung;
    return data;
  }
}

enum StatusConfirmCommander {
  notConfirm,
  confirmed
}
