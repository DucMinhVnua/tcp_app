import 'package:workflow_manager/base/models/base_response.dart';

class IsCheckInResponse extends BaseResponse {
  Data data;

  IsCheckInResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int code;
  List<DanhSachChuKy> danhSachChuKy;
  String trinhTuCongTacNCPTC;

  Data({
    this.code,
    this.danhSachChuKy,
    this.trinhTuCongTacNCPTC,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    code: json["code"] == null ? null : json["code"],
    danhSachChuKy: json["DanhSachChuKy"] == null ? null : List<DanhSachChuKy>.from(json["DanhSachChuKy"].map((x) => DanhSachChuKy.fromJson(x))),
    trinhTuCongTacNCPTC: json["TrinhTuCongTacNCPTC"] == null ? null : json["TrinhTuCongTacNCPTC"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "DanhSachChuKy": danhSachChuKy == null ? null : List<dynamic>.from(danhSachChuKy.map((x) => x.toJson())),
    "TrinhTuCongTacNCPTC": trinhTuCongTacNCPTC == null ? null : trinhTuCongTacNCPTC,
  };
}

class DanhSachChuKy {
  int iD;
  String ten;
  String duongDan;

  DanhSachChuKy({this.iD, this.ten, this.duongDan});

  DanhSachChuKy.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    ten = json['Ten'];
    duongDan = json['DuongDan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Ten'] = this.ten;
    data['DuongDan'] = this.duongDan;
    return data;
  }
}
