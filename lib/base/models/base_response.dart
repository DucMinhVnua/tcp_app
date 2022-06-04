import 'package:workflow_manager/base/ui/toast_view.dart';

import '../utils/common_function.dart';

class BaseResponse {
  int status;

  String messages = "Đã xảy ra lỗi khi lấy dữ liệu";

  int errorCode;
  bool isDefaultMesasge;
  int messageCode;

  bool isSuccess(
      {bool isDontShowErrorMessage = false,
      bool isShowSuccessMessage = false}) {
    if (status != 1 && !isDontShowErrorMessage) {
      showErrorToast(messages);
    }
    if (status == 1 && isShowSuccessMessage)
      showSuccessToast(isNotNullOrEmpty(messages) ? messages : "Thành công");
    return status == 1;
  }

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    messages = getResponseMessage(json);
    errorCode = getResponseCode(json);
    isDefaultMesasge = true;
    if (isNotNullOrEmpty(json['Messages'])) {
      if (json['Messages'] is String) {
        messages = json['Messages'];
        isDefaultMesasge = false;
      } else if (json['Messages'] is List<String>) {
        messages = json['Messages'][0];
        isDefaultMesasge = false;
      } else {
        isDefaultMesasge = false;
        messages = json['Messages'][0]['text'];
        messageCode = json['Messages'][0]['code'];
      }
    }
  }
}

String getResponseMessage(Map<String, dynamic> json) {
  String messages = json["Status"] == 1
      ? "Lấy dữ liệu thành công."
      : "Đã xảy ra lỗi khi lấy dữ liệu.";
  if (isNotNullOrEmpty(json['Messages'])) {
    if (json['Messages'] is String) {
      messages = json['Messages'];
    } else if (json['Messages'] is List<String>) {
      messages = json['Messages'][0];
    } else
      messages = json['Messages'][0]['text'];
  }
  return messages;
}

int getResponseCode(Map<String, dynamic> json) {
  if (isNotNullOrEmpty(json['Messages']) &&
      json['Messages'] is List &&
      json['Messages'][0]['code'] != null) {
    return json['Messages'][0]['code'];
  }
  return null;
}
