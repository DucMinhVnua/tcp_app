import 'package:workflow_manager/base/models/base_response.dart';
import 'package:workflow_manager/base/utils/common_function.dart';

class StorageIndexResponse extends BaseResponse {
  int status;
  DataStorageIndex data;

  StorageIndexResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data = json['Data'] != null
        ? new DataStorageIndex.fromJson(json['Data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    if (this.messages != null) {
      data['Messages'] = this.messages;
    }
    return data;
  }
}

class DataStorageIndex {
  List<DocChildItem> docChilds;
  DocChildItem docParent;
  int total;
  int take;
  int skip;

  DataStorageIndex(
      {this.docChilds, this.docParent, this.total, this.take, this.skip});

  DataStorageIndex.fromJson(Map<String, dynamic> json) {
    if (json['DocChilds'] != null) {
      docChilds = new List<DocChildItem>();
      json['DocChilds'].forEach((v) {
        docChilds.add(new DocChildItem.fromJson(v));
      });
    } else {
      if (json['Docs'] != null) {
        docChilds = new List<DocChildItem>();
        json['Docs'].forEach((v) {
          docChilds.add(new DocChildItem.fromJson(v));
        });
      }
    }
    docParent = json['DocParent'] != null
        ? new DocChildItem.fromJson(json['DocParent'])
        : null;
    total = json['total'];
    take = json['take'];
    skip = json['skip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docChilds != null) {
      data['DocChilds'] = this.docChilds.map((v) => v.toJson()).toList();
    }
    if (this.docParent != null) {
      data['DocParent'] = this.docParent.toJson();
    }
    data['total'] = this.total;
    data['take'] = this.take;
    data['skip'] = this.skip;
    return data;
  }
}

class DocChildItem {
  int iD;
  String path;
  String size;
  String name;
  int created;
  String createBy;
  int updated;
  String updateBy;
  bool isFolder = false;
  String icon;
  bool isView;
  bool isUpdate;
  bool isDelete;
  bool isCreate;
  bool isCopy;
  bool isDownload;
  bool isMove;
  bool isShare;
  bool isNote;
  bool isPassword;
  bool isSetPassword;
  bool isChangePassword;
  int typeExtension;
  int parent;
  int isPin;
  int passwordParentId;
  bool isCheck = false;
  String passWordItem;

  bool isShowDownload;
  bool isShowPin;
  bool isShowPassWord;
  bool isShowChangePassWord;
  bool isShowReplace;

  DocChildItem(
      {this.iD,
      this.path,
      this.size,
      this.name,
      this.created,
      this.createBy,
      this.updated,
      this.updateBy,
      this.isFolder,
      this.icon,
      this.isView,
      this.isUpdate,
      this.isDelete,
      this.isCreate,
      this.isCopy,
      this.isDownload,
      this.isMove,
      this.isShare,
      this.isNote,
      this.isPassword,
      this.isSetPassword,
      this.isChangePassword,
      this.typeExtension,
      this.parent,
      this.isPin,
      this.passwordParentId});

  DocChildItem.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    path = json['Path'];
    size = json['Size'];
    name = json['Name'];
    created = json['Created'];
    createBy = json['CreateBy'];
    updated = json['Updated'];
    updateBy = json['UpdateBy'];
    isFolder = json['IsFolder'];
    icon = json['Icon'];
    isView = json['IsView'];
    isUpdate = json['IsUpdate'];
    isDelete = json['IsDelete'];
    isCreate = json['IsCreate'];
    isCopy = json['IsCopy'];
    isDownload = json['IsDownload'];
    isMove = json['IsMove'];
    isShare = json['IsShare'];
    isNote = json['IsNote'];
    isPassword = json['IsPassword'];
    isSetPassword = json['IsSetPassword'];
    isChangePassword = json['IsChangePassword'];
    typeExtension = json['TypeExtension'];
    parent = json['Parent'];
    isPin = json['IsPin'];
    passwordParentId = json['PasswordParentId'];

    if (isNotNullOrEmpty(isFolder)) {
      isShowDownload = isFolder
          ? false
          : isDownload
              ? true
              : false;
      isShowReplace = isFolder
          ? false
          : isUpdate
              ? true
              : false;
    }
    isShowPin = isPin == 1 ? true : false;
    if (isNotNullOrEmpty(isSetPassword)) {
      isShowPassWord = isSetPassword && !isPassword ? true : false;
      isShowChangePassWord = isSetPassword && isPassword ? true : false;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Path'] = this.path;
    data['Size'] = this.size;
    data['Name'] = this.name;
    data['Created'] = this.created;
    data['CreateBy'] = this.createBy;
    data['Updated'] = this.updated;
    data['UpdateBy'] = this.updateBy;
    data['IsFolder'] = this.isFolder;
    data['Icon'] = this.icon;
    data['IsView'] = this.isView;
    data['IsUpdate'] = this.isUpdate;
    data['IsDelete'] = this.isDelete;
    data['IsCreate'] = this.isCreate;
    data['IsCopy'] = this.isCopy;
    data['IsDownload'] = this.isDownload;
    data['IsMove'] = this.isMove;
    data['IsShare'] = this.isShare;
    data['IsNote'] = this.isNote;
    data['IsPassword'] = this.isPassword;
    data['IsSetPassword'] = this.isSetPassword;
    data['IsChangePassword'] = this.isChangePassword;
    data['TypeExtension'] = this.typeExtension;
    data['Parent'] = this.parent;
    data['IsPin'] = this.isPin;
    data['PasswordParentId'] = this.passwordParentId;
    return data;
  }
}
