import 'package:workflow_manager/base/models/base_response.dart';

class NotificationResponse extends BaseResponse {
  DataNotification data;

  NotificationResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    data = json['Data'] != null
        ? new DataNotification.fromJson(json['Data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }

    return data;
  }
}

class DataNotification {
  List<NotificationInfos> notificationInfos;
  int pageSize;
  int pageIndex;
  List<Types> types;
  int pageTotal;

  DataNotification(
      {this.notificationInfos,
      this.pageSize,
      this.pageIndex,
      this.types,
      this.pageTotal});

  DataNotification.fromJson(Map<String, dynamic> json) {
    if (json['NotificationInfos'] != null) {
      notificationInfos = new List<NotificationInfos>();
      json['NotificationInfos'].forEach((v) {
        notificationInfos.add(new NotificationInfos.fromJson(v));
      });
    }
    pageSize = json['PageSize'];
    pageIndex = json['PageIndex'];
    if (json['Types'] != null) {
      types = new List<Types>();
      json['Types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
    pageTotal = json['PageTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationInfos != null) {
      data['NotificationInfos'] =
          this.notificationInfos.map((v) => v.toJson()).toList();
    }
    data['PageSize'] = this.pageSize;
    data['PageIndex'] = this.pageIndex;
    if (this.types != null) {
      data['Types'] = this.types.map((v) => v.toJson()).toList();
    }
    data['PageTotal'] = this.pageTotal;
    return data;
  }
}

class NotificationInfos {
  int iD;
  String senderAvatar;
  String senderName;
  String messageType;
  String fullMessage;
  String message;
  bool isSended;
  bool isReaded;
  bool isPassword;
  String path;
  String messageTypeSub;
  int created;
  int iDContent;
  bool isFolder;
  int type;
  String describe;
  String link;

  NotificationInfos(
      {this.iD,
      this.senderAvatar,
      this.senderName,
      this.messageType,
      this.fullMessage,
      this.message,
      this.isSended,
      this.isReaded,
      this.isPassword,
      this.path,
      this.messageTypeSub,
      this.created,
      this.iDContent,
      this.isFolder,
      this.type,
      this.describe,
      this.link});

  NotificationInfos.fromJson(Map<String, dynamic> json) {
    if (json["ID"] is String) {
      iD = int.parse(json["ID"]);
    } else
      iD = json['ID'];
    senderAvatar = json['SenderAvatar'];
    senderName = json['SenderName'];
    messageType = json['MessageType'];
    fullMessage = json['FullMessage'];
    message = json['Message'];
    isSended = json['IsSended'];
    isReaded = json['IsReaded'];
    isPassword = json['IsPassword'];
    path = json['Path'];
    messageTypeSub = json['MessageTypeSub'];
    if (json["Created"] is String) {
      created = int.parse(json["Created"]);
    } else
      created = json['Created'];
    if (json["IDContent"] is String) {
      iDContent = int.parse(json["IDContent"]);
    } else
      iDContent = json['IDContent'];
    if (json['IsFolder'] is String)
      isFolder = json['IsFolder'] == "1";
    else
      isFolder = json['IsFolder'];
    if (json["Type"] is String) {
      type = int.parse(json["Type"]);
    } else
      type = json['Type'];
    describe = json['Describe'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['SenderAvatar'] = this.senderAvatar;
    data['SenderName'] = this.senderName;
    data['MessageType'] = this.messageType;
    data['FullMessage'] = this.fullMessage;
    data['Message'] = this.message;
    data['IsSended'] = this.isSended;
    data['IsReaded'] = this.isReaded;
    data['IsPassword'] = this.isPassword;
    data['Path'] = this.path;
    data['MessageTypeSub'] = this.messageTypeSub;
    data['Created'] = this.created;
    data['IDContent'] = this.iDContent;
    data['IsFolder'] = this.isFolder;
    data['Type'] = this.type;
    data['Describe'] = this.describe;
    data['Link'] = this.link;
    return data;
  }
}

class Types {
  int iD;
  String name;

  Types({this.iD, this.name});

  Types.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    return data;
  }
}
