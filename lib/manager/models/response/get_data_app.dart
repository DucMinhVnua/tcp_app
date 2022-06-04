import 'package:workflow_manager/base/models/base_response.dart';

class DataAppResponse extends BaseResponse {
  String data;

  DataAppResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.data != null) {
      data['Data'] = this.data;
    }
    if (this.messages != null) {
      data['Messages'] = this.messages;
    }
    return data;
  }
}