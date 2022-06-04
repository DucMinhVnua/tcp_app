import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:workflow_manager/base/network/app_url.dart';

import 'custom_exception.dart';

class ApiProvider {

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      log(AppUrl.baseURL + url);
      final response = await http.get(AppUrl.baseURL + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> params) async {
    var responseJson;
    try {
      log(json.encode(params));
      log(AppUrl.baseURL + url);
      final response = await http.post(AppUrl.baseURL + url, body: json.encode(params), headers: {'Content-Type': 'application/json'});
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}