import 'package:workflow_manager/base/models/base_response.dart';

/// Status : 1
/// Data : {"code":1001,"text":"Bổ sung trình tự công việc thành công"}
/// Messages : []

class StatusResponse extends BaseResponse {
  Status data;

  StatusResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['Data'] != null ? new Status.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

///eg
/// code : 1001
/// text : "Bổ sung trình tự công việc thành công"

class Status {
  Status({
    int code,
    String text,
  }) {
    _code = code;
    _text = text;
  }

  Status.fromJson(dynamic json) {
    _code = json['code'];
    _text = json['text'];
  }

  int _code;
  String _text;

  int get code => _code;

  String get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['text'] = _text;
    return map;
  }
}
