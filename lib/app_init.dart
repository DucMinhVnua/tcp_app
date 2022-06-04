import 'package:after_layout/after_layout.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';

import 'base/ui/loading_dialog.dart';
import 'common/utils/screen_utils.dart';
import 'models/auth_repository.dart';
import 'tpc/screens/main/home_screen.dart';
import 'tpc/screens/main/login_screen.dart';
import 'tpc/screens/main/splash_screen.dart';

LoadingDialog loadingDialog;
EventBus eventBus = EventBus();
//
// StreamSubscription loginSubscription;
// bool isResumed = false;
// IO.Socket socket;
const platform = const MethodChannel(Constant.CHANNEL);
// GlobalKey mainGlobalKey = GlobalKey<NavigatorState>();
// BuildContext homeContext;
List<String> screenStacks = [];
// AppLifecycleState appState;

class AppInit extends StatefulWidget {
  const AppInit();

  @override
  _AppInitState createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> with AfterLayoutMixin {
  Map appConfig = {};

  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp().then((value) {
    //   FirebaseCrashlytics.instance
    //       .setCrashlyticsCollectionEnabled(kReleaseMode);
    //   Function originalOnError = FlutterError.onError;
    //   FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    //     await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    //     originalOnError(errorDetails);
    //   };
    // });
    loadingDialog = LoadingDialog.getInstance(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, AuthRepository auth, _) {
        switch (auth.loggedInStatus) {
          case CurrentStatus.Uninitialized:
            return SplashScreen();
          case CurrentStatus.Unauthenticated:
          case CurrentStatus.Authenticating:
            return LoginScreen();
          case CurrentStatus.Authenticated:
            return HomeScreen();
          default:
            {
              return Container();
            }
        }
      },
    );
  }

  // Brings functionality to execute code after the first layout of a widget has been performed,
  // i.e. after the first frame has been displayed.
  @override
  void afterFirstLayout(BuildContext context) {
    ScreenUtil.init(context);
  }
}
