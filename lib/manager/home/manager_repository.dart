// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:store_redirect/store_redirect.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:workflow_manager/base/network/api_caller.dart';
// import 'package:workflow_manager/base/network/app_url.dart';
// import 'package:workflow_manager/base/ui/confirm_dialog_widget.dart';
// import 'package:workflow_manager/base/utils/app_constant.dart';
// import 'package:workflow_manager/base/utils/app_store.dart';
// import 'package:workflow_manager/base/utils/base_sharepreference.dart';
// import 'package:workflow_manager/base/utils/common_function.dart';
// import 'package:workflow_manager/base/utils/file_utils.dart';
// import 'package:workflow_manager/manager/models/module.dart';
// import 'package:workflow_manager/manager/models/response/home_index_response.dart';
// import 'package:workflow_manager/manager/models/response/update_avatar_response.dart';
// import 'package:workflow_manager/storage/screens/tabs/main_tab_storage_screen.dart';
// import 'package:workflow_manager/tpc/models/response/login_response.dart';
// import 'package:workflow_manager/tpc/screens/group_job/group_task_tab_controller.dart';
// import 'package:workflow_manager/tpc/screens/statistic/main_statistic_screen.dart';
// import 'package:workflow_manager/tpc/screens/tasks/main_workflow_screen.dart';
//
// import '../../base/network/api_caller.dart';
// import '../../main.dart';
//
// class ManagerRepository extends ChangeNotifier {
//   ApiCaller apiCaller = ApiCaller.instance;
//
//   HomeIndexData homeIndexData;
//
//   String copyRight;
//
//   String message;
//
//   final picker = ImagePicker();
//
//   Future<void> getHomeIndex(
//       {bool isShowLoading = true, bool isRunBackground = false}) async {
//     // FlutterAppBadger.removeBadge();
//     final response = await apiCaller.postFormData(
//         AppUrl.homeIndex, new Map<String, dynamic>(),
//         isLoading: isShowLoading);
//
//     final HomeIndexResponse homeIndexResponse =
//         HomeIndexResponse.fromJson(response);
//     if (homeIndexResponse.isSuccess(
//         isDontShowErrorMessage: isShowLoading != true)) {
//       homeIndexData = homeIndexResponse.data;
//       AppStore.homeIndexData = homeIndexData;
//       AppStore.countNotify = homeIndexData.unreadNotification;
//       String root =
//           await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
//       if (!homeIndexData.user.avatar.contains(root)) {
//         homeIndexData.user.avatar = "${root}${homeIndexData.user.avatar}";
//       } else {
//         homeIndexData.user.avatar = "${homeIndexData.user.avatar}";
//       }
//       await SharedPreferencesClass.saveUser(homeIndexData.user);
//       await SharedPreferencesClass.save(
//           SharedPreferencesClass.UNREADNOTIFICATION,
//           homeIndexData.unreadNotification);
//       notifyListeners();
//       if (homeIndexData.unreadNotification >= 1) {
//         FlutterAppBadger.updateBadgeCount(homeIndexData.unreadNotification);
//       } else {
//         FlutterAppBadger.removeBadge();
//       }
//     }
//   }
//
//   Future<List<Module>> getListModule() async {
//     List<Module> arrayModule = List();
//     if (isNullOrEmpty(homeIndexData)) {
//       return arrayModule;
//     }
//     // if (homeIndexData.isMyFile) {
//     //   arrayModule.add(Module("TLCN", "Tài liệu cá nhân", "my_file"));
//     // }
//     // arrayModule.add(Module("TLCS", "Tài liệu chia sẻ cho bạn", "my_file"));
//     if (homeIndexData.isQLTL) {
//       arrayModule.add(Module("KDL", "Kho dữ liệu", "ic_store"));
//     }
//     // if (homeIndexData.isQLKH) {
//     //   arrayModule.add(Module("QLKH", "Quản lý khách hàng", "cust"));
//     // }
//     // if (homeIndexData.isQLKD) {
//     //   arrayModule.add(Module("QLKD", "Quản lý kinh doanh", "equip"));
//     // }
//     // arrayModule.add(Module("TI", "Tiện ích", "task"));
//     // if(homeIndexData.isQLNS) {
//     //   arrayModule.add(Module("HRM", "Quản lý nhân sự", "icon_qlms"));
//     // }
//     if (homeIndexData.isQLCV) {
//       arrayModule.add(Module("CV", "Công việc", "ic_work"));
//     }
//     if (homeIndexData.isStgBorrow) {
//       arrayModule.add(Module("MTTL", "Mượn trả tài liệu", "ic_borrow"));
//     }
//     // arrayModule.add(Module("TIENICH", "Tiện ích", "option"));
//     // arrayModule.add(Module("BCTK", "Báo cáo thống kê", "sale"));
//     // if (homeIndexData.isQLVB) {
//     //   arrayModule.add(Module("QLVB", "Quản lý văn bản", "equip"));
//     // }
//     if (homeIndexData.isQLKD) {
//       arrayModule.add(Module("QLKD", "Quản lý kinh doanh", "ic_business"));
//     }
//     if (homeIndexData.isQLQTTT) {
//       arrayModule.add(Module("QTTT", "Quy trình thủ tục", "ic_qttt"));
//     }
//     // if (homeIndexData.isQLDA) {
//     //   arrayModule.add(Module("QLDA", "Quản lý dự án", "icon-du-an"));
//     // }
//     if (homeIndexData.isQLMS) {
//       arrayModule.add(Module("QLMS", "Quản lý mua sắm", "ic_bought"));
//     }
//     String root = await SharedPreferencesClass.getBaseUrl();
//     if (root.toLowerCase().contains("api-fsi")) {
//       arrayModule.add(Module("ELEARNING", "E-Learning", "elearning"));
//     }
//
//     if (homeIndexData.isKHTT == true) {
//       arrayModule.add(Module("OKR", "Quản lý OKRs", "ic_okr"));
//     }
//     return arrayModule;
//   }
//
//   navigationModules(BuildContext context, String moduleId) {
//     switch (moduleId) {
//       case "CV":
//         // check theo thứ tư ưu tiên nhé : JobAccess -> GroupAccess -> ReportAccess
//         if (homeIndexData.jobPermission == null ||
//             homeIndexData.jobPermission.isJobAccess)
//           pushPage(context, MainWorkflowScreen());
//         else if (homeIndexData.jobPermission.isGroupAccess)
//           pushPage(context, GroupTaskTabController());
//         else
//           pushPage(context, MainStatisticScreen());
//         break;
//       case "KDL":
//         pushPage(context, MainTabStorageScreen());
//         break;
//     }
//   }
//
//   // upload profile when use capture
//   Future<User> updateAvatarProfile(String pathFile) async {
//     var params = {
//       "File": await MultipartFile.fromFile(pathFile,
//           filename: FileUtils.instance.getFileName(pathFile)),
//       'IsMobile': '1'
//     };
//     var response =
//         await ApiCaller.instance.uploadFile(AppUrl.updateProfile, params);
//     UpdateAvatarResponse updateAvatarResponse =
//         UpdateAvatarResponse.fromJson(response);
//     if (updateAvatarResponse.status == 1) {
//       String root =
//           await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
//       String avatar = updateAvatarResponse.data.userDocPro.avatar;
//       User user = await SharedPreferencesClass.getUser();
//       if (!avatar.contains(root)) {
//         user.avatar = "${root}${avatar}";
//       } else {
//         user.avatar = "${avatar}";
//       }
//       await SharedPreferencesClass.saveUser(user);
//       return user;
//     } else {
//       message = updateAvatarResponse.messages;
//       return null;
//     }
//   }
//
//   // upload profile when get image form sdcard
//   Future<User> updateAvatarProfileFromSDCard() async {
//     // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);
//     final result = await picker.getImage(source: ImageSource.gallery);
//     if (result != null) {
//       var pathFile = result.path;
//       var params = {
//         "File": await MultipartFile.fromFile(pathFile,
//             filename: FileUtils.instance.getFileName(pathFile)),
//         'IsMobile': '1'
//       };
//       var response =
//           await ApiCaller.instance.uploadFile(AppUrl.updateProfile, params);
//       UpdateAvatarResponse updateAvatarResponse =
//           UpdateAvatarResponse.fromJson(response);
//       if (updateAvatarResponse.status == 1) {
//         String root =
//             await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
//         String avatar = updateAvatarResponse.data.userDocPro.avatar;
//         User user = await SharedPreferencesClass.getUser();
//         if (!avatar.contains(root)) {
//           user.avatar = "${root}${avatar}";
//         } else {
//           user.avatar = "${avatar}";
//         }
//         await SharedPreferencesClass.saveUser(user);
//         return user;
//       } else {
//         message = updateAvatarResponse.messages;
//       }
//     }
//     return null;
//   }
//
//   openIOSApp(BuildContext context) async {
//     if (await canLaunch("doceye://")) {
//       await launch("doceye://");
//     } else {
//       ConfirmDialogFunction(
//         context: context,
//         content: "Bạn cần cài đặt ứng dụng Doceye để thực hiện chức năng này.",
//         onAccept: () {
//           StoreRedirect.redirect(
//               androidAppId: "vn.com.fsivietnam.docpro.docpro",
//               iOSAppId: "1461435425"); //iOSAppId của Doceye
//         },
//       ).showConfirmDialog();
//     }
//   }
//
//   openAndroidApp() async {
//     var params = <String, dynamic>{"from": "Flutter"};
//     String message;
//     try {
//       message = await platform.invokeMethod(Constant.QLCV_PARAM_KEY, params);
//       print(message);
//     } on PlatformException catch (e) {
//       message = "Failed to get data from native : '${e.message}'.";
//     }
//   }
//
//   @override
//   void notifyListeners() {
//     super.notifyListeners();
//   }
// }
