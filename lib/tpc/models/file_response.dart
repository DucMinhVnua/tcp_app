import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/base/models/base_response.dart';

class FileResponse extends BaseResponse {
  List<FileModel> data;

  FileResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    status = json['Status'];
    if (isNotNullOrEmpty(json['Data'])) {
      data = new List<FileModel>();
      json['Data'].forEach((v) {
        data.add(new FileModel.fromJson(v));
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

class FileModel {
  int iD;
  int iDChannel;
  int iDJob;
  String name;
  String created;
  int createdBy;
  String path;
  bool canDelete;

  FileModel(
      {this.iD,
      this.iDChannel,
      this.iDJob,
      this.name,
      this.created,
      this.createdBy,
      this.path,
      this.canDelete});

  FileModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDChannel = json['IDChannel'];
    iDJob = json['IDJob'];
    name = json['Name'];
    created = json['Created'];
    createdBy = json['CreatedBy'];
    path = json['Path'];
    canDelete = json['CanDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['IDChannel'] = this.iDChannel;
    data['IDJob'] = this.iDJob;
    data['Name'] = this.name;
    data['Created'] = this.created;
    data['CreatedBy'] = this.createdBy;
    data['Path'] = this.path;
    return data;
  }
}
