import 'package:workflow_manager/base/models/base_response.dart';
import 'package:workflow_manager/models/response/login_response.dart';

class HomeIndexResponse extends BaseResponse {
  HomeIndexData data;

  HomeIndexResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data =
        json['Data'] != null ? new HomeIndexData.fromJson(json['Data']) : null;
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

class HomeIndexData {
  User user;
  bool isShowNSChart;
  bool isShowTLChart;
  bool isShowKDChart;
  bool isShowCVChart;
  ReportEmp reportEmp;
  ReportStgDoc reportStgDoc;
  ReportProjectPlan reportProjectPlan;
  ReportJob reportJob;
  bool isMyFile;
  bool isQLTL;
  bool isQLKH;
  bool isQLKD;
  bool isQLCV;
  bool isQLNS;
  bool isQLTS;
  bool isStgBorrow;
  bool isQLQTTT;
  bool isQLVB;
  bool isQLDA;
  bool isQLMS;
  bool isKHTT;
  int unreadNotification;
  String root;
  String rootAPI;
  String rootApiOcr;
  JobPermission jobPermission;

  HomeIndexData(
      {this.user,
      this.isShowNSChart,
      this.isShowTLChart,
      this.isShowKDChart,
      this.isShowCVChart,
      this.reportEmp,
      this.reportStgDoc,
      this.reportProjectPlan,
      this.reportJob,
      this.isMyFile,
      this.isQLTL,
      this.isQLKH,
      this.isQLKD,
      this.isQLCV,
      this.jobPermission,
      this.isQLNS,
      this.isQLTS,
      this.isStgBorrow,
      this.isQLQTTT,
      this.isQLVB,
      this.isQLDA,
      this.isQLMS,
      this.unreadNotification,
      this.root,
      this.rootAPI,
      this.rootApiOcr});

  HomeIndexData.fromJson(Map<String, dynamic> json) {
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    isShowNSChart = json['IsShowNS_Chart'];
    isShowTLChart = json['IsShowTL_Chart'];
    isShowKDChart = json['IsShowKD_Chart'];
    isShowCVChart = json['IsShowCV_Chart'];
    reportEmp = json['ReportEmp'] != null
        ? new ReportEmp.fromJson(json['ReportEmp'])
        : null;
    reportStgDoc = json['ReportStgDoc'] != null
        ? new ReportStgDoc.fromJson(json['ReportStgDoc'])
        : null;
    reportProjectPlan = json['ReportProjectPlan'] != null
        ? new ReportProjectPlan.fromJson(json['ReportProjectPlan'])
        : null;
    reportJob = json['ReportJob'] != null
        ? new ReportJob.fromJson(json['ReportJob'])
        : null;
    jobPermission = json['JobPermission'] != null
        ? new JobPermission.fromJson(json['JobPermission'])
        : null;
    isMyFile = json['IsMyFile'];
    isQLTL = json['IsQLTL'];
    isQLKH = json['IsQLKH'];
    isQLKD = json['IsQLKD'];
    isQLCV = json['IsQLCV'];
    isQLNS = json['IsQLNS'];
    isQLTS = json['IsQLTS'];
    isStgBorrow = json['IsStgBorrow'];
    isQLQTTT = json['IsQLQTTT'];
    isQLVB = json['IsQLVB'];
    isQLDA = json['IsQLDA'];
    isQLMS = json['IsQLMS'];
    isKHTT = json['IsKHTT'];
    unreadNotification = json['UnreadNotification'];
    root = json['root'];
    rootAPI = json['rootAPI'];
    rootApiOcr = json['rootApiOcr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['User'] = this.user.toJson();
    }
    data['IsShowNS_Chart'] = this.isShowNSChart;
    data['IsShowTL_Chart'] = this.isShowTLChart;
    data['IsShowKD_Chart'] = this.isShowKDChart;
    data['IsShowCV_Chart'] = this.isShowCVChart;
    if (this.reportEmp != null) {
      data['ReportEmp'] = this.reportEmp.toJson();
    }
    if (this.reportStgDoc != null) {
      data['ReportStgDoc'] = this.reportStgDoc.toJson();
    }
    if (this.reportProjectPlan != null) {
      data['ReportProjectPlan'] = this.reportProjectPlan.toJson();
    }
    if (this.reportJob != null) {
      data['ReportJob'] = this.reportJob.toJson();
    }
    if (this.jobPermission != null) {
      data['JobPermission'] = this.jobPermission.toJson();
    }
    data['IsMyFile'] = this.isMyFile;
    data['IsQLTL'] = this.isQLTL;
    data['IsQLKH'] = this.isQLKH;
    data['IsQLKD'] = this.isQLKD;
    data['IsQLCV'] = this.isQLCV;
    data['IsQLNS'] = this.isQLNS;
    data['IsQLTS'] = this.isQLTS;
    data['IsStgBorrow'] = this.isStgBorrow;
    data['IsQLQTTT'] = this.isQLQTTT;
    data['IsQLVB'] = this.isQLVB;
    data['IsQLDA'] = this.isQLDA;
    data['IsQLMS'] = this.isQLMS;
    data['UnreadNotification'] = this.unreadNotification;
    data['root'] = this.root;
    data['rootAPI'] = this.rootAPI;
    data['rootApiOcr'] = this.rootApiOcr;
    return data;
  }
}

class ReportEmp {
  List<ReportAges> reportAges;
  int sumMale = 0;
  int sumFemale = 0;
  int sumEmp = 0;
  double averageAge = 0.0;

  ReportEmp(
      {this.reportAges,
      this.sumMale,
      this.sumFemale,
      this.sumEmp,
      this.averageAge});

  ReportEmp.fromJson(Map<String, dynamic> json) {
    if (json['ReportAges'] != null) {
      reportAges = new List<ReportAges>();
      json['ReportAges'].forEach((v) {
        reportAges.add(new ReportAges.fromJson(v));
      });
    }
    sumMale = json['SumMale'];
    sumFemale = json['SumFemale'];
    sumEmp = json['SumEmp'];
    averageAge = json['AverageAge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reportAges != null) {
      data['ReportAges'] = this.reportAges.map((v) => v.toJson()).toList();
    }
    data['SumMale'] = this.sumMale;
    data['SumFemale'] = this.sumFemale;
    data['SumEmp'] = this.sumEmp;
    data['AverageAge'] = this.averageAge;
    return data;
  }
}

class ReportAges {
  String name;
  int amount;
  int male;
  int female;

  ReportAges({this.name, this.amount, this.male, this.female});

  ReportAges.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    amount = json['Amount'];
    male = json['Male'];
    female = json['Female'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Amount'] = this.amount;
    data['Male'] = this.male;
    data['Female'] = this.female;
    return data;
  }
}

class ReportStgDoc {
  ReportSize reportSize;
  int totalFile;
  int totalDoctype;
  String totalSize;
  int totalUser;

  ReportStgDoc(
      {this.reportSize,
      this.totalFile,
      this.totalDoctype,
      this.totalSize,
      this.totalUser});

  ReportStgDoc.fromJson(Map<String, dynamic> json) {
    reportSize = json['ReportSize'] != null
        ? new ReportSize.fromJson(json['ReportSize'])
        : null;
    totalFile = json['TotalFile'];
    totalDoctype = json['TotalDoctype'];
    totalSize = json['TotalSize'];
    totalUser = json['TotalUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reportSize != null) {
      data['ReportSize'] = this.reportSize.toJson();
    }
    data['TotalFile'] = this.totalFile;
    data['TotalDoctype'] = this.totalDoctype;
    data['TotalSize'] = this.totalSize;
    data['TotalUser'] = this.totalUser;
    return data;
  }
}

class ReportSize {
  double rate;
  int size = 0;
  int total;

  ReportSize({this.rate, this.size, this.total});

  ReportSize.fromJson(Map<String, dynamic> json) {
    rate = json['Rate'];
    size = json['Size'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Rate'] = this.rate;
    data['Size'] = this.size;
    data['Total'] = this.total;
    return data;
  }
}

class ReportProjectPlan {
  List<ReportQuater> reportQuater;
  int projectPlanTotal = 0;
  double planTotalMoney = 0.0;
  int projectActualTotal = 0;
  double actualTotalMoney = 0.0;
  double totalProjectFail = 0.0;

  ReportProjectPlan(
      {this.reportQuater,
      this.projectPlanTotal,
      this.planTotalMoney,
      this.projectActualTotal,
      this.actualTotalMoney,
      this.totalProjectFail});

  ReportProjectPlan.fromJson(Map<String, dynamic> json) {
    if (json['ReportQuater'] != null) {
      reportQuater = new List<ReportQuater>();
      json['ReportQuater'].forEach((v) {
        reportQuater.add(new ReportQuater.fromJson(v));
      });
    }
    projectPlanTotal = json['ProjectPlanTotal'];
    planTotalMoney = json['PlanTotalMoney'];
    projectActualTotal = json['ProjectActualTotal'];
    actualTotalMoney = json['ActualTotalMoney'];
    totalProjectFail = json['TotalProjectFail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reportQuater != null) {
      data['ReportQuater'] = this.reportQuater.map((v) => v.toJson()).toList();
    }
    data['ProjectPlanTotal'] = this.projectPlanTotal;
    data['PlanTotalMoney'] = this.planTotalMoney;
    data['ProjectActualTotal'] = this.projectActualTotal;
    data['ActualTotalMoney'] = this.actualTotalMoney;
    data['TotalProjectFail'] = this.totalProjectFail;
    return data;
  }
}

class ReportQuater {
  String title;
  double plan;
  double actual;

  ReportQuater({this.title, this.plan, this.actual});

  ReportQuater.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    plan = json['plan'];
    actual = json['actual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['plan'] = this.plan;
    data['actual'] = this.actual;
    return data;
  }
}

class ReportJob {
  List<ReportStatus> reportStatus;
  int jobCount;
  int jobDone;
  int jobProgress;
  int jobExpried;
  double percentSussess;

  ReportJob(
      {this.reportStatus,
      this.jobCount,
      this.jobDone,
      this.jobProgress,
      this.jobExpried,
      this.percentSussess});

  ReportJob.fromJson(Map<String, dynamic> json) {
    if (json['ReportStatus'] != null) {
      reportStatus = new List<ReportStatus>();
      json['ReportStatus'].forEach((v) {
        reportStatus.add(new ReportStatus.fromJson(v));
      });
    }
    jobCount = json['JobCount'];
    jobDone = json['JobDone'];
    jobProgress = json['JobProgress'];
    jobExpried = json['JobExpried'];
    percentSussess = json['PercentSussess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reportStatus != null) {
      data['ReportStatus'] = this.reportStatus.map((v) => v.toJson()).toList();
    }
    data['JobCount'] = this.jobCount;
    data['JobDone'] = this.jobDone;
    data['JobProgress'] = this.jobProgress;
    data['JobExpried'] = this.jobExpried;
    data['PercentSussess'] = this.percentSussess;
    return data;
  }
}

class ReportStatus {
  String title;
  int intime;
  int warningtime;
  int overtime;

  ReportStatus({this.title, this.intime, this.warningtime, this.overtime});

  ReportStatus.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    intime = json['intime'];
    warningtime = json['warningtime'];
    overtime = json['overtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['intime'] = this.intime;
    data['warningtime'] = this.warningtime;
    data['overtime'] = this.overtime;
    return data;
  }
}

class JobPermission {
  bool isGroupAccess;
  bool isReportAccess;
  bool isJobAccess;

  JobPermission({this.isGroupAccess, this.isReportAccess, this.isJobAccess});

  JobPermission.fromJson(Map<String, dynamic> json) {
    isGroupAccess = json['IsGroupAccess'];
    isReportAccess = json['IsReportAccess'];
    isJobAccess = json['IsJobAccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsGroupAccess'] = this.isGroupAccess;
    data['IsReportAccess'] = this.isReportAccess;
    data['IsJobAccess'] = this.isJobAccess;
    return data;
  }
}
