import 'package:workflow_manager/base/models/base_response.dart';
import 'package:workflow_manager/base/extension/int.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';

class LoginResponse extends BaseResponse {
  Data data;

  LoginResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
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

class Data {
  String token;
  User user;
  ConfigDocPro configDocPro;
  List<DocTypes> docTypes;
  int storageLimit;
  int storageUsed;
  int totalTaskDone;
  int totalTask;
  String apiKey;
  String linkApi;

  Data(
      {this.token,
        this.user,
        this.configDocPro,
        this.docTypes,
        this.storageLimit,
        this.storageUsed,
        this.totalTaskDone,
        this.totalTask,
        this.apiKey,
        this.linkApi
      });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    user = json['UserDocPro'] != null
        ? new User.fromJson(json['UserDocPro'])
        : null;
    configDocPro = json['ConfigDocPro'] != null
        ? new ConfigDocPro.fromJson(json['ConfigDocPro'])
        : null;
    if (json['DocTypes'] != null) {
      docTypes = new List<DocTypes>();
      json['DocTypes'].forEach((v) {
        docTypes.add(new DocTypes.fromJson(v));
      });
    }
    storageLimit = json['StorageLimit'];
    storageUsed = json['StorageUsed'];
    totalTaskDone = json['TotalTaskDone'];
    totalTask = json['TotalTask'];
    apiKey = json['ApiKey'];
    linkApi = json['LinkApi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    if (this.user != null) {
      data['UserDocPro'] = this.user.toJson();
    }
    if (this.configDocPro != null) {
      data['ConfigDocPro'] = this.configDocPro.toJson();
    }
    if (this.docTypes != null) {
      data['DocTypes'] = this.docTypes.map((v) => v.toJson()).toList();
    }
    data['StorageLimit'] = this.storageLimit;
    data['StorageUsed'] = this.storageUsed;
    data['TotalTaskDone'] = this.totalTaskDone;
    data['TotalTask'] = this.totalTask;
    data['ApiKey'] = this.apiKey;
    data['LinkApi'] = this.linkApi;
    return data;
  }
}

class User {
  int iDUserDocPro;
  String file;
  String name;
  String email;
  String address;
  String avatar;
  int gender;
  int birthday;
  String phone;
  String userName;

  User(
      {this.iDUserDocPro,
        this.file,
        this.name,
        this.email,
        this.address,
        this.avatar,
        this.gender,
        this.birthday,
        this.phone,
      this.userName});

  User.fromJson(Map<String, dynamic> json) {
    iDUserDocPro = json['IDUserDocPro'];
    file = json['File'];
    name = json['Name'];
    email = json['Email'];
    address = json['Address'];
    avatar = json['Avatar'];
    gender = json['Gender'];
    birthday = json['Birthday'];
    phone = json['Phone'];
    userName = json['UserName'];
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
    data['UserName'] = this.userName;
    return data;
  }

  String getBirthday() {
    return birthday.toDate(Constant.ddMMyyyy);
  }

  String getGender() {
    if (gender == 1) {
      return "Nam";
    } else if (gender == 2) {
      return "Nữ";
    } else {
      return "Khác";
    }
  }
}

class ConfigDocPro {
  String root;

  ConfigDocPro({this.root});

  ConfigDocPro.fromJson(Map<String, dynamic> json) {
    root = json['Root'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Root'] = this.root;
    return data;
  }
}

class DocTypes {
  int iD;
  String name;
  String code;

  DocTypes({this.iD, this.name, this.code});

  DocTypes.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Code'] = this.code;
    return data;
  }
}
