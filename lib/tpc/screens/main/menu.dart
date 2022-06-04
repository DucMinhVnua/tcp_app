import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/models/auth_repository.dart';

class MenuBar extends StatefulWidget {
  final GlobalKey<NavigatorState> navigation;
  final StreamController<String> controllerRouteWeb;

  MenuBar({this.navigation, this.controllerRouteWeb});

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Center(
              child: Text(
            'TCP APP',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        Card(
          child: ListTile(
            title: Text('Đăng xuất'),
            onTap: () {
              Provider.of<AuthRepository>(context, listen: false)
                  .logout(isTokenExpired: false);
            },
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }
}
