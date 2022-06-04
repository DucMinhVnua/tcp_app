import 'package:workflow_manager/base/models/base_response.dart';

class ProfileDetailResponse extends BaseResponse {
  int status;
  ProfileDetailModel data;

  ProfileDetailResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    status = json['Status'];
    data = json['Data'] != null
        ? new ProfileDetailModel.fromJson(json['Data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class ProfileDetailModel {
  bool isHRM;
  UserDocPro userDocPro;

  ProfileDetailModel({this.isHRM, this.userDocPro});

  ProfileDetailModel.fromJson(Map<String, dynamic> json) {
    isHRM = json['IsHRM'];
    userDocPro = json['UserDocPro'] != null
        ? new UserDocPro.fromJson(json['UserDocPro'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsHRM'] = this.isHRM;
    if (this.userDocPro != null) {
      data['UserDocPro'] = this.userDocPro.toJson();
    }
    return data;
  }
}

class UserDocPro {
  int iDUserDocPro;
  Null file;
  String name;
  String email;
  String address;
  String avatar;
  int gender;
  int birthday;
  String phone;

  UserDocPro(
      {this.iDUserDocPro,
      this.file,
      this.name,
      this.email,
      this.address,
      this.avatar,
      this.gender,
      this.birthday,
      this.phone});

  UserDocPro.fromJson(Map<String, dynamic> json) {
    iDUserDocPro = json['IDUserDocPro'];
    file = json['File'];
    name = json['Name'];
    email = json['Email'];
    address = json['Address'];
    avatar = json['Avatar'];
    gender = json['Gender'];
    birthday = json['Birthday'];
    phone = json['Phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDUserDocPro'] = this.iDUserDocPro;
    data['File'] = this.file;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Address'] = this.address;
    data['Avatar'] = this.avatar;
    data['Gender'] = this.gender;
    data['Birthday'] = this.birthday;
    data['Phone'] = this.phone;
    return data;
  }
}
