import 'package:workflow_manager/base/models/base_response.dart';

class ManipulationSheetDetailResponse extends BaseResponse {
  ManipulationSheetDetail data;

  ManipulationSheetDetailResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data = json['Data'] != null
        ? new ManipulationSheetDetail.fromJson(json['Data'])
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

class ManipulationSheetDetail {
  int code;
  ThongTinChung thongTinChung;
  List<DanhSachNghiemThuDuongDay> danhSachNghiemThuDuongDay;
  bool isCapNhapTrinhTu;
  List<DanhSachTrinhTuThaoTac> danhSachTrinhTuThaoTac;
  bool isCapNhatSuKienBatThuong;
  String suKienBatThuong;

  ManipulationSheetDetail(
      {this.code,
      this.thongTinChung,
      this.danhSachNghiemThuDuongDay,
      this.isCapNhapTrinhTu,
      this.danhSachTrinhTuThaoTac,
      this.isCapNhatSuKienBatThuong,
      this.suKienBatThuong});

  ManipulationSheetDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    thongTinChung = json['ThongTinChung'] != null
        ? new ThongTinChung.fromJson(json['ThongTinChung'])
        : null;
    if (json['DanhSachNghiemThuDuongDay'] != null) {
      danhSachNghiemThuDuongDay = new List<DanhSachNghiemThuDuongDay>();
      json['DanhSachNghiemThuDuongDay'].forEach((v) {
        danhSachNghiemThuDuongDay
            .add(new DanhSachNghiemThuDuongDay.fromJson(v));
      });
    }
    isCapNhapTrinhTu = json['IsCapNhapTrinhTu'];
    if (json['DanhSachTrinhTuThaoTac'] != null) {
      danhSachTrinhTuThaoTac = new List<DanhSachTrinhTuThaoTac>();
      json['DanhSachTrinhTuThaoTac'].forEach((v) {
        danhSachTrinhTuThaoTac.add(new DanhSachTrinhTuThaoTac.fromJson(v));
      });
    }
    isCapNhatSuKienBatThuong = json['IsCapNhatSuKienBatThuong'];
    suKienBatThuong = json['SuKienBatThuong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.thongTinChung != null) {
      data['ThongTinChung'] = this.thongTinChung.toJson();
    }
    if (this.danhSachNghiemThuDuongDay != null) {
      data['DanhSachNghiemThuDuongDay'] =
          this.danhSachNghiemThuDuongDay.map((v) => v.toJson()).toList();
    }
    data['IsCapNhapTrinhTu'] = this.isCapNhapTrinhTu;
    if (this.danhSachTrinhTuThaoTac != null) {
      data['DanhSachTrinhTuThaoTac'] =
          this.danhSachTrinhTuThaoTac.map((v) => v.toJson()).toList();
    }
    data['IsCapNhatSuKienBatThuong'] = this.isCapNhatSuKienBatThuong;
    data['SuKienBatThuong'] = this.suKienBatThuong;
    return data;
  }
}

class ThongTinChung {
  int iD;
  int iDServiceRecord;
  int iDChannel;
  String code;
  String tenPhieu;
  String nguoiVietPhieu;
  String chucVuNguoiVietPhieu;
  String nguoiDuyetPhieu;
  String chucVuNguoiDuyetPhieu;
  String nguoiGiamSat;
  String chucVuNguoiGiamSat;
  String nguoiThaoTac;
  String chucVuNguoiThaoTac;
  String mucDichThaoTac;
  int thoiGianDuKienBatDau;
  int thoiGianDuKienKetThuc;
  String donViDeNghiThaoTac;
  String dieuKienCanDeThucHien;
  String luuY;
  bool isCoNhietHoa;
  bool isThuy;
  bool isCo;
  bool isNhiet;
  bool isHoa;

  ThongTinChung(
      {this.iD,
        this.iDServiceRecord,
        this.iDChannel,
        this.code,
        this.tenPhieu,
        this.nguoiVietPhieu,
        this.chucVuNguoiVietPhieu,
        this.nguoiDuyetPhieu,
        this.chucVuNguoiDuyetPhieu,
        this.nguoiGiamSat,
        this.chucVuNguoiGiamSat,
        this.nguoiThaoTac,
        this.chucVuNguoiThaoTac,
        this.mucDichThaoTac,
        this.thoiGianDuKienBatDau,
        this.thoiGianDuKienKetThuc,
        this.donViDeNghiThaoTac,
        this.dieuKienCanDeThucHien,
        this.luuY,
        this.isCoNhietHoa,
        this.isThuy,
        this.isCo,
        this.isNhiet,
        this.isHoa});

  ThongTinChung.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDServiceRecord = json['IDServiceRecord'];
    iDChannel = json['IDChannel'];
    code = json['Code'];
    tenPhieu = json['TenPhieu'];
    nguoiVietPhieu = json['NguoiVietPhieu'];
    chucVuNguoiVietPhieu = json['ChucVuNguoiVietPhieu'];
    nguoiDuyetPhieu = json['NguoiDuyetPhieu'];
    chucVuNguoiDuyetPhieu = json['ChucVuNguoiDuyetPhieu'];
    nguoiGiamSat = json['NguoiGiamSat'];
    chucVuNguoiGiamSat = json['ChucVuNguoiGiamSat'];
    nguoiThaoTac = json['NguoiThaoTac'];
    chucVuNguoiThaoTac = json['ChucVuNguoiThaoTac'];
    mucDichThaoTac = json['MucDichThaoTac'];
    thoiGianDuKienBatDau = json['ThoiGianDuKienBatDau'];
    thoiGianDuKienKetThuc = json['ThoiGianDuKienKetThuc'];
    donViDeNghiThaoTac = json['DonViDeNghiThaoTac'];
    dieuKienCanDeThucHien = json['DieuKienCanDeThucHien'];
    luuY = json['LuuY'];
    isCoNhietHoa = json['IsCoNhietHoa'];
    isThuy = json['IsThuy'];
    isCo = json['IsCo'];
    isNhiet = json['IsNhiet'];
    isHoa = json['IsHoa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['IDServiceRecord'] = this.iDServiceRecord;
    data['IDChannel'] = this.iDChannel;
    data['Code'] = this.code;
    data['TenPhieu'] = this.tenPhieu;
    data['NguoiVietPhieu'] = this.nguoiVietPhieu;
    data['ChucVuNguoiVietPhieu'] = this.chucVuNguoiVietPhieu;
    data['NguoiDuyetPhieu'] = this.nguoiDuyetPhieu;
    data['ChucVuNguoiDuyetPhieu'] = this.chucVuNguoiDuyetPhieu;
    data['NguoiGiamSat'] = this.nguoiGiamSat;
    data['ChucVuNguoiGiamSat'] = this.chucVuNguoiGiamSat;
    data['NguoiThaoTac'] = this.nguoiThaoTac;
    data['ChucVuNguoiThaoTac'] = this.chucVuNguoiThaoTac;
    data['MucDichThaoTac'] = this.mucDichThaoTac;
    data['ThoiGianDuKienBatDau'] = this.thoiGianDuKienBatDau;
    data['ThoiGianDuKienKetThuc'] = this.thoiGianDuKienKetThuc;
    data['DonViDeNghiThaoTac'] = this.donViDeNghiThaoTac;
    data['DieuKienCanDeThucHien'] = this.dieuKienCanDeThucHien;
    data['LuuY'] = this.luuY;
    data['IsCoNhietHoa'] = this.isCoNhietHoa;
    data['IsThuy'] = this.isThuy;
    data['IsCo'] = this.isCo;
    data['IsNhiet'] = this.isNhiet;
    data['IsHoa'] = this.isHoa;
    return data;
  }
}

class DanhSachNghiemThuDuongDay {
  int iD;
  int thoiGian;
  String donVi;
  String hoTen;
  String noiDung;

  DanhSachNghiemThuDuongDay(
      {this.iD, this.thoiGian, this.donVi, this.hoTen, this.noiDung});

  DanhSachNghiemThuDuongDay.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    thoiGian = json['ThoiGian'];
    donVi = json['DonVi'];
    hoTen = json['HoTen'];
    noiDung = json['NoiDung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ThoiGian'] = this.thoiGian;
    data['DonVi'] = this.donVi;
    data['HoTen'] = this.hoTen;
    data['NoiDung'] = this.noiDung;
    return data;
  }
}

class DanhSachTrinhTuThaoTac {
  int iD;
  String muc;
  String diaDiem;
  String buoc;
  String noiDung;
  String daThucHien;
  int batDau;
  int ketThuc;
  String raLenh;
  String nhanLenh;
  bool isRaLenh;
  bool isNhanLenh;

  DanhSachTrinhTuThaoTac(
      {this.iD,
        this.muc,
        this.diaDiem,
        this.buoc,
        this.noiDung,
        this.daThucHien,
        this.batDau,
        this.ketThuc,
        this.raLenh,
        this.nhanLenh,
        this.isRaLenh,
        this.isNhanLenh});

  DanhSachTrinhTuThaoTac.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    muc = json['Muc'];
    diaDiem = json['DiaDiem'];
    buoc = json['Buoc'];
    noiDung = json['NoiDung'];
    daThucHien = json['DaThucHien'];
    batDau = json['BatDau'];
    ketThuc = json['KetThuc'];
    raLenh = json['RaLenh'];
    nhanLenh = json['NhanLenh'];
    isRaLenh = json['IsRaLenh'];
    isNhanLenh = json['IsNhanLenh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Muc'] = this.muc;
    data['DiaDiem'] = this.diaDiem;
    data['Buoc'] = this.buoc;
    data['NoiDung'] = this.noiDung;
    data['DaThucHien'] = this.daThucHien;
    data['BatDau'] = this.batDau;
    data['KetThuc'] = this.ketThuc;
    data['RaLenh'] = this.raLenh;
    data['NhanLenh'] = this.nhanLenh;
    data['IsRaLenh'] = this.isRaLenh;
    data['IsNhanLenh'] = this.isNhanLenh;
    return data;
  }
}
