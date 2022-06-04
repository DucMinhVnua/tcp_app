import 'package:workflow_manager/base/models/base_response.dart';
import 'package:workflow_manager/models/response/check_in_response.dart';

class IsCheckOutResponse extends BaseResponse {
  Data data;

  IsCheckOutResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
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
  List<LoaiRutKhois> loaiRutKhois;
  List<DanhSachChuKy> danhSachChuKy;

  Data({this.code, this.loaiRutKhois, this.danhSachChuKy});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['LoaiRutKhois'] != null) {
      loaiRutKhois = new List<LoaiRutKhois>();
      json['LoaiRutKhois'].forEach((v) {
        loaiRutKhois.add(new LoaiRutKhois.fromJson(v));
      });
    }
    if (json['DanhSachChuKy'] != null) {
      danhSachChuKy = new List<DanhSachChuKy>();
      json['DanhSachChuKy'].forEach((v) {
        danhSachChuKy.add(new DanhSachChuKy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.loaiRutKhois != null) {
      data['LoaiRutKhois'] = this.loaiRutKhois.map((v) => v.toJson()).toList();
    }
    if (this.danhSachChuKy != null) {
      data['DanhSachChuKy'] =
          this.danhSachChuKy.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoaiRutKhois {
  String text;
  String value;

  LoaiRutKhois({this.text, this.value});

  LoaiRutKhois.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.text;
    data['Value'] = this.value;
    return data;
  }
}