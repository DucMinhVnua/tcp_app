import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/utils/palette.dart';

class LoadingDialog {
  static LoadingDialog _instance;

  var _lock = Lock();
  bool _isShowing = false;

  static LoadingDialog getInstance(BuildContext context) {
    if (_instance == null || context != _instance.context) {
      _instance = LoadingDialog(context);
    }
    return _instance;
  }

  int totalLoading = 0;

  BuildContext context;

  LoadingDialog(BuildContext context) {
    this.context = context;
  }

  show({bool isShowImmediate}) async {
    await _lock.synchronized(() async {
      totalLoading++;
      if (isShowImmediate == true) {
        if (!_isShowing) {
          _showLoading();
          _isShowing = true;
        }
      } else if (totalLoading == 1 && !_isShowing) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (totalLoading > 0 && !_isShowing) {
            // print("showloading show() real $totalLoading");
            //
            // showErrorToast("show loading ||hhhhhhh $totalLoading");
            _showLoading();
            _isShowing = true;
          }
        });
      }
      // }
    });
  }

  hide() async {
    await _lock.synchronized(() async {
      if (totalLoading == 0) return;
      totalLoading--;
      // print("showloading hide() start $totalLoading");
      if (totalLoading == 0 && _isShowing) {
        _hideLoading();
        _isShowing = false;
      }
    });
  }

  clear() {
    while (totalLoading > 0) {
      hide();
    }
  }

  _showLoading() async {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Palette.blueSky),
                      ),
                    ),
                  )));
        }).then((value) {
      totalLoading = 0;
      _isShowing = false;
    });
  }

  _hideLoading() {
    Navigator.of(context, rootNavigator: true).pop(); //close the dialoge
  }
}
