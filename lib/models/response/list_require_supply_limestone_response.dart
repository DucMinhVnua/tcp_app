import 'package:workflow_manager/base/models/base_response.dart';

class ListRequireSupplyLimestoneResponse extends BaseResponse {
  ListRequireSupplyLimestone data;


  ListRequireSupplyLimestoneResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['Data'] != null ? new ListRequireSupplyLimestone.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class ListRequireSupplyLimestone {
  int code;
  List<DanhSachPhieuYeuCauCapDaVoi> danhSachPhieuYeuCauCapDaVoi;

  ListRequireSupplyLimestone({this.code, this.danhSachPhieuYeuCauCapDaVoi});

  ListRequireSupplyLimestone.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['DanhSachPhieuYeuCauCapDaVoi'] != null) {
      danhSachPhieuYeuCauCapDaVoi = new List<DanhSachPhieuYeuCauCapDaVoi>();
      json['DanhSachPhieuYeuCauCapDaVoi'].forEach((v) {
        danhSachPhieuYeuCauCapDaVoi
            .add(new DanhSachPhieuYeuCauCapDaVoi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.danhSachPhieuYeuCauCapDaVoi != null) {
      data['DanhSachPhieuYeuCauCapDaVoi'] =
          this.danhSachPhieuYeuCauCapDaVoi.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DanhSachPhieuYeuCauCapDaVoi {
  String text;
  int value;

  DanhSachPhieuYeuCauCapDaVoi({this.text, this.value});

  DanhSachPhieuYeuCauCapDaVoi.fromJson(Map<String, dynamic> json) {
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