import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReceptionNoContractsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReceptionNoContractsScreenState();
  }
}

class _ReceptionNoContractsScreenState
    extends State<ReceptionNoContractsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Text("ReceptionNoContractsScreen"),
          ),
        ),
      ),
    );
  }
}
