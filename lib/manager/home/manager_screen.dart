// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'package:workflow_manager/base/extension/string.dart';
// import 'package:workflow_manager/base/ui/bottom_sheet_dialog.dart';
// import 'package:workflow_manager/base/ui/confirm_dialog_widget.dart';
// import 'package:workflow_manager/base/ui/save_button.dart';
// import 'package:workflow_manager/base/ui/svg_image.dart';
// import 'package:workflow_manager/base/ui/toast_view.dart';
// import 'package:workflow_manager/base/utils/app_constant.dart';
// import 'package:workflow_manager/base/utils/app_store.dart';
// import 'package:workflow_manager/base/utils/base_sharepreference.dart';
// import 'package:workflow_manager/base/utils/choice_dialog/choice_dialog.dart';
// import 'package:workflow_manager/base/utils/common_function.dart';
// import 'package:workflow_manager/base/utils/one_signal_manager.dart';
// import 'package:workflow_manager/manager/auth/auth_repository.dart';
// import 'package:workflow_manager/manager/auth/change_password_screen.dart';
// import 'package:workflow_manager/manager/auth/update_profile_screen.dart';
//
// // import 'package:workflow_manager/manager/home/log_file.dart';
// import 'package:workflow_manager/manager/models/events/update_image_event.dart';
// import 'package:workflow_manager/manager/models/module.dart';
//
// // import 'package:workflow_manager/manager/models/response/update_profile_response.dart';
// import 'package:workflow_manager/manager/models/events/update_image_event.dart';
// import 'package:workflow_manager/manager/models/module.dart';
// import 'package:workflow_manager/manager/models/response/update_profile_response.dart';
// import 'package:workflow_manager/manager/widgets/document_statistics_widget.dart';
// import 'package:workflow_manager/manager/widgets/profile_view.dart';
// import 'package:workflow_manager/manager/widgets/progress_statistics_widget.dart';
// import 'package:workflow_manager/manager/widgets/project_progress_widget.dart';
// import 'package:workflow_manager/manager/widgets/staff_statistics_widget.dart';
// import 'package:workflow_manager/tpc/models/response/login_response.dart';
// import 'package:workflow_manager/tpc/models/response/pair_reponse.dart';
// import 'package:workflow_manager/tpc/screens/notification/notification_screen.dart';
//
// import '../../main.dart';
// import 'manager_repository.dart';
//
// class ManagerScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ManagerScreenState();
//   }
// }
//
// class _ManagerScreenState extends State<ManagerScreen>
//     with WidgetsBindingObserver {
//   ManagerRepository _managerRepository = ManagerRepository();
//
//   AuthRepository _authRepository;
//
//   PageController controller = PageController();
//
//   String _image;
//
//   bool isSwitched = false;
//
//   final picker = ImagePicker();
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   List<Widget> _listHeader = [
//     new ProfileView(),
//     new StaffStatisticsWidget(),
//     new ProjectProgressWidget(),
//     new DocumentStatisticsWidget(),
//     new ProgressStatisticsWidget()
//   ];
//
//   int _curr = 0;
//
//   List<Module> _arrayModule = List();
//   StreamSubscription _dataNumberNotification;
//   User user;
//   bool isVisible = false;
//   bool isNeedRecallApi = false;
//   bool isInitCalled = false;
//   bool isCallingApi = false;
//
//   // _getUserLogin() async {
//   //   ProfileDetailModel user = await _authRepository.getProfile();
//   //   if(this.user==null)
//   //     this.user=User();
//   //   this.user.birthday = user.userDocPro.birthday;
//   //   this.user.gender = user.userDocPro.gender;
//   //   this.user.name = user.userDocPro.name;
//   //   this.user.address = user.userDocPro.address;
//   //   this.user.avatar = user.userDocPro.avatar;
//   //   this.user.email = user.userDocPro.email;
//   //   this.user.phone = user.userDocPro.phone;
//   //   String root =
//   //       await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
//   //   if (!user.userDocPro.avatar.contains(root)) {
//   //     this.user.avatar = "${root}/${user.userDocPro.avatar}";
//   //   } else {
//   //     this.user.avatar = "${user.userDocPro.avatar}";
//   //   }
//   //   await SharedPreferencesClass.saveUser(this.user);
//   //   _managerRepository.notifyListeners();
//   // }
//
//   _getData() async {
//     await getDataHome();
//     isSwitched =
//         await SharedPreferencesClass.get(SharedPreferencesClass.FACE_ID_KEY);
//     if (isSwitched == null) isSwitched = true;
//     Future.delayed(const Duration(milliseconds: 500), () async {
//       _authRepository.listenerNavigationAppLink(context);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _authRepository = Provider.of<AuthRepository>(context, listen: false);
//     isInitCalled = true;
//     _getData();
//     OneSignalManager.instance.initOneSignal(context);
//     if (isNotNullOrEmpty(_dataNumberNotification))
//       _dataNumberNotification.cancel();
//     _dataNumberNotification =
//         eventBus.on<EventBusSendNumberNotificaiton>().listen((event) {
//       setState(() {
//         if (event.number == 1)
//           AppStore.countNotify = AppStore.countNotify - 1;
//         else
//           AppStore.countNotify = 0;
//         FlutterAppBadger.updateBadgeCount(AppStore.countNotify);
//         SharedPreferencesClass.save(
//             SharedPreferencesClass.UNREADNOTIFICATION, AppStore.countNotify);
//       });
//     });
//     eventBus.on<OnAppResumed>().listen((event) async {
//       if (isInitCalled == true) {
//         isInitCalled = false;
//         return;
//       }
//       await SharedPreferencesClass.getToken();
//       if (isVisible) {
//         await getDataHome();
//       } else {
//         isNeedRecallApi = true;
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     if (isNotNullOrEmpty(_dataNumberNotification))
//       _dataNumberNotification.cancel();
//   }
//
//   Future displayImagePicker() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _image = pickedFile.path;
//       var result = await _managerRepository.updateAvatarProfile(_image);
//       if (result == null) {
//         ToastMessage.show(_managerRepository.message, ToastStyle.error);
//       }
//       _managerRepository.homeIndexData.user = result;
//       _managerRepository.notifyListeners();
//       eventBus.fire(UpdateProfileEvent());
//     }
//   }
//
//   void openImageBottomSheet() async {
//     BottomSheetDialog bottomSheetDialog = BottomSheetDialog(
//       context: context,
//       onTapListener: (item) async {
//         if (item.key == 1) {
//           displayImagePicker();
//         } else {
//           User result =
//               await _managerRepository.updateAvatarProfileFromSDCard();
//           if (result == null) {
//             if (isNotNullOrEmpty(_managerRepository.message))
//               ToastMessage.show(_managerRepository.message, ToastStyle.error);
//           } else {
//             _managerRepository.homeIndexData.user = result;
//             _managerRepository.notifyListeners();
//             eventBus.fire(UpdateProfileEvent());
//           }
//         }
//       },
//     );
//
//     List<Pair> listChoiceImages = [
//       Pair(key: 1, value: "Camera"),
//       Pair(key: 2, value: "Thư viện ảnh"),
//     ];
//     await bottomSheetDialog.showBottomSheetDialog(listChoiceImages);
//   }
//
//   Future<void> getDataHome() async {
//     isCallingApi = true;
//     await _managerRepository.getHomeIndex();
//     List<Module> arrayModule = await _managerRepository.getListModule();
//     isCallingApi = false;
//     setState(() {
//       _arrayModule = arrayModule;
//       AppStore.countNotify =
//           _managerRepository.homeIndexData?.unreadNotification;
//     });
//   }
//
//   SmoothPageIndicator _indicator() {
//     return SmoothPageIndicator(
//         controller: controller, // PageController
//         count: _listHeader.length,
//         effect: WormEffect(
//             dotHeight: 6.0,
//             dotWidth: 6.0,
//             spacing: 8.0,
//             dotColor: Colors.grey[500],
//             activeDotColor: Colors.blue), // your preferr
//         onDotClicked: (index) {});
//   }
//
//   _buildItemMenu(String avatar, String name,
//       {Widget widget, bool isNotSvg = false, VoidCallback callback}) {
//     return GestureDetector(
//       onTap: () {
//         if (callback != null) {
//           callback();
//           _scaffoldKey.currentState.openEndDrawer();
//         }
//       },
//       child: Container(
//         width: double.infinity,
//         color: Colors.white,
//         padding: EdgeInsets.only(left: 8),
//         height: 48,
//         child: Row(
//           children: [
//             SizedBox(
//               child: isNotSvg
//                   ? Image(
//                       image: AssetImage(avatar),
//                     )
//                   : FittedBox(child: SVGImage(svgName: avatar)),
//               width: 40,
//               height: 40,
//             ),
//             Expanded(child: Text(name)),
//             widget ?? Text("")
//           ],
//         ),
//       ),
//     );
//   }
//
//   Drawer _drawableMenu() {
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   Container(
//                     child: ClipRRect(
//                       // Clip it cleanly.
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                         child: Container(
//                           padding: EdgeInsets.only(left: 16),
//                           height: 170,
//                           color: isNotNullOrEmpty(user?.avatar)
//                               ? Colors.blue.withOpacity(0.7)
//                               : Colors.blue,
//                           alignment: Alignment.centerLeft,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Container(
//                                 width: 64,
//                                 height: 64,
//                                 padding: EdgeInsets.only(bottom: 8),
//                                 child: CircleAvatar(
//                                   backgroundImage:
//                                       NetworkImage(user?.avatar ?? ""),
//                                 ),
//                               ),
//                               Padding(
//                                   padding: EdgeInsets.only(bottom: 8),
//                                   child: Text(
//                                     user?.name ?? "",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 14),
//                                   )),
//                               Padding(
//                                   padding: EdgeInsets.only(bottom: 8),
//                                   child: Text(
//                                     user?.email ?? "",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 14),
//                                   ))
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(user?.avatar ?? ""),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 16),
//                   ),
//                   _buildItemMenu("ic_avatar", "Thay đổi ảnh đại diện",
//                       callback: () => {openImageBottomSheet()}),
//                   _buildItemMenu("edit_square", "Cập nhật thông tin cá nhân",
//                       callback: () async {
//                     var result = await pushPage(context, UpdateProfileScreen());
//                     if (result == true) {
//                       _managerRepository.homeIndexData.user =
//                           await SharedPreferencesClass.getUser();
//                       _managerRepository.notifyListeners();
//                     }
//                   }),
//                   _buildItemMenu("assets/images/face_id_menu.png",
//                       "Đăng nhập bằng Touch ID/Face ID",
//                       isNotSvg: true,
//                       widget: Switch(
//                         value: isSwitched,
//                         activeTrackColor: Colors.lightBlueAccent,
//                         activeColor: Colors.blue,
//                         onChanged: (value) {
//                           print("value = ${value}");
//                           SharedPreferencesClass.save(
//                               SharedPreferencesClass.FACE_ID_KEY, value);
//                           setState(() {
//                             isSwitched = !isSwitched;
//                           });
//                         },
//                       )),
//                   _buildItemMenu("ic_password", "Thay đổi mật khẩu",
//                       callback: () =>
//                           {pushPage(context, ChangePasswordScreen())}),
//                   _buildItemMenu("ic_logout", "Đăng xuất",
//                       callback: () => {logout()}),
//                 ],
//               ),
//             ),
//             _buildItemMenu("ic_open_fsi", "Mở ứng dụng FSI",
//                 callback: () => {
//                       if (Platform.isIOS)
//                         {_managerRepository.openIOSApp(context)}
//                       else if (Platform.isAndroid)
//                         {_managerRepository.openAndroidApp()}
//                     }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _getCrossAxisCount() {
//     if (_arrayModule.length == 1) return 1;
//     if (_arrayModule.length == 2) return 2;
//     return 3;
//   }
//
//   Widget _listModuleItem() {
//     return (isNullOrEmpty(_arrayModule) && !isCallingApi)
//         ? Center(
//             child: Align(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 40.0),
//                 child: SaveButton(
//                   isWrapContent: true,
//                   title: "Thử lại",
//                   onTap: () {
//                     _getData();
//                   },
//                 ),
//               ),
//             ),
//           )
//         : GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: _arrayModule.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: _getCrossAxisCount(),
//               childAspectRatio: 1,
//               crossAxisSpacing: 0,
//               mainAxisSpacing: 0,
//             ),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             itemBuilder: (BuildContext context, int index) {
//               return InkWell(
//                 child: Container(
//                   alignment: Alignment.center,
//                   child: ModuleItem(_managerRepository, _arrayModule[index]),
//                   color: Colors.white,
//                 ),
//               );
//             },
//           );
//   }
//
//   void logout() {
//     ConfirmDialogFunction dialog = ConfirmDialogFunction(
//       context: context,
//       content: "Xác nhận đăng xuất?",
//       acceptTitle: "Đăng xuất",
//       onAccept: () {
//         AuthRepository.logout();
//       },
//     );
//     dialog.showConfirmDialog();
//   }
//
//   _appbar() {
//     return SafeArea(
//       child: Container(
//         height: 44,
//         alignment: Alignment.centerLeft,
//         padding: EdgeInsets.only(left: 16, right: 16),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               alignment: Alignment.center,
//               child: Text(
//                 'L-IONE',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500),
//               ),
//             ),
//             Row(
//               children: [
//                 Container(
//                     alignment: Alignment.centerLeft,
//                     width: 40,
//                     height: 40,
//                     padding: EdgeInsets.all(8),
//                     child: SVGImage(
//                       svgName: 'menu_bar',
//                       onTap: () {
//                         _scaffoldKey.currentState.openDrawer();
//                       },
//                     )),
//                 Expanded(
//                   child: Container(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(
//                       child: Stack(
//                         alignment: Alignment.topRight,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               Icons.add_alert,
//                               color: Colors.white,
//                             ),
//                             iconSize: 24,
//                           ),
//                           Visibility(
//                             visible: isNullOrEmpty(AppStore.countNotify) ||
//                                     AppStore.countNotify <= 0
//                                 ? false
//                                 : true,
//                             child: Container(
//                               margin: const EdgeInsets.only(top: 8),
//                               padding: const EdgeInsets.only(
//                                   left: 4, top: 0, right: 4),
//                               decoration: BoxDecoration(
//                                   color: "FFA726".toColor(),
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(color: Colors.blueAccent)),
//                               child: Text(
//                                 AppStore.countNotify?.toString() ?? "",
//                                 style: TextStyle(
//                                     fontSize: 12, color: Colors.white),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       onTap: () {
//                         pushPage(context, NotificationScreen());
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: _managerRepository,
//       child: Consumer(
//         builder: (context, ManagerRepository _managerRepository, _) {
//           user = _managerRepository?.homeIndexData?.user;
//           return Scaffold(
//               key: _scaffoldKey,
//               drawer: _drawableMenu(),
//               body: VisibilityDetector(
//                 key: Key("callapi"),
//                 onVisibilityChanged: (info) async {
//                   isVisible = info.visibleFraction == 1;
//                   if (isVisible && isNeedRecallApi) {
//                     isNeedRecallApi = false;
//                     await getDataHome();
//                     user = _managerRepository.homeIndexData.user;
//                     _managerRepository.notifyListeners();
//                   }
//                 },
//                 child: SafeArea(
//                     top: false,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 300,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/bg_avatar.png'),
//                                     fit: BoxFit.fill)),
//                             child: Stack(
//                               children: [_appbar(), ProfileView()],
//                             ),
//                           ),
//                           Container(
//                               color: Colors.white,
//                               padding:
//                                   EdgeInsets.only(left: 16, top: 16, right: 16),
//                               child: _listModuleItem())
//                         ],
//                       ),
//                     )),
//               ));
//         },
//       ),
//     );
//   }
// }
//
// class ModuleItem extends StatelessWidget {
//   ManagerRepository _managerRepository;
//   Module _module;
//
//   ModuleItem(this._managerRepository, this._module);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         child: Column(
//           children: [
//             SizedBox(
//               width: 55,
//               height: 55,
//               child: SVGImage(
//                 svgName: _module.image,
//               ),
//             ),
//             Padding(
//                 padding: EdgeInsets.all(4),
//                 child: Text(
//                   _module.name,
//                   textAlign: TextAlign.center,
//                 ))
//           ],
//         ),
//         onTap: () {
//           _managerRepository.navigationModules(context, _module.id);
//         });
//   }
// }
//
// class Pages extends StatelessWidget {
//   final text;
//
//   Pages({this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               text,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ]),
//     );
//   }
// }
