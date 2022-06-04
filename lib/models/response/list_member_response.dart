import 'package:workflow_manager/base/models/base_response.dart';

class ListMemberResponse extends BaseResponse {
  ListMember data;

  ListMemberResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['Data'] != null ? new ListMember.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class ListMember {
  List<Users> users;

  ListMember({this.users});

  ListMember.fromJson(Map<String, dynamic> json) {
    if (json['Users'] != null) {
      users = new List<Users>();
      json['Users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['Users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int iD;
  String name;
  String address;
  int gender;
  String avatar;
  String email;
  String birthday;
  String phone;

  Users(
      {this.iD,
        this.name,
        this.address,
        this.gender,
        this.avatar,
        this.email,
        this.birthday,
        this.phone});

  Users.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    address = json['Address'];
    gender = json['Gender'];
    avatar = json['Avatar'];
    email = json['Email'];
    birthday = json['Birthday'];
    phone = json['Phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['Gender'] = this.gender;
    data['Avatar'] = this.avatar;
    data['Email'] = this.email;
    data['Birthday'] = this.birthday;
    data['Phone'] = this.phone;
    return data;
  }
}