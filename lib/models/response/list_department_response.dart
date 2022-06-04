import 'package:workflow_manager/base/models/base_response.dart';

class ListDepartmentResponse extends BaseResponse {
  ListDepartment data;

  ListDepartmentResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['Data'] != null ? new ListDepartment.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class ListDepartment {
  List<Depts> depts;
  int pageSize;
  int pageIndex;
  int pageTotal;
  int recordNumber;

  ListDepartment(
      {this.depts,
        this.pageSize,
        this.pageIndex,
        this.pageTotal,
        this.recordNumber});

  ListDepartment.fromJson(Map<String, dynamic> json) {
    if (json['Depts'] != null) {
      depts = new List<Depts>();
      json['Depts'].forEach((v) {
        depts.add(new Depts.fromJson(v));
      });
    }
    pageSize = json['PageSize'];
    pageIndex = json['PageIndex'];
    pageTotal = json['PageTotal'];
    recordNumber = json['RecordNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.depts != null) {
      data['Depts'] = this.depts.map((v) => v.toJson()).toList();
    }
    data['PageSize'] = this.pageSize;
    data['PageIndex'] = this.pageIndex;
    data['PageTotal'] = this.pageTotal;
    data['RecordNumber'] = this.recordNumber;
    return data;
  }
}

class Depts {
  int iD;
  int iDChannel;
  String name;
  String code;
  String describe;
  int parent;
  String parents;
  String created;
  int userCount;
  String searchMeta;
  bool keepConnectionAlive;
  Null connection;
  Null lastSQL;
  Null lastArgs;
  String lastCommand;
  bool enableAutoSelect;
  bool enableNamedParams;
  int commandTimeout;
  int oneTimeCommandTimeout;

  Depts(
      {this.iD,
        this.iDChannel,
        this.name,
        this.code,
        this.describe,
        this.parent,
        this.parents,
        this.created,
        this.userCount,
        this.searchMeta,
        this.keepConnectionAlive,
        this.connection,
        this.lastSQL,
        this.lastArgs,
        this.lastCommand,
        this.enableAutoSelect,
        this.enableNamedParams,
        this.commandTimeout,
        this.oneTimeCommandTimeout});

  Depts.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iDChannel = json['IDChannel'];
    name = json['Name'];
    code = json['Code'];
    describe = json['Describe'];
    parent = json['Parent'];
    parents = json['Parents'];
    created = json['Created'];
    userCount = json['UserCount'];
    searchMeta = json['SearchMeta'];
    keepConnectionAlive = json['KeepConnectionAlive'];
    connection = json['Connection'];
    lastSQL = json['LastSQL'];
    lastArgs = json['LastArgs'];
    lastCommand = json['LastCommand'];
    enableAutoSelect = json['EnableAutoSelect'];
    enableNamedParams = json['EnableNamedParams'];
    commandTimeout = json['CommandTimeout'];
    oneTimeCommandTimeout = json['OneTimeCommandTimeout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['IDChannel'] = this.iDChannel;
    data['Name'] = this.name;
    data['Code'] = this.code;
    data['Describe'] = this.describe;
    data['Parent'] = this.parent;
    data['Parents'] = this.parents;
    data['Created'] = this.created;
    data['UserCount'] = this.userCount;
    data['SearchMeta'] = this.searchMeta;
    data['KeepConnectionAlive'] = this.keepConnectionAlive;
    data['Connection'] = this.connection;
    data['LastSQL'] = this.lastSQL;
    data['LastArgs'] = this.lastArgs;
    data['LastCommand'] = this.lastCommand;
    data['EnableAutoSelect'] = this.enableAutoSelect;
    data['EnableNamedParams'] = this.enableNamedParams;
    data['CommandTimeout'] = this.commandTimeout;
    data['OneTimeCommandTimeout'] = this.oneTimeCommandTimeout;
    return data;
  }
}