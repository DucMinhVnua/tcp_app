import 'package:workflow_manager/base/extension/string.dart';

class LoginRequest {
  String userName;

  String password;
  bool isCloudApi;

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    if (userName.isNotNullOrEmpty) {
      params["Username"] = userName;
    }
    if (password.isNotNullOrEmpty) {
      params["Password"] = password;
    }
    params["IsCloudAPI"] = isCloudApi ? 1 : 0;
    return params;
  }
}
