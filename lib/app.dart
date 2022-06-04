import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/models/account_model.dart';
import 'package:workflow_manager/models/manager_receiving_limestone_model.dart';
import 'package:workflow_manager/models/manager_receiving_oil_model.dart';
import 'package:workflow_manager/models/manipulation_sheet_model.dart';
import 'package:workflow_manager/models/mechanical_work_command_model.dart';
import 'package:workflow_manager/models/mechanical_work_sheet_model.dart';
import 'package:workflow_manager/models/reception_contracts_model.dart';
import 'package:workflow_manager/models/reception_no_contracts_model.dart';
import 'package:workflow_manager/models/work_sheet_model.dart';

import 'app_init.dart';
import 'common/constants.dart';
import 'models/auth_repository.dart';
import 'models/work_command_model.dart';
import 'routes/route.dart';
import 'routes/route_observer.dart';

GlobalKey mainGlobalKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> with WidgetsBindingObserver {
  final _auth = AuthRepository();
  final _account = AccountModel();
  final _workCommand = WorkCommandModel();
  final _workSheet = WorkSheetModel();
  final _mechanicalWorkCommand = MechanicalWorkCommandModel();
  final _mechanicalWorkSheet = MechanicalWorkSheetModel();
  final _manipulationSheet = ManipulationSheetModel();
  final _managerReceivingLimeStone = ManagerReceivingLimestoneModel();
  final _managerReceivingOil = ManagerReceivingOilModel();
  final _receptionContracts = ReceptionContractsModel();
  final _receptionNoContracts = ReceptionNoContractsModel();

  @override
  void initState() {
    printLog('[AppState] initState');
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printLog("[AppState] build");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthRepository>.value(value: _auth),
        ChangeNotifierProvider<AccountModel>.value(value: _account),
        ChangeNotifierProvider<WorkCommandModel>.value(value: _workCommand),
        ChangeNotifierProvider<WorkSheetModel>.value(value: _workSheet),
        ChangeNotifierProvider<MechanicalWorkCommandModel>.value(value: _mechanicalWorkCommand),
        ChangeNotifierProvider<MechanicalWorkSheetModel>.value(value: _mechanicalWorkSheet),
        ChangeNotifierProvider<ManipulationSheetModel>.value(value: _manipulationSheet),
        ChangeNotifierProvider<ManagerReceivingOilModel>.value(value: _managerReceivingOil),
        ChangeNotifierProvider<ManagerReceivingLimestoneModel>.value(value: _managerReceivingLimeStone),
        ChangeNotifierProvider<ReceptionContractsModel>.value(value: _receptionContracts),
        ChangeNotifierProvider<ReceptionNoContractsModel>.value(value: _receptionNoContracts),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: mainGlobalKey,
        // specify what locale we want our app to use
        // https://medium.com/saugo360/managing-locale-in-flutter-7693a9d4d6ac
        navigatorObservers: [
          // handle events related to screen transitions
          MyRouteObserver()
        ],
        home: AppInit(),
        routes: Routes.getAll(),
        onGenerateRoute: Routes.getRouteGenerate,
        theme: ThemeData(
          primaryColor: kColorPrimary,
          textTheme: buildTextTheme(),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
