import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workflow_manager/base/utils/base_sharepreference.dart';

import 'app.dart';
import 'common/constants/general.dart';

Future<void> main() async {
  printLog('[main] ===== START main.dart =======');
  WidgetsFlutterBinding.ensureInitialized();
  //  Do not to shows message check invalid type during debugging
  Provider.debugCheckInvalidValueType = null;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runZonedGuarded(() async {
    /// Checks if shared preference exist
    try {
      await SharedPreferencesClass.getValue(SharedPreferencesClass.INITIALIZE);
    } catch (err) {
      /// setMockInitialValues initiates shared preference
      /// Adds app-name
      SharedPreferences.setMockInitialValues({});
      SharedPreferencesClass.saveValue(SharedPreferencesClass.INITIALIZE, 'true');
    }
    /// enable network traffic logging
    HttpClient.enableTimelineLogging = true;
    /// Lock portrait mode.shared_preferences: ^
    // unawaited(
    //     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
    // SystemChrome.setSystemUIOverlayStyle(
    //   // change status bar color
    //   SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    // );
    runApp(App());
  }, (e, stack) {
    printLog(e);
    printLog(stack);
  });
}