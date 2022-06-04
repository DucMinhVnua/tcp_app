import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReceptionContractsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReceptionContractsScreenState();
  }
}

class _ReceptionContractsScreenState extends State<ReceptionContractsScreen> {
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
            child: Text("ReceptionContractsScreen"),
          ),
        ),
      ),
    );
  }
}