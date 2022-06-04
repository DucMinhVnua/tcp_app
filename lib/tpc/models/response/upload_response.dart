import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/base/extension/string.dart';

class UploadResponse {
  UploadModel data;
  String messages;
  int status;

  UploadResponse({this.data, this.messages, this.status});

  UploadResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new UploadModel.fromJson(json['Data']) : null;
    if (isNotNullOrEmpty(json['Messages'])) {
      var v = json['Messages'];
      if (v is List<dynamic>) {
        messages = v[0].toString();
      } else {
        messages = (v as List<Map<String, dynamic>>)[0]["text"];
      }
    }
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    if (this.messages != null) {
      data['Messages'] = this.messages;
    }
    data['Status'] = this.status;
    return data;
  }
}

class UploadModel {
  String fileName;
  int status;
  int contentLength;
  int uploaded;
  String filePath;
  String filePathRoot;
  String contentType;
  UploadStatus uploadStatus = UploadStatus.cancel;

  UploadModel(
      {this.fileName,
      this.status,
      this.contentLength,
      this.uploaded,
      this.filePath,
      this.filePathRoot,
      this.contentType,
      this.uploadStatus});

  UploadModel.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
    status = json['Status'];
    contentLength = json['ContentLength'];
    uploaded = json['Uploaded'];
    filePath = json['FilePath'];
    contentType = json['ContentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['Status'] = this.status;
    data['ContentLength'] = this.contentLength;
    data['Uploaded'] = this.uploaded;
    data['FilePath'] = this.filePath;
    data['ContentType'] = this.contentType;
    return data;
  }
}

enum UploadStatus { cancel, upload_success, upload_failure, file_name_existed }
