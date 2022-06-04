import 'package:workflow_manager/base/models/base_response.dart';

class PairResponse extends BaseResponse {
  int status;
  List<Pair> data;

  PairResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = new List<Pair>();
      json['Data'].forEach((v) {
        data.add(new Pair.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['Messages'] = this.messages;
    return data;
  }
}

class Pair {
  int key;
  String value;
  int selectType;
  bool isSelected;

  Pair({this.key, this.value, this.selectType, this.isSelected = false});

  Pair.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    value = json['Value'];
    selectType = json['searchType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.key;
    data['Value'] = this.value;
    data['searchType'] = this.selectType;
    return data;
  }
}
