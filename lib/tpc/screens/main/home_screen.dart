import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/base/utils/notification_model.dart';
import 'package:workflow_manager/base/utils/one_signal_manager.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:workflow_manager/routes/route.dart';

import 'menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return renderBody(context);
  }

  Widget renderBody(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TCP App modules'),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldKey,
        body: getListView(context),
        drawer: Drawer(child: MenuBar()),
      ),
    );
  }

  Widget getListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text(
                'Lệnh công tác an toàn điện',
                style: kDefaultTextStyle.copyWith(fontSize: 15),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteList.electrical_safety_work_commands);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text('Phiếu công tác an toàn điện',
                  style: kDefaultTextStyle.copyWith(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(
                    context, RouteList.electrical_safety_work_sheets);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text('Lệnh công tác an toàn cơ nhiệt hóa',
                  style: kDefaultTextStyle.copyWith(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(
                    context, RouteList.mechanical_safety_work_commands);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text('Phiếu công tác an toàn cơ nhiệt hóa',
                  style: kDefaultTextStyle.copyWith(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(
                    context, RouteList.mechanical_safety_work_sheets);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text('Phiếu thao tác',
                  style: kDefaultTextStyle.copyWith(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(context, RouteList.manipulation_sheets);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text('Quản lý tiếp nhận hồ sơ dầu',
                  style: kDefaultTextStyle.copyWith(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(context, RouteList.manager_receiving_oil);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text('Quản lý tiếp nhận hồ sơ đá vôi',
                  style: kDefaultTextStyle.copyWith(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(
                    context, RouteList.manager_receiving_limestone);
              },
            ),
          ),
          Visibility(
              visible: kDebugMode,
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(),
                  title: Text('Test push navigate',
                      style: kDefaultTextStyle.copyWith(fontSize: 15)),
                  onTap: () {
                    OneSignalManager.instance.navigationTargetScreen(
                        context,
                        NotificationInfos(
                          type: 5014,
                          iDContent: 1,
                        ));
                  },
                ),
              ))
        ],
      ),
    );
  }
}
