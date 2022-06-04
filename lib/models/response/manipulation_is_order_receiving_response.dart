import 'package:workflow_manager/base/models/base_response.dart';

class ManipulationSheetIsOrderReceivingResponse extends BaseResponse {
  Data data;

  ManipulationSheetIsOrderReceivingResponse.fromJson(Map<String, dynamic> json)
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
  List<DanhSachKetQuaThucHien> danhSachKetQuaThucHien;

  Data({this.code, this.danhSachKetQuaThucHien});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['DanhSachKetQuaThucHien'] != null) {
      danhSachKetQuaThucHien = new List<DanhSachKetQuaThucHien>();
      json['DanhSachKetQuaThucHien'].forEach((v) {
        danhSachKetQuaThucHien.add(new DanhSachKetQuaThucHien.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.danhSachKetQuaThucHien != null) {
      data['DanhSachKetQuaThucHien'] =
          this.danhSachKetQuaThucHien.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DanhSachKetQuaThucHien {
  String text;
  String value;

  DanhSachKetQuaThucHien({this.text, this.value});

  DanhSachKetQuaThucHien.fromJson(Map<String, dynamic> json) {
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
