import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/models/response/login_response.dart';

class SharedPreferencesClass {
  static final String INITIALIZE = 'initialize';
  static final String TOKEN_KEY = 'token';
  static final String ROOT_KEY = 'root';
  static final String USER_KEY = 'USER_DOCPRO';
  static final String ONESIGNAL_ID_KEY = 'deviceID';
  static final String BASE_URL_REMOTE = "baseURLRemote";
  static final String PASSWORD_SIGNAL = "PASSWORD_SIGNAL";
  static final String IS_CLOUD_API = "IS_CLOUD_API";
  static final String NOTI_LOG = "NOTI_LOG";
  static final String SAVE_PLAYER_ID_TO_UNREGISTER =
      "SAVE_PLAYER_ID_TO_UNREGISTER";

  // static final String LIST_STATUS_GROUP_KEY = 'liststatusgroup';

  static final String USER_NAME = 'UserName';
  static final String PASS_WORD = 'PassWord';

  static final String FACE_ID_KEY = "face_id_key";
  static final String UNREADNOTIFICATION = "unreadnotification";
  static var _lock = Lock();
  static SharedPreferences prefs1;

  static Future<SharedPreferences> _getPreference() async {
    // if (prefs == null) {
    prefs1 = await SharedPreferences.getInstance();
    await prefs1.reload();
    // }
    return prefs1;
  }

  // static Future<void> addNotiLog(LogParams params) async {
  //   return await _lock.synchronized(() async {
  //     String text = await getValue(NOTI_LOG);
  //     LogParamResponse response;
  //     if (isNullOrEmpty(text)) {
  //       response = LogParamResponse();
  //     } else
  //       response = LogParamResponse.fromJson(jsonDecode(text));
  //     params.date = getCurrentDateTime();
  //     response.addLog(params);
  //     await save(NOTI_LOG, jsonEncode(response.toJson()));
  //   });
  // }
  //
  // static Future<void> clearNotiLog() async {
  //   return _lock.synchronized(() {
  //     save(NOTI_LOG, "");
  //   });
  // }
  //
  // static Future<LogParamResponse> getNotiLogs() async {
  //   String text = await getValue(NOTI_LOG);
  //   if (isNullOrEmpty(text)) {
  //     return null;
  //   } else
  //     return LogParamResponse.fromJson(jsonDecode(text));
  // }

  static Future<void> saveValue(String key, String value) async {
    final SharedPreferences prefs = await _getPreference();
    prefs.setString(key, value);
  }

  static Future<String> getValue(String key) async {
    final SharedPreferences prefs = await _getPreference();
    String value = prefs.getString(key);
    return value;
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await _getPreference();
    prefs.setString(TOKEN_KEY, token);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await _getPreference();
    String token = prefs.getString(TOKEN_KEY);
    return token;
  }

  static Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await _getPreference();
    prefs.setString(USER_KEY, json.encode(user.toJson()));
    return prefs.commit();
  }

  static Future<User> getUser() async {
    final SharedPreferences prefs = await _getPreference();
    if (prefs.getString(USER_KEY).isNullOrEmpty) {
      return null;
    }
    User user = User.fromJson(json.decode(prefs.getString(USER_KEY)));
    return user;
  }

  static Future<String> getBaseUrl() async {
    return await SharedPreferencesClass.get(
        SharedPreferencesClass.BASE_URL_REMOTE);
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await _getPreference();
    prefs.remove(USER_KEY);
    prefs.remove(TOKEN_KEY);
    prefs.remove(BASE_URL_REMOTE);
    prefs.remove(ROOT_KEY);
    prefs.remove(ONESIGNAL_ID_KEY);
    prefs.remove(PASSWORD_SIGNAL);
    // prefs.remove(LIST_STATUS_GROUP_KEY);
  }

  static Future<void> removeRemoteUrl() async {
    final SharedPreferences prefs = await _getPreference();
    prefs.remove(BASE_URL_REMOTE);
  }

  static Future<String> getRoot() async {
    final SharedPreferences prefs = await _getPreference();
    String root = prefs.getString(ROOT_KEY);
    return root;
  }

  static save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await _getPreference();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }

  static Future get(String key) async {
    final SharedPreferences sharedPrefs = await _getPreference();
    var value = sharedPrefs.get(key);
    return value;
  }

  static Future clearData() async {
    SharedPreferences sharedPrefs = await _getPreference();
    await sharedPrefs.clear();
  }
}
