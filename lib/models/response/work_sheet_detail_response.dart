import 'package:workflow_manager/base/models/base_response.dart';

class WorkSheetDetailResponse extends BaseResponse {
  WorkSheetDetail data;

  WorkSheetDetailResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data =
    json['Data'] != null ? new WorkSheetDetail.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class WorkSheetDetail {
  int code;
  ThongTinChung thongTinChung;
  List<DanhSachDieuKienThucHien> danhSachDieuKienThucHien;
  List<DanhSachViTriTiepDat> danhSachViTriTiepDat;
  List<DanhSachViTriRaoChan> danhSachViTriRaoChan;
  List<DanhSachPhamViDuocPhepLamViec> danhSachPhamViDuocPhepLamViec;
  List<DanhSachCanhBaoChiDan> danhSachCanhBaoChiDan;
  List<DanhSachBienPhapAnToan> danhSachBienPhapAnToan;
  bool isXacNhanCoMatDayDu;
  List<DanhSachNhanVien> danhSachNhanVien;
  List<DanhSachDiaDiemCongTac> danhSachDiaDiemCongTac;
  List<DanhSachCapNhapNguoiChiHuy> danhSachCapNhapNguoiChiHuy;
  List<DanhSachLichSuDoiCa> danhSachLichSuDoiCa;

  WorkSheetDetail(
      {this.code,
        this.thongTinChung,
        this.danhSachDieuKienThucHien,
        this.danhSachViTriTiepDat,
        this.danhSachViTriRaoChan,
        this.danhSachPhamViDuocPhepLamViec,
        this.danhSachCanhBaoChiDan,
        this.danhSachBienPhapAnToan,
        this.isXacNhanCoMatDayDu,
        this.danhSachNhanVien,
        this.danhSachDiaDiemCongTac,
        this.danhSachCapNhapNguoiChiHuy,
        this.danhSachLichSuDoiCa});

  WorkSheetDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    thongTinChung = json['ThongTinChung'] != null
        ? new ThongTinChung.fromJson(json['ThongTinChung'])
        : null;
    if (json['DanhSachDieuKienThucHien'] != null) {
      danhSachDieuKienThucHien = <DanhSachDieuKienThucHien>[];
      json['DanhSachDieuKienThucHien'].forEach((v) {
        danhSachDieuKienThucHien.add(new DanhSachDieuKienThucHien.fromJson(v));
      });
    }
    if (json['DanhSachViTriTiepDat'] != null) {
      danhSachViTriTiepDat = <DanhSachViTriTiepDat>[];
      json['DanhSachViTriTiepDat'].forEach((v) {
        danhSachViTriTiepDat.add(new DanhSachViTriTiepDat.fromJson(v));
      });
    }
    if (json['DanhSachViTriRaoChan'] != null) {
      danhSachViTriRaoChan = <DanhSachViTriRaoChan>[];
      json['DanhSachViTriRaoChan'].forEach((v) {
        danhSachViTriRaoChan.add(new DanhSachViTriRaoChan.fromJson(v));
      });
    }
    if (json['DanhSachPhamViDuocPhepLamViec'] != null) {
      danhSachPhamViDuocPhepLamViec = <DanhSachPhamViDuocPhepLamViec>[];
      json['DanhSachPhamViDuocPhepLamViec'].forEach((v) {
        danhSachPhamViDuocPhepLamViec
            .add(new DanhSachPhamViDuocPhepLamViec.fromJson(v));
      });
    }
    if (json['DanhSachCanhBaoChiDan'] != null) {
      danhSachCanhBaoChiDan = <DanhSachCanhBaoChiDan>[];
      json['DanhSachCanhBaoChiDan'].forEach((v) {
        danhSachCanhBaoChiDan.add(new DanhSachCanhBaoChiDan.fromJson(v));
      });
    }
    if (json['DanhSachBienPhapAnToan'] != null) {
      danhSachBienPhapAnToan = <DanhSachBienPhapAnToan>[];
      json['DanhSachBienPhapAnToan'].forEach((v) {
        danhSachBienPhapAnToan.add(new DanhSachBienPhapAnToan.fromJson(v));
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
    if (this.danhSachDieuKienThucHien != null) {
      data['DanhSachDieuKienThucHien'] =
          this.danhSachDieuKienThucHien.map((v) => v.toJson()).toList();
    }
    if (this.danhSachViTriTiepDat != null) {
      data['DanhSachViTriTiepDat'] =
          this.danhSachViTriTiepDat.map((v) => v.toJson()).toList();
    }
    if (this.danhSachViTriRaoChan != null) {
      data['DanhSachViTriRaoChan'] =
          this.danhSachViTriRaoChan.map((v) => v.toJson()).toList();
    }
    if (this.danhSachPhamViDuocPhepLamViec != null) {
      data['DanhSachPhamViDuocPhepLamViec'] =
          this.danhSachPhamViDuocPhepLamViec.map((v) => v.toJson()).toList();
    }
    if (this.danhSachCanhBaoChiDan != null) {
      data['DanhSachCanhBaoChiDan'] =
          this.danhSachCanhBaoChiDan.map((v) => v.toJson()).toList();
    }
    if (this.danhSachBienPhapAnToan != null) {
      data['DanhSachBienPhapAnToan'] =
          this.danhSachBienPhapAnToan.map((v) => v.toJson()).toList();
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
  String nguoiChiHuy;
  String nguoiChoPhepTaiCho;
  String nguoiGiamSatATD;
  String nguoiChoPhep;
  int soNguoiThamGia;
  int thoiGianBatDau;
  int thoiGianKetThuc;
  String diaDiem;
  String noiDungCongTac;
  int thoiGianBatDauCongTac;
  int iDNguoiChoPhep;
  int iDNguoiChoPhepTaiCho;

  ThongTinChung(
      {this.iD,
      this.iDServiceRecord,
      this.iDChannel,
      this.code,
      this.ngayLap,
      this.nguoiLap,
      this.nguoiChiHuy,
      this.nguoiChoPhepTaiCho,
      this.nguoiGiamSatATD,
      this.nguoiChoPhep,
      this.soNguoiThamGia,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.diaDiem,
      this.noiDungCongTac,
      this.thoiGianBatDauCongTac,
      this.iDNguoiChoPhep,
      this.iDNguoiChoPhepTaiCho});

  ThongTinChung.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDServiceRecord = json['IDServiceRecord'];
    iDChannel = json['IDChannel'];
    code = json['Code'];
    ngayLap = json['NgayLap'];
    nguoiLap = json['NguoiLap'];
    nguoiChiHuy = json['NguoiChiHuy'];
    nguoiChoPhepTaiCho = json['NguoiChoPhepTaiCho'];
    nguoiGiamSatATD = json['NguoiGiamSatATD'];
    nguoiChoPhep = json['NguoiChoPhep'];
    soNguoiThamGia = json['SoNguoiThamGia'];
    thoiGianBatDau = json['ThoiGianBatDau'];
    thoiGianKetThuc = json['ThoiGianKetThuc'];
    diaDiem = json['DiaDiem'];
    noiDungCongTac = json['NoiDungCongTac'];
    thoiGianBatDauCongTac = json['ThoiGianBatDauCongTac'];
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
    data['NguoiChiHuy'] = this.nguoiChiHuy;
    data['NguoiChoPhepTaiCho'] = this.nguoiChoPhepTaiCho;
    data['NguoiGiamSatATD'] = this.nguoiGiamSatATD;
    data['NguoiChoPhep'] = this.nguoiChoPhep;
    data['SoNguoiThamGia'] = this.soNguoiThamGia;
    data['ThoiGianBatDau'] = this.thoiGianBatDau;
    data['ThoiGianKetThuc'] = this.thoiGianKetThuc;
    data['DiaDiem'] = this.diaDiem;
    data['NoiDungCongTac'] = this.noiDungCongTac;
    data['ThoiGianBatDauCongTac'] = this.thoiGianBatDauCongTac;
    data['IDNguoiChoPhep'] = this.iDNguoiChoPhep;
    data['IDNguoiChoPhepTaiCho'] = this.iDNguoiChoPhepTaiCho;
    return data;
  }
}

class DanhSachDieuKienThucHien {
  int iD;
  String thietBi;
  String dieuKien;
  String donViQLVH;

  DanhSachDieuKienThucHien(
      {this.iD, this.thietBi, this.dieuKien, this.donViQLVH});

  DanhSachDieuKienThucHien.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    thietBi = json['ThietBi'];
    dieuKien = json['DieuKien'];
    donViQLVH = json['DonViQLVH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ThietBi'] = this.thietBi;
    data['DieuKien'] = this.dieuKien;
    data['DonViQLVH'] = this.donViQLVH;
    return data;
  }
}

class DanhSachViTriTiepDat {
  int iD;
  String viTri;
  String tiepDat;
  int donViQLVH;

  DanhSachViTriTiepDat({this.iD, this.viTri, this.tiepDat, this.donViQLVH});

  DanhSachViTriTiepDat.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    viTri = json['ViTri'];
    tiepDat = json['TiepDat'];
    donViQLVH = json['DonViQLVH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ViTri'] = this.viTri;
    data['TiepDat'] = this.tiepDat;
    data['DonViQLVH'] = this.donViQLVH;
    return data;
  }
}

class DanhSachViTriRaoChan {
  int iD;
  String viTriRaoChan;
  String raoChanBienBao;

  DanhSachViTriRaoChan({this.iD, this.viTriRaoChan, this.raoChanBienBao});

  DanhSachViTriRaoChan.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    viTriRaoChan = json['ViTriRaoChan'];
    raoChanBienBao = json['RaoChanBienBao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ViTriRaoChan'] = this.viTriRaoChan;
    data['RaoChanBienBao'] = this.raoChanBienBao;
    return data;
  }
}

class DanhSachPhamViDuocPhepLamViec {
  int iD;
  String viTri;
  String phamViDuocPhepLamViec;

  DanhSachPhamViDuocPhepLamViec(
      {this.iD, this.viTri, this.phamViDuocPhepLamViec});

  DanhSachPhamViDuocPhepLamViec.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    viTri = json['ViTri'];
    phamViDuocPhepLamViec = json['PhamViDuocPhepLamViec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ViTri'] = this.viTri;
    data['PhamViDuocPhepLamViec'] = this.phamViDuocPhepLamViec;
    return data;
  }
}

class DanhSachCanhBaoChiDan {
  int iD;
  String canhBaoChiDan;
  String chiDanBienPhapAnToan;

  DanhSachCanhBaoChiDan(
      {this.iD, this.canhBaoChiDan, this.chiDanBienPhapAnToan});

  DanhSachCanhBaoChiDan.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    canhBaoChiDan = json['CanhBaoChiDan'];
    chiDanBienPhapAnToan = json['ChiDanBienPhapAnToan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CanhBaoChiDan'] = this.canhBaoChiDan;
    data['ChiDanBienPhapAnToan'] = this.chiDanBienPhapAnToan;
    return data;
  }
}

class DanhSachBienPhapAnToan {
  int iD;
  String viTri;
  String chiDanBienPhapAnToan;

  DanhSachBienPhapAnToan({this.iD, this.viTri, this.chiDanBienPhapAnToan});

  DanhSachBienPhapAnToan.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    viTri = json['ViTri'];
    chiDanBienPhapAnToan = json['ChiDanBienPhapAnToan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ViTri'] = this.viTri;
    data['ChiDanBienPhapAnToan'] = this.chiDanBienPhapAnToan;
    return data;
  }
}

class DanhSachNhanVien {
  int iDThamGia;
  int ngay;
  String hoVaTen;
  int bacAnToanDien;
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
        this.bacAnToanDien,
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
    bacAnToanDien = json['BacAnToanDien'];
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
    data['BacAnToanDien'] = this.bacAnToanDien;
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