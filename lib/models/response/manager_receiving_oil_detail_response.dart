import 'package:workflow_manager/base/models/base_response.dart';

class ManagerReceivingOilDetailResponse extends BaseResponse {
  ManagerReceivingOilDetail data;

  ManagerReceivingOilDetailResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data = json['Data'] != null
        ? new ManagerReceivingOilDetail.fromJson(json['Data'])
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

enum StatusRequire { inProgress, finished }

class ManagerReceivingOilDetail {
  int code;
  ThongTinChung thongTinChung;
  List<PhongBanNhanThongBao> phongBanNhanThongBao;
  List<GuiYeuCauTiepNhanTruocVaTrong> guiYeuCauTiepNhanTruocVaTrong;
  List<GuiYeuCauTiepNhanSau> guiYeuCauTiepNhanSau;
  bool isThemYeuCau;
  bool isHoanThanh;
  TrangThaiTiepNhanHoSoDau trangThaiTiepNhanHoSoDau;

  ManagerReceivingOilDetail(
      {this.code,
      this.thongTinChung,
      this.phongBanNhanThongBao,
      this.guiYeuCauTiepNhanTruocVaTrong,
      this.guiYeuCauTiepNhanSau,
      this.isThemYeuCau,
      this.isHoanThanh,
      this.trangThaiTiepNhanHoSoDau});

  ManagerReceivingOilDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    thongTinChung = json['ThongTinChung'] != null
        ? new ThongTinChung.fromJson(json['ThongTinChung'])
        : null;
    if (json['PhongBanNhanThongBao'] != null) {
      phongBanNhanThongBao = new List<PhongBanNhanThongBao>();
      json['PhongBanNhanThongBao'].forEach((v) {
        phongBanNhanThongBao.add(new PhongBanNhanThongBao.fromJson(v));
      });
    }
    if (json['GuiYeuCauTiepNhanTruocVaTrong'] != null) {
      guiYeuCauTiepNhanTruocVaTrong = new List<GuiYeuCauTiepNhanTruocVaTrong>();
      json['GuiYeuCauTiepNhanTruocVaTrong'].forEach((v) {
        guiYeuCauTiepNhanTruocVaTrong
            .add(new GuiYeuCauTiepNhanTruocVaTrong.fromJson(v));
      });
    }
    if (json['GuiYeuCauTiepNhanSau'] != null) {
      guiYeuCauTiepNhanSau = new List<GuiYeuCauTiepNhanSau>();
      json['GuiYeuCauTiepNhanSau'].forEach((v) {
        guiYeuCauTiepNhanSau.add(new GuiYeuCauTiepNhanSau.fromJson(v));
      });
    }
    isThemYeuCau = json['IsThemYeuCau'];
    isHoanThanh = json['IsHoanThanh'];
    trangThaiTiepNhanHoSoDau = json['TrangThaiTiepNhanHoSoDau'] != null
        ? new TrangThaiTiepNhanHoSoDau.fromJson(
            json['TrangThaiTiepNhanHoSoDau'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.thongTinChung != null) {
      data['ThongTinChung'] = this.thongTinChung.toJson();
    }
    if (this.phongBanNhanThongBao != null) {
      data['PhongBanNhanThongBao'] =
          this.phongBanNhanThongBao.map((v) => v.toJson()).toList();
    }
    if (this.guiYeuCauTiepNhanTruocVaTrong != null) {
      data['GuiYeuCauTiepNhanTruocVaTrong'] =
          this.guiYeuCauTiepNhanTruocVaTrong.map((v) => v.toJson()).toList();
    }
    if (this.guiYeuCauTiepNhanSau != null) {
      data['GuiYeuCauTiepNhanSau'] =
          this.guiYeuCauTiepNhanSau.map((v) => v.toJson()).toList();
    }
    data['IsThemYeuCau'] = this.isThemYeuCau;
    data['IsHoanThanh'] = this.isHoanThanh;
    if (this.trangThaiTiepNhanHoSoDau != null) {
      data['TrangThaiTiepNhanHoSoDau'] = this.trangThaiTiepNhanHoSoDau.toJson();
    }
    return data;
  }
}

class ThongTinChung {
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
  int typeNameHinhThucVanChuyen;
  String soHopDong;
  int ngayHopDong;
  String loaiDau;
  String diaDiemGiaoHang;
  int hoanThanhQuyTrinh;
  int createdBy;
  int updatedBy;
  int created;
  int updated;
  List<DanhSachFile> danhSachFile;

  ThongTinChung(
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
      this.updated,
      this.danhSachFile});

  ThongTinChung.fromJson(Map<String, dynamic> json) {
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
    if (json['DanhSachFile'] != null) {
      danhSachFile = new List<DanhSachFile>();
      json['DanhSachFile'].forEach((v) {
        danhSachFile.add(new DanhSachFile.fromJson(v));
      });
    }
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
    if (this.danhSachFile != null) {
      data['DanhSachFile'] = this.danhSachFile.map((v) => v.toJson()).toList();
    }
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

class DanhSachFile {
  String fileName;
  String linkDownLoad;

  DanhSachFile({this.fileName, this.linkDownLoad});

  DanhSachFile.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
    linkDownLoad = json['LinkDownLoad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['LinkDownLoad'] = this.linkDownLoad;
    return data;
  }
}

class PhongBanNhanThongBao {
  String name;

  PhongBanNhanThongBao({this.name});

  PhongBanNhanThongBao.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    return data;
  }
}

class GuiYeuCauTiepNhanTruocVaTrong {
  String noiDungThongBao;
  String linkChiTiet;
  String thoiGianYeuCau;
  String nguoiGui;
  String trangThai;
  List<DanhSachFile> danhSachFile;

  GuiYeuCauTiepNhanTruocVaTrong(
      {this.noiDungThongBao,
        this.linkChiTiet,
        this.thoiGianYeuCau,
        this.nguoiGui,
        this.trangThai,
        this.danhSachFile});

  GuiYeuCauTiepNhanTruocVaTrong.fromJson(Map<String, dynamic> json) {
    noiDungThongBao = json['NoiDungThongBao'];
    linkChiTiet = json['LinkChiTiet'];
    thoiGianYeuCau = json['ThoiGianYeuCau'];
    nguoiGui = json['NguoiGui'];
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
    data['NoiDungThongBao'] = this.noiDungThongBao;
    data['LinkChiTiet'] = this.linkChiTiet;
    data['ThoiGianYeuCau'] = this.thoiGianYeuCau;
    data['NguoiGui'] = this.nguoiGui;
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

class GuiYeuCauTiepNhanSau {
  String noiDungThongBao;
  String linkChiTiet;
  String thoiGianYeuCau;
  String nguoiGui;
  String trangThai;
  List<DanhSachFile> danhSachFile;

  GuiYeuCauTiepNhanSau(
      {this.noiDungThongBao,
        this.linkChiTiet,
        this.thoiGianYeuCau,
        this.nguoiGui,
        this.trangThai,
        this.danhSachFile});

  GuiYeuCauTiepNhanSau.fromJson(Map<String, dynamic> json) {
    noiDungThongBao = json['NoiDungThongBao'];
    linkChiTiet = json['LinkChiTiet'];
    thoiGianYeuCau = json['ThoiGianYeuCau'];
    nguoiGui = json['NguoiGui'];
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
    data['NoiDungThongBao'] = this.noiDungThongBao;
    data['LinkChiTiet'] = this.linkChiTiet;
    data['ThoiGianYeuCau'] = this.thoiGianYeuCau;
    data['NguoiGui'] = this.nguoiGui;
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

class TrangThaiTiepNhanHoSoDau {
  String s1;
  String s2;
  String s3;

  TrangThaiTiepNhanHoSoDau({this.s1, this.s2, this.s3});

  TrangThaiTiepNhanHoSoDau.fromJson(Map<String, dynamic> json) {
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