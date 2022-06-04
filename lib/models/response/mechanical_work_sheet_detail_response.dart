import 'package:workflow_manager/base/models/base_response.dart';

class MechanicalWorkSheetDetailResponse extends BaseResponse {
  MechanicalWorkSheetDetail data;

  MechanicalWorkSheetDetailResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data = json['Data'] != null
        ? new MechanicalWorkSheetDetail.fromJson(json['Data'])
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

class MechanicalWorkSheetDetail {
  int code;
  ThongTinChung thongTinChung;
  List<DanhSachNhanDienMoiNguy> danhSachNhanDienMoiNguy;
  List<DanhSachKiemTraCacBienPhapAnToanCP> danhSachKiemTraCacBienPhapAnToanCP;
  List<DanhSachKiemTraCacBienPhapAnToanCH> danhSachKiemTraCacBienPhapAnToanCH;
  bool isXacNhanCoMatDayDu;
  List<DanhSachNhanVien> danhSachNhanVien;
  List<DanhSachDiaDiemCongTac> danhSachDiaDiemCongTac;
  List<DanhSachCapNhapNguoiChiHuy> danhSachCapNhapNguoiChiHuy;
  List<DanhSachLichSuDoiCa> danhSachLichSuDoiCa;

  MechanicalWorkSheetDetail(
      {this.code,
        this.thongTinChung,
        this.danhSachNhanDienMoiNguy,
        this.danhSachKiemTraCacBienPhapAnToanCP,
        this.danhSachKiemTraCacBienPhapAnToanCH,
        this.isXacNhanCoMatDayDu,
        this.danhSachNhanVien,
        this.danhSachDiaDiemCongTac,
        this.danhSachCapNhapNguoiChiHuy,
        this.danhSachLichSuDoiCa});

  MechanicalWorkSheetDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    thongTinChung = json['ThongTinChung'] != null
        ? new ThongTinChung.fromJson(json['ThongTinChung'])
        : null;
    if (json['DanhSachNhanDienMoiNguy'] != null) {
      danhSachNhanDienMoiNguy = <DanhSachNhanDienMoiNguy>[];
      json['DanhSachNhanDienMoiNguy'].forEach((v) {
        danhSachNhanDienMoiNguy.add(new DanhSachNhanDienMoiNguy.fromJson(v));
      });
    }
    if (json['DanhSachKiemTraCacBienPhapAnToanCP'] != null) {
      danhSachKiemTraCacBienPhapAnToanCP =
      <DanhSachKiemTraCacBienPhapAnToanCP>[];
      json['DanhSachKiemTraCacBienPhapAnToanCP'].forEach((v) {
        danhSachKiemTraCacBienPhapAnToanCP
            .add(new DanhSachKiemTraCacBienPhapAnToanCP.fromJson(v));
      });
    }
    if (json['DanhSachKiemTraCacBienPhapAnToanCH'] != null) {
      danhSachKiemTraCacBienPhapAnToanCH =
      <DanhSachKiemTraCacBienPhapAnToanCH>[];
      json['DanhSachKiemTraCacBienPhapAnToanCH'].forEach((v) {
        danhSachKiemTraCacBienPhapAnToanCH
            .add(new DanhSachKiemTraCacBienPhapAnToanCH.fromJson(v));
      });
    }
    isXacNhanCoMatDayDu = json['IsXacNhanCoMatDayDu'];
    if (json['DanhSachNhanVien'] != null) {
      danhSachNhanVien = <DanhSachNhanVien>[];
      json['DanhSachNhanVien'].forEach((v) {
        danhSachNhanVien.add(new DanhSachNhanVien.fromJson(v));
      });
    }
    if (json['DanhSachDiaDiemCongTac'] != null) {
      danhSachDiaDiemCongTac = <DanhSachDiaDiemCongTac>[];
      json['DanhSachDiaDiemCongTac'].forEach((v) {
        danhSachDiaDiemCongTac.add(new DanhSachDiaDiemCongTac.fromJson(v));
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
    if (this.danhSachNhanDienMoiNguy != null) {
      data['DanhSachNhanDienMoiNguy'] =
          this.danhSachNhanDienMoiNguy.map((v) => v.toJson()).toList();
    }
    if (this.danhSachKiemTraCacBienPhapAnToanCP != null) {
      data['DanhSachKiemTraCacBienPhapAnToanCP'] = this
          .danhSachKiemTraCacBienPhapAnToanCP
          .map((v) => v.toJson())
          .toList();
    }
    if (this.danhSachKiemTraCacBienPhapAnToanCH != null) {
      data['DanhSachKiemTraCacBienPhapAnToanCH'] = this
          .danhSachKiemTraCacBienPhapAnToanCH
          .map((v) => v.toJson())
          .toList();
    }
    data['IsXacNhanCoMatDayDu'] = this.isXacNhanCoMatDayDu;
    if (this.danhSachNhanVien != null) {
      data['DanhSachNhanVien'] =
          this.danhSachNhanVien.map((v) => v.toJson()).toList();
    }
    if (this.danhSachDiaDiemCongTac != null) {
      data['DanhSachDiaDiemCongTac'] =
          this.danhSachDiaDiemCongTac.map((v) => v.toJson()).toList();
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
  String nguoiLap;
  String nguoiCap;
  String donViCap;
  String nguoiChoPhep;
  String nguoiChoPhepTaiCho;
  String nguoiChiHuy;
  String diaDiem;
  String noiDung;
  String phamVi;
  int thoiGianTu;
  int thoiGianDen;
  int iDNguoiChoPhep;
  int iDNguoiChoPhepTaiCho;

  ThongTinChung(
      {this.iD,
      this.iDServiceRecord,
      this.iDChannel,
      this.code,
      this.ngayLap,
      this.nguoiLap,
      this.nguoiCap,
      this.donViCap,
      this.nguoiChoPhep,
      this.nguoiChoPhepTaiCho,
      this.nguoiChiHuy,
      this.diaDiem,
      this.noiDung,
      this.phamVi,
      this.thoiGianTu,
      this.thoiGianDen,
      this.iDNguoiChoPhep,
      this.iDNguoiChoPhepTaiCho});

  ThongTinChung.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDServiceRecord = json['IDServiceRecord'];
    iDChannel = json['IDChannel'];
    code = json['Code'];
    ngayLap = json['NgayLap'];
    nguoiLap = json['NguoiLap'];
    nguoiCap = json['NguoiCap'];
    donViCap = json['DonViCap'];
    nguoiChoPhep = json['NguoiChoPhep'];
    nguoiChoPhepTaiCho = json['NguoiChoPhepTaiCho'];
    nguoiChiHuy = json['NguoiChiHuy'];
    diaDiem = json['DiaDiem'];
    noiDung = json['NoiDung'];
    phamVi = json['PhamVi'];
    thoiGianTu = json['ThoiGianTu'];
    thoiGianDen = json['ThoiGianDen'];
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
    data['NguoiLap'] = this.nguoiLap;
    data['NguoiCap'] = this.nguoiCap;
    data['DonViCap'] = this.donViCap;
    data['NguoiChoPhep'] = this.nguoiChoPhep;
    data['NguoiChoPhepTaiCho'] = this.nguoiChoPhepTaiCho;
    data['NguoiChiHuy'] = this.nguoiChiHuy;
    data['DiaDiem'] = this.diaDiem;
    data['NoiDung'] = this.noiDung;
    data['PhamVi'] = this.phamVi;
    data['ThoiGianTu'] = this.thoiGianTu;
    data['ThoiGianDen'] = this.thoiGianDen;
    data['IDNguoiChoPhep'] = this.iDNguoiChoPhep;
    data['IDNguoiChoPhepTaiCho'] = this.iDNguoiChoPhepTaiCho;
    return data;
  }
}

class DanhSachNhanVien {
  int iDThamGia;
  int ngay;
  String hoVaTen;
  String soTheATD;
  int thoiGianDenLamViec;
  int thoiGianRutKhoi;
  bool isActionCheckin;
  bool isXacNhanRutKhoi;
  bool isChiHuyXacNhan;
  bool isNguoiChoPhepTaiChoXacNhan;
  bool isNguoiChoPhepXacNhan;

  DanhSachNhanVien(
      {this.iDThamGia,
      this.ngay,
      this.hoVaTen,
      this.soTheATD,
      this.thoiGianDenLamViec,
      this.thoiGianRutKhoi,
      this.isActionCheckin,
      this.isXacNhanRutKhoi,
      this.isChiHuyXacNhan,
      this.isNguoiChoPhepTaiChoXacNhan,
      this.isNguoiChoPhepXacNhan});

  DanhSachNhanVien.fromJson(Map<String, dynamic> json) {
    iDThamGia = json['IDThamGia'];
    ngay = json['Ngay'];
    hoVaTen = json['HoVaTen'];
    soTheATD = json['SoTheATD'];
    thoiGianDenLamViec = json['ThoiGianDenLamViec'];
    thoiGianRutKhoi = json['ThoiGianRutKhoi'];
    isActionCheckin = json['IsActionCheckin'];
    isXacNhanRutKhoi = json['IsXacNhanRutKhoi'];
    isChiHuyXacNhan = json['IsChiHuyXacNhan'];
    isNguoiChoPhepTaiChoXacNhan = json['IsNguoiChoPhepTaiChoXacNhan'];
    isNguoiChoPhepXacNhan = json['IsNguoiChoPhepXacNhan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDThamGia'] = this.iDThamGia;
    data['Ngay'] = this.ngay;
    data['HoVaTen'] = this.hoVaTen;
    data['SoTheATD'] = this.soTheATD;
    data['ThoiGianDenLamViec'] = this.thoiGianDenLamViec;
    data['ThoiGianRutKhoi'] = this.thoiGianRutKhoi;
    data['IsActionCheckin'] = this.isActionCheckin;
    data['IsXacNhanRutKhoi'] = this.isXacNhanRutKhoi;
    data['IsChiHuyXacNhan'] = this.isChiHuyXacNhan;
    data['IsNguoiChoPhepTaiChoXacNhan'] = this.isNguoiChoPhepTaiChoXacNhan;
    data['IsNguoiChoPhepXacNhan'] = this.isNguoiChoPhepXacNhan;
    return data;
  }
}

class DanhSachDiaDiemCongTac {
  int iDDiaDiem;
  String diaDiemCongTac;
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

  DanhSachDiaDiemCongTac(
      {this.iDDiaDiem,
      this.diaDiemCongTac,
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

  DanhSachDiaDiemCongTac.fromJson(Map<String, dynamic> json) {
    iDDiaDiem = json['IDDiaDiem'];
    diaDiemCongTac = json['DiaDiemCongTac'];
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
    data['IDDiaDiem'] = this.iDDiaDiem;
    data['DiaDiemCongTac'] = this.diaDiemCongTac;
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

class DanhSachNhanDienMoiNguy {
  int iD;
  String nhanDienMoiNguy;
  String bienPhapAnToan;

  DanhSachNhanDienMoiNguy({this.iD, this.nhanDienMoiNguy, this.bienPhapAnToan});

  DanhSachNhanDienMoiNguy.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nhanDienMoiNguy = json['NhanDienMoiNguy'];
    bienPhapAnToan = json['BienPhapAnToan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NhanDienMoiNguy'] = this.nhanDienMoiNguy;
    data['BienPhapAnToan'] = this.bienPhapAnToan;
    return data;
  }
}

class DanhSachKiemTraCacBienPhapAnToanCP {
  int iD;
  String kiemTraCacBienPhap;
  String danhDau;
  String ghiChu;

  DanhSachKiemTraCacBienPhapAnToanCP(
      {this.iD, this.kiemTraCacBienPhap, this.danhDau, this.ghiChu});

  DanhSachKiemTraCacBienPhapAnToanCP.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    kiemTraCacBienPhap = json['KiemTraCacBienPhap'];
    danhDau = json['DanhDau'];
    ghiChu = json['GhiChu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['KiemTraCacBienPhap'] = this.kiemTraCacBienPhap;
    data['DanhDau'] = this.danhDau;
    data['GhiChu'] = this.ghiChu;
    return data;
  }
}

class DanhSachKiemTraCacBienPhapAnToanCH {
  int iD;
  String kiemTraCacBienPhap;
  String danhDau;
  String ghiChu;

  DanhSachKiemTraCacBienPhapAnToanCH(
      {this.iD, this.kiemTraCacBienPhap, this.danhDau, this.ghiChu});

  DanhSachKiemTraCacBienPhapAnToanCH.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    kiemTraCacBienPhap = json['KiemTraCacBienPhap'];
    danhDau = json['DanhDau'];
    ghiChu = json['GhiChu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['KiemTraCacBienPhap'] = this.kiemTraCacBienPhap;
    data['DanhDau'] = this.danhDau;
    data['GhiChu'] = this.ghiChu;
    return data;
  }
}

class DanhSachCapNhapNguoiChiHuy {
  int iD;
  String chiHuyTrucTiepCu;
  String chiHuyTrucTiepMoi;
  String trangThai;
  int thoiGianThongBaoDoiCa;
  int thoiGianXacNhan;
  bool isXacNhan;

  DanhSachCapNhapNguoiChiHuy(
      {this.iD,
        this.chiHuyTrucTiepCu,
        this.chiHuyTrucTiepMoi,
        this.trangThai,
        this.thoiGianThongBaoDoiCa,
        this.thoiGianXacNhan,
        this.isXacNhan});

  DanhSachCapNhapNguoiChiHuy.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    chiHuyTrucTiepCu = json['ChiHuyTrucTiepCu'];
    chiHuyTrucTiepMoi = json['ChiHuyTrucTiepMoi'];
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