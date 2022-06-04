import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/ui/svg_image.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/models/auth_repository.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });
    // controller.repeat();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _authRepository.getConfigApp();
      Future.delayed(const Duration(milliseconds: 300), () {
        final auth = Provider.of<AuthRepository>(context, listen: false);
        auth.validateToken();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: "40BFFF".toColor(),
        child: SafeArea(
          child: Stack(
            children: [
              Center(child: SVGImage(svgName: 'white_icon')),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: SizedBox(
                  width: 134,
                  height: 3,
                  child: LinearProgressIndicator(
                    value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                    backgroundColor: "50ffffff".toColor(),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
