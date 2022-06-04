import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_command_add_member_screen.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_command_add_sequence_screen.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_command_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_sheet_add_member_screen.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_sheet_add_work_place_screen.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_sheet_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/electrical_safety/work_sheet_screen.dart';
import 'package:workflow_manager/tpc/screens/main/home_screen.dart';
import 'package:workflow_manager/tpc/screens/main/login_screen.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_limestone_create_receipt_screen.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_limestone_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_limestone_screen.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_oil_create_receipt_screen.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_oil_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/manager_receiving/manager_receiving_oil_screen.dart';
import 'package:workflow_manager/tpc/screens/manipulation_sheet/manipulation_sheet_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/manipulation_sheet/manipulation_sheet_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_command_add_member_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_command_add_diary_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_command_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_command_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_sheet_add_member_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_sheet_add_work_place_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_sheet_detail_screen.dart';
import 'package:workflow_manager/tpc/screens/mechanical_safety/mechanical_work_sheet_screen.dart';
import 'package:workflow_manager/tpc/screens/other/filter_screen.dart';
import 'package:workflow_manager/tpc/screens/reception/reception_contracts_screen.dart';
import 'package:workflow_manager/tpc/screens/reception/reception_no_contracts_screen.dart';

import '../tpc/screens/electrical_safety/work_command_screen.dart';

class RouteList {
  static const String home = 'home';
  static const String login = 'login';
  static const String filter = 'filter';
  //MODULE 1
  static const String electrical_safety_work_commands = 'electrical_safety_work_commands';
  static const String electrical_safety_work_command_detail = 'electrical_safety_work_command_detail';
  static const String electrical_safety_work_command_add_member = 'electrical_safety_work_command_add_member';
  static const String electrical_safety_work_command_add_sequence = 'electrical_safety_work_command_add_sequence';

  //MODULE 2
  static const String electrical_safety_work_sheets = 'electrical_safety_work_sheets';
  static const String electrical_safety_work_sheet_detail = 'electrical_safety_work_sheet_detail';
  static const String electrical_safety_work_sheet_add_member = 'electrical_safety_work_sheet_add_member';
  static const String electrical_safety_work_sheet_add_work_place = 'electrical_safety_work_sheet_add_work_place';

  //MODULE 3
  static const String mechanical_safety_work_commands = 'mechanical_safety_work_commands';
  static const String mechanical_safety_work_command_detail = 'mechanical_safety_work_command_detail';
  static const String mechanical_safety_work_command_add_member = 'mechanical_safety_work_command_add_member';
  static const String mechanical_safety_work_command_add_diary = 'mechanical_safety_work_command_add_diary';

  //MODULE 4
  static const String mechanical_safety_work_sheets = 'mechanical_safety_work_sheets';
  static const String mechanical_safety_work_sheet_detail = 'mechanical_safety_work_sheet_detail';
  static const String mechanical_safety_work_sheet_add_member = 'mechanical_safety_work_sheet_add_member';
  static const String mechanical_safety_work_sheet_add_work_place = 'mechanical_safety_work_sheet_add_work_place';

  //MODULE 5
  static const String manipulation_sheets = 'manipulation_sheets';
  static const String manipulation_sheet_detail = 'manipulation_sheet_detail';

  //MODULE 6
  static const String manager_receiving_oil = 'manager_receiving_oil';
  static const String manager_receiving_oil_detail = 'manager_receiving_oil_detail';
  static const String manager_receiving_oil_create_receipt = 'manager_receiving_oil_create_receipt';

  //MODULE 7
  static const String manager_receiving_limestone = 'manager_receiving_lime';
  static const String manager_receiving_limestone_detail = 'manager_receiving_limestone_detail';
  static const String manager_receiving_limestone_create_receipt = 'manager_receiving_limestone_create_receipt';

  //MODULE 8
  static const String reception_contracts = 'reception_contracts';
  //MODULE 9
  static const String reception_no_contracts = 'reception_no_contracts';
}

class Routes {
  static Map<String, WidgetBuilder> getAll() => _routes;

  static Route getRouteGenerate(RouteSettings settings) =>
      _routeGenerate(settings);

  static final Map<String, WidgetBuilder> _routes = {
    RouteList.home: (context) => HomeScreen(),
    RouteList.login: (context) => LoginScreen(),
    RouteList.electrical_safety_work_commands: (context) => WorkCommandScreen(),
    RouteList.electrical_safety_work_sheets: (context) => WorkSheetScreen(),
    RouteList.mechanical_safety_work_commands: (context) => MechanicalWorkCommandScreen(),
    RouteList.mechanical_safety_work_sheets: (context) => MechanicalWorkSheetScreen(),
    RouteList.manipulation_sheets: (context) => ManipulationSheetScreen(),
    RouteList.manager_receiving_oil: (context) => ManagerReceivingOilScreen(),
    RouteList.manager_receiving_limestone: (context) => ManagerReceivingLimestoneScreen(),
    RouteList.manager_receiving_oil_create_receipt: (context) => ManagerReceivingOilCreateReceiptScreen(),
    RouteList.manager_receiving_limestone_create_receipt: (context) => ManagerReceivingLimestoneCreateReceiptScreen(),
    RouteList.reception_contracts: (context) => ReceptionContractsScreen(),
    RouteList.reception_no_contracts: (context) => ReceptionNoContractsScreen(),
  };

  static Route _routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.filter:
        final arguments = settings.arguments;
        if (arguments is FilterPushArguments) {
          return _buildRoute(
            settings,
            (_) => FilterScreen(
              pushScreen: arguments.pushScreen,
            ),
          );
        }
        return _errorRoute();

      case RouteList.electrical_safety_work_command_detail:
        final arguments = settings.arguments;
        if (arguments is WorkCommandArguments) {
          return _buildRoute(
            settings,
            (_) => WorkCommandDetailScreen(
              workCommand: arguments.workCommand,
            ),
          );
        }
        return _errorRoute();

      case RouteList.electrical_safety_work_command_add_member:
        final arguments = settings.arguments;
        if (arguments is WorkCommandArguments) {
          return _buildRoute(
            settings,
                (_) => WorkCommandAddMemberScreen(
              workCommand: arguments.workCommand,
            ),
          );
        }
        return _errorRoute();

      case RouteList.electrical_safety_work_command_add_sequence:
        final arguments = settings.arguments;
        if (arguments is WorkCommandArguments) {
          return _buildRoute(
            settings,
            (_) => WorkCommandAddSequenceScreen(
              workCommand: arguments.workCommand,
            ),
          );
        }
        return _errorRoute();

      case RouteList.electrical_safety_work_sheet_detail:
        final arguments = settings.arguments;
        if (arguments is WorkSheetArguments) {
          return _buildRoute(
            settings,
                (_) => WorkSheetDetailScreen(
              workSheet: arguments.workSheet,
            ),
          );
        }
        return _errorRoute();

      case RouteList.electrical_safety_work_sheet_add_member:
        final arguments = settings.arguments;
        if (arguments is WorkSheetArguments) {
          return _buildRoute(
            settings,
                (_) => WorkSheetAddMemberScreen(
              workSheet: arguments.workSheet,
            ),
          );
        }
        return _errorRoute();

      case RouteList.electrical_safety_work_sheet_add_work_place:
        final arguments = settings.arguments;
        if (arguments is WorkSheetArguments) {
          return _buildRoute(
            settings,
            (_) => WorkSheetAddWorkPlaceScreen(
              workSheet: arguments.workSheet,
            ),
          );
        }
        return _errorRoute();

      case RouteList.mechanical_safety_work_command_detail:
        final arguments = settings.arguments;
        if (arguments is MechanicalWorkCommandArguments) {
          return _buildRoute(
            settings,
                (_) => MechanicalWorkCommandDetailScreen(
              mechanicalWorkCommand: arguments.mechanicalWorkCommand,
            ),
          );
        }
        return _errorRoute();

      case RouteList.mechanical_safety_work_command_add_member:
        final arguments = settings.arguments;
        if (arguments is MechanicalWorkCommandArguments) {
          return _buildRoute(
            settings,
                (_) => MechanicalWorkCommandAddMemberScreen(
                  mechanicalWorkCommand: arguments.mechanicalWorkCommand,
            ),
          );
        }
        return _errorRoute();

      case RouteList.mechanical_safety_work_command_add_diary:
        final arguments = settings.arguments;
        if (arguments is MechanicalWorkCommandArguments) {
          return _buildRoute(
            settings,
                (_) => MechanicalWorkCommandAddDiaryScreen(
                  mechanicalWorkCommand: arguments.mechanicalWorkCommand,
            ),
          );
        }
        return _errorRoute();

      case RouteList.mechanical_safety_work_sheet_detail:
        final arguments = settings.arguments;
        if (arguments is MechanicalWorkSheetArguments) {
          return _buildRoute(
            settings,
                (_) => MechanicalWorkSheetDetailScreen(
                  mechanicalWorkSheet: arguments.mechanicalWorkSheet,
            ),
          );
        }
        return _errorRoute();

      case RouteList.mechanical_safety_work_sheet_add_member:
        final arguments = settings.arguments;
        if (arguments is MechanicalWorkSheetArguments) {
          return _buildRoute(
            settings,
                (_) => MechanicalWorkSheetAddMemberScreen(
                  mechanicalWorkSheet: arguments.mechanicalWorkSheet,
            ),
          );
        }
        return _errorRoute();

      case RouteList.mechanical_safety_work_sheet_add_work_place:
        final arguments = settings.arguments;
        if (arguments is MechanicalWorkSheetArguments) {
          return _buildRoute(
            settings,
            (_) => MechanicalWorkSheetAddWorkPlaceScreen(
              mechanicalWorkSheet: arguments.mechanicalWorkSheet,
            ),
          );
        }
        return _errorRoute();

      case RouteList.manager_receiving_oil_detail:
        final arguments = settings.arguments;
        if (arguments is ManagerReceivingOilArguments) {
          return _buildRoute(
            settings,
                (_) => ManagerReceivingOilDetailScreen(
                managerReceivingOil: arguments.managerReceivingOil,
            ),
          );
        }
        return _errorRoute();

      case RouteList.manager_receiving_limestone_detail:
        final arguments = settings.arguments;
        if (arguments is ManagerReceivingLimestoneArguments) {
          return _buildRoute(
            settings,
                (_) => ManagerReceivingLimestoneDetailScreen(
              managerReceivingLimestone: arguments.managerReceivingLimestone,
            ),
          );
        }
        return _errorRoute();

      case RouteList.manipulation_sheet_detail:
        final arguments = settings.arguments;
        if (arguments is ManipulationSheetArguments) {
          return _buildRoute(
            settings,
            (_) => ManipulationSheetDetailScreen(
              manipulationSheet: arguments.manipulationSheet,
            ),
          );
        }
        return _errorRoute();

      default:
        final allRoutes = {
          ...getAll(),
        };
        if (allRoutes.containsKey(settings.name)) {
          return _buildRoute(
            settings,
            allRoutes[settings.name],
          );
        }
        return _errorRoute();
    }
  }

  static WidgetBuilder getRouteByName(String name) {
    if (_routes.containsKey(name) == false) {
      return _routes[RouteList.login];
    }
    return _routes[name];
  }

  static Route _errorRoute([String message = 'Page not founds']) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(message),
        ),
      );
    });
  }

  static PageRouteBuilder _buildRouteFade(
    RouteSettings settings,
    Widget builder,
  ) {
    return _FadedTransitionRoute(
      settings: settings,
      widget: builder,
    );
  }

  static MaterialPageRoute _buildRoute(
      RouteSettings settings, WidgetBuilder builder,
      {bool fullscreenDialog = false}) {
    return MaterialPageRoute(
      settings: settings,
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({this.widget, this.settings})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
}
