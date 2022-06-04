import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_auth/local_auth.dart';
import 'package:workflow_manager/app_init.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/network/api_caller.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/base/utils/app_store.dart';
import 'package:workflow_manager/base/utils/base_sharepreference.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/manager/models/response/get_data_app.dart';
import 'package:workflow_manager/manager/models/response/update_profile_response.dart';
import 'package:workflow_manager/models/request/login_request.dart';
import 'package:workflow_manager/models/response/login_response.dart';

import '../base/network/api_caller.dart';

enum CurrentStatus {
  Uninitialized,
  Unauthenticated,
  Authenticating,
  Authenticated
}

class AuthRepository extends ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;

  CurrentStatus loggedInStatus = CurrentStatus.Uninitialized;

  List<DocTypes> docTypes;

  String message;

  static final _localAuth = LocalAuthentication();

  Future<void> validateToken() async {
    String token = await SharedPreferencesClass.getToken();
    if (token.isNotNullOrEmpty) {
      loggedInStatus = CurrentStatus.Authenticated;
      notifyListeners();
    } else {
      loggedInStatus = CurrentStatus.Unauthenticated;
      notifyListeners();
    }
  }

  Future<void> autoNextToLoginScreen() async {
    var duration = new Duration(seconds: 0);
    Future.delayed(duration, () {
      loggedInStatus = CurrentStatus.Unauthenticated;
      AppStore.isLogoutState = false;
      notifyListeners();
    });
  }

  // Đăng nhập
  Future<Map<String, dynamic>> login(
      BuildContext context, String userName, String password) async {
    SharedPreferencesClass.removeRemoteUrl();
    var result;
    LoginRequest loginRequest = LoginRequest();
    loginRequest.userName = userName;
    loginRequest.password = password;
    loginRequest.isCloudApi =
        await SharedPreferencesClass.get(SharedPreferencesClass.IS_CLOUD_API) ??
            false;
    loggedInStatus = CurrentStatus.Authenticating;
    notifyListeners();
    final response =
        await _apiService.postFormData(AppUrl.login, loginRequest.getParams());
    final LoginResponse authResponse = LoginResponse.fromJson(response);
    if (authResponse.isSuccess()) {
      // userName và passWord dùng ch≈≈o module 'kho dữ liệu' không đươc xóa
      await SharedPreferencesClass.saveValue(
          SharedPreferencesClass.USER_NAME, userName);
      await SharedPreferencesClass.saveValue(
          SharedPreferencesClass.PASS_WORD, password);

      await SharedPreferencesClass.saveToken(
          authResponse.data.token); //token dùng  call api
      await SharedPreferencesClass.saveUser(
          authResponse.data.user); //thông tin user đang đăng nhập
      await SharedPreferencesClass.save(SharedPreferencesClass.ROOT_KEY,
          authResponse.data.configDocPro.root); //link dùng up/down file
      _saveLoginData(userName, password);
      loggedInStatus = CurrentStatus.Authenticated;
      AppStore.isLogoutState = false;
      if (isNotNullOrEmpty(authResponse.data.linkApi)) {
        //link dùng call api
        String remoteBaseUrl = "${authResponse.data.linkApi}/api/";
        SharedPreferencesClass.save(
            SharedPreferencesClass.BASE_URL_REMOTE, remoteBaseUrl);
      }
      notifyListeners();
    } else {
      loggedInStatus = CurrentStatus.Unauthenticated;
      notifyListeners();
    }
    return result;
  }

  static Future<void> saveOldPlayerID() async {
    String playerId = await SharedPreferencesClass.getValue(
        SharedPreferencesClass.ONESIGNAL_ID_KEY);
    String token = await SharedPreferencesClass.getToken();
    String baseUrl = await SharedPreferencesClass.get(
        SharedPreferencesClass.BASE_URL_REMOTE);
    if (playerId != null && token != null)
      await SharedPreferencesClass.save(
          SharedPreferencesClass.SAVE_PLAYER_ID_TO_UNREGISTER,
          "$baseUrl\n$playerId\n$token");
  }

  // Đăng xuất
  Future<void> logout({bool isTokenExpired: false}) async {
    await FlutterLocalNotificationsPlugin().cancelAll();
    FlutterAppBadger.removeBadge();
    await SharedPreferencesClass.save(
        SharedPreferencesClass.UNREADNOTIFICATION, 0);
    AppStore.isLogoutState = true;
    platform.invokeMethod(Constant.LOGOUT_EVENT_KEY);
    // ngắt kết nối socket
    SharedPreferencesClass.saveValue(
        SharedPreferencesClass.PASSWORD_SIGNAL, "");
    loadingDialog.clear();
    // Navigator.pushNamedAndRemoveUntil(
    //     mainGlobalKey.currentContext, '/', (_) => false,
    //     arguments: CurrentStatus.Unauthenticated);
    loggedInStatus = CurrentStatus.Unauthenticated;
    notifyListeners();
  }

  // gửi event để lưu trong Provider và Keychain
  _saveLoginData(String userName, String password) async {
    User user = await SharedPreferencesClass.getUser();
    var params = Map<String, dynamic>();
    params["userId"] = user.iDUserDocPro;
    params["name"] = userName;
    params["password"] = password;
    String message;
    try {
      message = await platform.invokeMethod(Constant.SAVE_USER_KEY, params);
    } on Exception catch (e) {
      message = "Failed to get data from native : '${e}'.";
    }
    print("send user info success" + message);
  }

  // get config app
  Future<void> getConfigApp() async {
    var response = await ApiCaller.instance
        .postFormData(AppUrl.getConfigApp, Map<String, dynamic>());

    DataAppResponse dataAppResponse = DataAppResponse.fromJson(response);
    if (dataAppResponse.isSuccess()) {
      String copyRight = dataAppResponse.data;
      AppStore.copyRight = copyRight;
      notifyListeners();
    } else {
      message = dataAppResponse.messages;
      notifyListeners();
    }
  }

  Future<ProfileDetailModel> getProfile() async {
    var response = await ApiCaller.instance
        .postFormData(AppUrl.profileDetail, Map<String, dynamic>());
    ProfileDetailResponse profileDetailsResponse =
        ProfileDetailResponse.fromJson(response);
    if (profileDetailsResponse.isSuccess()) {
      return profileDetailsResponse.data;
    }
    return null;
  }

  // login by face id, touch id
  Future<bool> hasBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) {
      ToastMessage.show(
          "Chưa bật xác thực. Sau khi đăng nhập, bạn vui lòng vào phần cài đặt để bật xác thực bằng vân tay hoặc FaceId",
          ToastStyle.error);
      return false;
    }
    try {
      return await _localAuth.authenticateWithBiometrics(
        localizedReason: 'Scan Fingerprint to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print("PlatformException message => ${e.message}");
      return false;
    }
  }
}
