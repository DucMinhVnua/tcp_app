import 'package:workflow_manager/base/models/base_response.dart';

class SignProcessResponse extends BaseResponse {
  Data data;

  SignProcessResponse.fromJson(Map<String, dynamic> json)
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
  String linkFileTrinhKy;

  Data({this.code, this.linkFileTrinhKy});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    linkFileTrinhKy = json['LinkFileTrinhKy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['LinkFileTrinhKy'] = this.linkFileTrinhKy;
    return data;
  }
}
