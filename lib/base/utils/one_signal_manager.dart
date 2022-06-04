import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:workflow_manager/base/models/base_response.dart';
import 'package:workflow_manager/base/models/storage_index_response.dart';
import 'package:workflow_manager/base/network/api_caller.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/base/ui/custom_dialog.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/ui/webview_screen.dart';
import 'package:workflow_manager/base/utils/base_sharepreference.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/base/utils/file_utils.dart';
import 'package:workflow_manager/base/utils/notification_type.dart';

// import 'package:workflow_manager/borrowPayDocument/tab_borrow_pay_document_screen.dart';
// import 'package:workflow_manager/businessManagement/screen/management/detail/detail_management_screen.dart';
// import 'package:workflow_manager/main.dart';
// import 'package:workflow_manager/manager/models/params/send_info_device_request.dart';
// import 'package:workflow_manager/procedures/screens/detail/detail_procedure_screen.dart';
// import 'package:workflow_manager/storage/models/params/check_download_file_request.dart';
// import 'package:workflow_manager/storage/screens/list_storage/list_storage_repository.dart';
// import 'package:workflow_manager/storage/screens/list_storage/list_storage_screen.dart';
// import 'package:workflow_manager/storage/screens/tabs/main_tab_storage_screen.dart';
// import 'package:workflow_manager/storage/widgets/dialog/dialog_get_pass_word.dart';
// import 'package:workflow_manager/tpc/models/notification_model.dart';
// import 'package:workflow_manager/tpc/models/response/login_response.dart';
// import 'package:workflow_manager/tpc/screens/details/details_screen_main/task_details_screen.dart';
// import 'package:workflow_manager/tpc/screens/group_job/group_job_details/group_job_detail_main/group_job_details_screen.dart';

import '../../app_init.dart';
import 'notification_model.dart';

//TODO BEGIN TCP Module 8-1-2022
import 'package:workflow_manager/models/response/manager_receiving_lime_stones_response.dart';
import 'package:workflow_manager/models/response/manager_receiving_oils_response.dart';
import 'package:workflow_manager/models/response/manipulation_sheets_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_commands_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_sheets_response.dart';
import 'package:workflow_manager/models/response/work_commands_response.dart';
import 'package:workflow_manager/models/response/work_sheets_response.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_command_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_sheet_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_limestone_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_oil_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/manipulation_sheet/manipulation_sheet_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_command_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_sheet_detail_screen.dart';
//TODO END TCP Module 8-1-2022

class OneSignalManager {
  static OneSignalManager _instance;
  static NotificationInfos lateNotificationInfos;

  static OneSignalManager get instance {
    if (_instance == null) {
      _instance = OneSignalManager();
    }
    return _instance;
  }

  // Future<void> initOneSignal(BuildContext context) async {
  //   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  //   var settings = {
  //     OSiOSSettings.autoPrompt: true,
  //     OSiOSSettings.promptBeforeOpeningPushUrl: true
  //   };
  //   OneSignal.shared.setRequiresUserPrivacyConsent(true);
  //   await OneSignal.shared.init(AppUrl.oneSignalAppID, iOSSettings: settings);
  //   OneSignal.shared
  //       .setNotificationReceivedHandler((OSNotification notification) async {
  //     int unreadnotification = await SharedPreferencesClass.get(
  //         SharedPreferencesClass.UNREADNOTIFICATION);
  //     if (unreadnotification == null) unreadnotification = 0;
  //     FlutterAppBadger.updateBadgeCount(unreadnotification + 1);
  //     await SharedPreferencesClass.save(
  //         SharedPreferencesClass.UNREADNOTIFICATION, unreadnotification + 1);
  //
  //     // var jsonResponse = notification.payload.additionalData;
  //     // NotificationInfos notificationInfos =
  //     //     NotificationInfos.fromJson(jsonResponse);
  //     // print("OneSignal: ReceivedHandler: ${notification.jsonRepresentation()}");
  //     // print("OneSignal: notificationInfos: ${notificationInfos?.toJson()}");
  //   });
  //
  //   //
  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     print(
  //         "OneSignal: OpenedHandler: ${result.notification.jsonRepresentation()}");
  //     var jsonResponse = result.notification.payload.additionalData;
  //     NotificationInfos notificationInfos =
  //         NotificationInfos.fromJson(jsonResponse);
  //     if (appState == AppLifecycleState.resumed)
  //       navigationTargetScreen(context, notificationInfos);
  //     else {
  //       lateNotificationInfos = notificationInfos;
  //     }
  //     print("OneSignal: IDCONTENT: ${notificationInfos?.iDContent}");
  //   });
  //
  //   OneSignal.shared
  //       .setInAppMessageClickedHandler((OSInAppMessageAction action) {
  //     print(
  //         "OneSignal: setInAppMessageClickedHandler: ${action.jsonRepresentation()}");
  //   });
  //
  //   OneSignal.shared
  //       .setInFocusDisplayType(OSNotificationDisplayType.notification);
  //   // quan trọng
  //   OneSignal.shared.consentGranted(true);
  //
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();
  //   bool isSubscribed = status.subscriptionStatus.subscribed;
  //   if (isSubscribed == false) {
  //     await OneSignal.shared.setSubscription(true);
  //     var statues = await OneSignal.shared.getPermissionSubscriptionState();
  //     isSubscribed = statues.subscriptionStatus.subscribed;
  //     var playerId = statues.subscriptionStatus.userId;
  //     if (playerId != null) {
  //       SharedPreferencesClass.save(
  //           SharedPreferencesClass.ONESIGNAL_ID_KEY, playerId);
  //       // send onesigal-Id qua api này thay cho truyền trong socket
  //       sendInfoDevice(playerId);
  //       // SocketManager().connect();
  //     } else {
  //       // lần đầu vào thì playerId sẽ = null cho nên sẽ phải check
  //       getPlayerID();
  //     }
  //   } else {
  //     var playerId = status.subscriptionStatus.userId;
  //     if (playerId != null) {
  //       SharedPreferencesClass.save(
  //           SharedPreferencesClass.ONESIGNAL_ID_KEY, playerId);
  //       // send onesigal-Id qua api này thay cho truyền trong socket
  //       sendInfoDevice(playerId);
  //       // SocketManager().connect();
  //     } else {
  //       // lần đầu vào thì playerId sẽ = null cho nên sẽ phải check
  //       getPlayerID();
  //     }
  //   }
  // }
  //
  // Future<void> getPlayerID() async {
  //   OneSignal.shared.setSubscriptionObserver((changes) async {
  //     var playerId = changes.to.userId; // playerID đc thay đổi
  //     if (playerId != null) {
  //       SharedPreferencesClass.save(
  //           SharedPreferencesClass.ONESIGNAL_ID_KEY, playerId);
  //       // send onesigal-Id qua api này thay cho truyền trong socketve
  //       sendInfoDevice(playerId);
  //       // SocketManager().connect();
  //     }
  //   });
  // }
  //
  // //send info device to server
  // // Gửi các thông tin để nhận notifcaiton lên server khi login thành công
  // Future<bool> sendInfoDevice(String playerId) async {
  //   User user = await SharedPreferencesClass.getUser();
  //   SendInfoDeviceRequest request = SendInfoDeviceRequest();
  //   request.iDPlayer = playerId;
  //   final response = await ApiCaller.instance
  //       .postFormData(AppUrl.sendInfoDevice, request.getParams());
  //   final BaseResponse sendInforResponse = BaseResponse.fromJson(response);
  //   if (sendInforResponse.isSuccess(
  //       isShowSuccessMessage: false, isDontShowErrorMessage: true)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<bool> removeInfoDevice(String playerId,
  //     {String oldToken, String baseUrl}) async {
  //   SendInfoDeviceRequest request = SendInfoDeviceRequest();
  //   request.iDPlayer = playerId;
  //   request.token = oldToken;
  //   final response = await ApiCaller.instance.postFormData(
  //       (baseUrl ?? "") + AppUrl.removeInfoDevice, request.getParams(),
  //       isNeedAddToken: isNullOrEmpty(oldToken));
  //   final BaseResponse sendInforResponse = BaseResponse.fromJson(response);
  //   if (isNullOrEmpty(oldToken))
  //     return sendInforResponse.isSuccess(isShowSuccessMessage: false);
  //   return sendInforResponse.status == 0 || sendInforResponse.status == 1;
  // }
  //
  // Future<String> _getDeviceId() async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     // import 'dart:io'
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.androidId; // unique ID on Android
  //   }
  // }

  //Navigation when click on notification and deep link
  void navigationTargetScreen(
      BuildContext context, NotificationInfos notificationInfo) {
    int type = notificationInfo.type;
    int iDContent = notificationInfo.iDContent;
    bool isFolder = notificationInfo.isFolder ?? false;
    String name = notificationInfo.message;
    String path = notificationInfo.path;
    String link = notificationInfo.link;

    // print(
    //     "XnavigationTargetScreen type = ${type} iDContent = ${iDContent} isFolder = ${isFolder}");
    // // Quản lý công việc
    // if (NotificationType.instance.isDetailGroupJob(type)) {
    //   if (hasScreen((GroupJobDetailsScreen).toString())) {
    //     eventBus.fire(NotiData(id: iDContent));
    //   } else
    //     pushPage(context, GroupJobDetailsScreen(iDContent));
    //   return;
    // } else if (NotificationType.instance.isDetailJob(type)) {
    //   if (hasScreen((TaskDetailsScreen).toString())) {
    //     eventBus.fire(NotiData(id: iDContent));
    //   } else
    //     pushPage(context, TaskDetailsScreen(iDContent, null));
    //   return;
    // }
    // // Quản lý tài liệu
    // if (NotificationType.instance.isStorage(type)) {
    //   DocChildItem item = DocChildItem();
    //   item.iD = iDContent;
    //   item.name = name;
    //   item.path = path;
    //   if (isFolder) {
    //     if (hasScreen((ListStorageScreen).toString())) {
    //       eventBus.fire(NotiData(
    //           typeStorage: StorageTopTabType.Document,
    //           type: StorageBottomTabType.DataStorage,
    //           item: item));
    //     } else
    //       pushPage(
    //           context,
    //           ListStorageScreen(
    //             typeStorage: StorageTopTabType.Document,
    //             type: StorageBottomTabType.DataStorage,
    //             item: item,
    //           ));
    //     return;
    //   } else {
    //     _showFile(item, context, false);
    //     return;
    //   }
    // } else if (NotificationType.instance.isShareDoc(type)) {
    //   DocChildItem item = DocChildItem();
    //   item.iD = iDContent;
    //   item.name = name;
    //   item.path = path;
    //   if (isFolder) {
    //     item.name = 'Tài liệu chia sẻ';
    //     if (hasScreen((ListStorageScreen).toString())) {
    //       eventBus.fire(NotiData(
    //           typeStorage: StorageTopTabType.Document,
    //           type: StorageBottomTabType.Shared,
    //           item: item));
    //     } else
    //       pushPage(
    //           context,
    //           ListStorageScreen(
    //             typeStorage: StorageTopTabType.Document,
    //             type: StorageBottomTabType.Shared,
    //             item: item,
    //           ));
    //     return;
    //   } else {
    //     _showFile(item, context, true);
    //     return;
    //   }
    // }
    //
    // // Mượn trả tài liệu
    // if (NotificationType.instance.isDetailBorrow(type)) {
    //   if (NotificationType.instance.isOpenFile(type)) {
    //     DocChildItem item = DocChildItem();
    //     item.iD = iDContent;
    //     item.name = notificationInfo.message;
    //     item.path = notificationInfo.path;
    //     FileUtils.instance.downloadFileAndOpen(item.name, item.path, context,
    //         typeExtension: item.typeExtension);
    //     return;
    //   } else {
    //     if (hasScreen((TabBorrowPayDocumentScreen).toString())) {
    //       eventBus.fire(NotiData(typeInt: type));
    //     } else
    //       pushPage(
    //           context,
    //           TabBorrowPayDocumentScreen(
    //             typeNotificationTab: type,
    //           ));
    //     return;
    //   }
    // } else if (NotificationType.instance.isDownloadFile(type)) {
    //   if (isNotNullOrEmpty(path)) {
    //     FileUtils.instance.downloadFileAndOpen(name, path, context,
    //         isOpenFile: false, isAutoDetectFileName: true);
    //     return;
    //   } else if (isNotNullOrEmpty(link)) {
    //     // trường hợp là file nén phải download file từ link chứ ko phải từ path
    //     FileUtils.instance.downloadFileAndOpen(name, link, context,
    //         isOpenFile: false,
    //         isStorage: false,
    //         isNeedToken: true,
    //         isAutoDetectFileName: true);
    //   }
    //   return;
    // } else if (NotificationType.instance.zipFolderEmpty(type)) {
    //   return;
    // }
    //
    // // QUY TRÌNH THỦ TỤC
    // if (NotificationType.instance.isDetailRegister(type)) {
    //   if (hasScreen((DetailProcedureScreen).toString())) {
    //     eventBus.fire(NotiData(
    //         typeInt: DetailProcedureScreen.TYPE_REGISTER, id: iDContent));
    //   } else
    //     pushPage(
    //         context,
    //         DetailProcedureScreen(
    //           idServiceRecord: iDContent,
    //           type: DetailProcedureScreen.TYPE_REGISTER,
    //           state: null,
    //         ));
    //   return;
    // } else if (NotificationType.instance.isDetailResolve(type)) {
    //   if (hasScreen((DetailProcedureScreen).toString())) {
    //     eventBus.fire(NotiData(
    //         typeInt: DetailProcedureScreen.TYPE_RESOLVE, id: iDContent));
    //   } else
    //     pushPage(
    //         context,
    //         DetailProcedureScreen(
    //           idServiceRecord: iDContent,
    //           type: DetailProcedureScreen.TYPE_RESOLVE,
    //           state: null,
    //         ));
    //   return;
    // }
    //

    //TODO BEGIN TCP Module 8-1-2022
    ///TCP Module 1
    //Chi tiết lệnh công tác
    if (NotificationType.instance.isDetailWorkCommand(type)) {
      if (hasScreen((WorkCommandDetailScreen).toString())) {
        eventBus.fire(NotiData(id: iDContent));
      } else
        pushPage(
            context,
            WorkCommandDetailScreen(
              workCommand: WorkCommand(iD: iDContent),
            ));
      return;
    }
    ///TCP Module 2
    //Chi tiết lệnh công tác
    else if (NotificationType.instance.isDetailWorkSheet(type)) {
      if (hasScreen((WorkSheetDetailScreen).toString())) {
        eventBus.fire(NotiData(id: iDContent));
      } else
        pushPage(
            context,
            WorkSheetDetailScreen(
              workSheet: WorkSheet(iD: iDContent),
            ));
      return;
    }
    ///TCP Module 3
    //Chi tiết lệnh công tác CNH
    else if (NotificationType.instance.isDetailMechanicalWorkCommand(type)) {
      if (hasScreen((MechanicalWorkCommandDetailScreen).toString())) {
        eventBus.fire(NotiData(id: iDContent));
      } else
        pushPage(
            context,
            MechanicalWorkCommandDetailScreen(
              mechanicalWorkCommand: MechanicalWorkCommand(iD: iDContent),
            ));
      return;
    }
    ///TCP Module 4
    //Chi tiết phiếu công tac CNH
    else if (NotificationType.instance.isDetailMechanicalWorkSheet(type)) {
      if (hasScreen((MechanicalWorkSheetDetailScreen).toString())) {
        eventBus.fire(NotiData(id: iDContent));
      } else
        pushPage(
            context,
            MechanicalWorkSheetDetailScreen(
              mechanicalWorkSheet: MechanicalWorkSheet(iD: iDContent),
            ));
      return;
    }
    ///TCP Module 5
    //Chi tiết phiếu thao tác
    else if (NotificationType.instance.isDetailManipulationSheet(type)) {
      if (hasScreen((ManipulationSheetDetailScreen).toString())) {
        eventBus.fire(NotiData(id: iDContent));
      } else
        pushPage(
            context,
            ManipulationSheetDetailScreen(
              manipulationSheet: ManipulationSheet(iD: iDContent),
            ));
      return;
    }
    ///TCP Module 6
    //Chi tiết tiếp nhận hồ sơ dầu
    else if (NotificationType.instance.isDetailManagerReceivingOil(type)) {
      if (hasScreen((ManagerReceivingOilDetailScreen).toString())) {
        eventBus.fire(NotiData(id: iDContent));
      } else
        pushPage(
            context,
            ManagerReceivingOilDetailScreen(
              managerReceivingOil: ManagerReceivingOil(iD: iDContent),
            ));
      return;
    }
    ///TCP Module 7
    //Chi tiết tiếp nhận hồ sơ đá vôi
    else if (NotificationType.instance.isDetailManagerReceivingLimestone(type)) {
      if (hasScreen((ManagerReceivingLimestoneDetailScreen).toString())) {
        eventBus.fire(NotiData(id: iDContent));
      } else
        pushPage(
            context,
            ManagerReceivingLimestoneDetailScreen(
              managerReceivingLimestone:
                  ManagerReceivingLimestone(iD: iDContent),
            ));
      return;
    }
    //TODO END TCP Module 8-1-2022

    //
    // if (NotificationType.instance.isNoNavigation(type)) {
    //   return;
    // }

    // Nếu không có type tương ứng nào thì mở url webview
    _openWebView(context, notificationInfo.link);
  }

  _openWebView(context, link) async {
    // var root =
    //     await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
    // String token = await SharedPreferencesClass.getToken();
    // print("_openWebView = ${root + link + "&Token=${token ?? ""}"}");
    // if (hasScreen((WebViewScreen).toString())) {
    //   eventBus.fire(NotiData(link: root + link + "&Token=${token ?? ""}"));
    // } else
    //   pushPage(context,
    //       WebViewScreen(false, url: root + link + "&Token=${token ?? ""}"));
  }

  // dành cho quản lý tài liệu
  _showFile(DocChildItem item, BuildContext context, bool isShared,
      {String passWord}) async {
    // CheckDownloadFileRequest request = CheckDownloadFileRequest();
    // request.idDoc = item.iD;
    // request.accessSafePassword = passWord;
    // ListStorageRepository _listStorageRepository = ListStorageRepository();
    // bool status = await _listStorageRepository.checkBeforeDownloadFile(request,
    //     isShared: isShared);
    // if (status) {
    //   FileUtils.instance.downloadFileAndOpen(item.name, item.path, context,
    //       typeExtension: item.typeExtension);
    // } else if (!status && _listStorageRepository.errorCode == 1002) {
    //   CustomDialogWidget(context, DialogGetPassWordScreen(
    //     onGetPassListener: (String passWord) async {
    //       _showFile(item, context, isShared, passWord: passWord);
    //     },
    //   )).show();
    // }
  }
}

class NotiData {
  int id;
  String link;
  int typeInt;
  int typeStorage;

  int type;
  DocChildItem item;

  NotiData(
      {this.id,
      this.link,
      this.typeInt,
      this.typeStorage,
      this.type,
      this.item});
}
