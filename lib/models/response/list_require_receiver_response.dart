import 'package:workflow_manager/base/models/base_response.dart';

class ListRequireReceiverResponse extends BaseResponse {
  ListRequireReceiver data;

  ListRequireReceiverResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['Data'] != null ? new ListRequireReceiver.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class ListRequireReceiver {
  int code;
  List<DanhSachNguoiTiepNhanYeuCau> danhSachNguoiTiepNhanYeuCau;

  ListRequireReceiver({this.code, this.danhSachNguoiTiepNhanYeuCau});

  ListRequireReceiver.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['DanhSachNguoiTiepNhanYeuCau'] != null) {
      danhSachNguoiTiepNhanYeuCau = new List<DanhSachNguoiTiepNhanYeuCau>();
      json['DanhSachNguoiTiepNhanYeuCau'].forEach((v) {
        danhSachNguoiTiepNhanYeuCau
            .add(new DanhSachNguoiTiepNhanYeuCau.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.danhSachNguoiTiepNhanYeuCau != null) {
      data['DanhSachNguoiTiepNhanYeuCau'] =
          this.danhSachNguoiTiepNhanYeuCau.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DanhSachNguoiTiepNhanYeuCau {
  String text;
  int value;

  DanhSachNguoiTiepNhanYeuCau({this.text, this.value});

  DanhSachNguoiTiepNhanYeuCau.fromJson(Map<String, dynamic> json) {
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