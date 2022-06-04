import 'package:flutter/material.dart';
import 'package:workflow_manager/base/network/api_caller.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/models/response/list_member_response.dart';

class AccountModel with ChangeNotifier {
  ApiCaller _apiService = ApiCaller.instance;
  List<Users> listMembers = [];

  Future<ListMemberResponse> getMemberList() async {
    final jsonData = await _apiService.get(AppUrl.get_list_member,
        params: new Map<String, dynamic>());
    return ListMemberResponse.fromJson(jsonData);
  }
}
