import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/ui/svg_image.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/app_store.dart';
import 'package:workflow_manager/base/utils/base_sharepreference.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/base/utils/palette.dart';

import '../../../models/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;

  String copyRight;

  String version = "";

  String iconBiometrics = "assets/images/face_id.png";
  bool isHasBiometric = false;
  bool isCloudApi = false;
  FocusNode userNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // SocketManager().logoutSocket();
    _getVersion();
    SharedPreferencesClass.get(SharedPreferencesClass.IS_CLOUD_API)
        .then((value) {
      isCloudApi = value ?? false;
    });
    if (isInDebugMode) {
      nameController.text = "LiemNT";
      passwordController.text = "123456";
    }
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  bool get isInDebugMode {
    return kDebugMode;
  }

  _authenticateBiometrics(AuthRepository auth) async {
    var hasFaceId =
        await SharedPreferencesClass.get(SharedPreferencesClass.FACE_ID_KEY);
    if (isNullOrEmpty(hasFaceId) || !hasFaceId) {
      ToastMessage.show(
          "Bạn cần cài đặt để cho phép sử dụng Face ID và Touch ID",
          ToastStyle.error);
      return;
    }
    final isAuthenticated = await auth.authenticate();
    if (isAuthenticated) {
      var userName =
          await SharedPreferencesClass.get(SharedPreferencesClass.USER_NAME);
      var passWord =
          await SharedPreferencesClass.get(SharedPreferencesClass.PASS_WORD);
      if (isNullOrEmpty(userName)) {
        ToastMessage.show(
            'Tên tài khoản không được để trống', ToastStyle.error);
        return;
      }

      if (isNullOrEmpty(passWord)) {
        ToastMessage.show('Mật khẩu không được để trống', ToastStyle.error);
        return;
      }
      auth.login(context, userName, passWord);
    }
  }

  _eventLogin(AuthRepository auth) {
    if (nameController.text.isEmpty) {
      ToastMessage.show('Tên tài khoản không được để trống', ToastStyle.error);
      return;
    }

    if (passwordController.text.isEmpty) {
      ToastMessage.show('Mật khẩu không được để trống', ToastStyle.error);
      return;
    }
    // userNameFocusNode.requestFocus();
    auth.login(context, nameController.text, passwordController.text);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthRepository>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      child: SizedBox(
                        width: 140,
                        height: 140,
                        child: SVGImage(svgName: "logo_app"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: TextField(
                        focusNode: userNameFocusNode,
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Tên tài khoản',
                          enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Palette.borderEditText.toColor())),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: SVGImage(
                              svgName: "ic_user",
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          // enabledBorder: new UnderlineInputBorder(
                          //     borderSide: BorderSide(
                          //         color: Palette.borderEditText.toColor())),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: SVGImage(
                              svgName: "ic_pass",
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye_outlined,
                              color: this._showPassword
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() =>
                                  this._showPassword = !this._showPassword);
                            },
                          ),
                        ),
                        obscureText: !this._showPassword,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 32),
                      width: double.infinity,
                      child: ButtonTheme(
                        height: 50,
                        child: FlatButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textColor: Colors.white,
                          child: Text(
                            'Đăng nhập'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _eventLogin(auth);
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        isCloudApi = !isCloudApi;
                        SharedPreferencesClass.save(
                            SharedPreferencesClass.IS_CLOUD_API, isCloudApi);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              margin: EdgeInsets.only(right: 16),
                              child: Checkbox(
                                value: isCloudApi,
                              ),
                            ),
                            Text("Phiên bản cloud")
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isHasBiometric,
                      child: InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 4),
                            width: 44,
                            height: 44,
                            child: Image(
                              image: AssetImage(iconBiometrics),
                            )),
                        onTap: () {
                          _authenticateBiometrics(auth);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              alignment: Alignment.bottomCenter,
              child: Text(
                "v${version} - copyright © ${AppStore.copyRight}",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
