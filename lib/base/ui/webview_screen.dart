import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:workflow_manager/base/network/app_url.dart';
import 'package:workflow_manager/base/utils/common_function.dart';

import '../../main.dart';

class WebViewScreen extends StatefulWidget {
  String url;
  String title;
  bool isOpenWithGoole;

  WebViewScreen(this.isOpenWithGoole, {this.title, this.url});

  @override
  _WebViewScreen createState() => _WebViewScreen();
}

class _WebViewScreen extends State<WebViewScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  String _url = "";
  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url = this.widget.url;
  }

  @override
  Widget build(BuildContext context) {
    print("-------url-----> ${_url}");
    return VisibilityDetector(
      key: Key("webview"),
      onVisibilityChanged: (info) {
        isVisible = info.visibleFraction == 1;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.widget.title ?? ""),
        ),
        body: WebView(
          // initialUrl: 'http://docs.google.com/viewer?url=${this.widget.url}',
          // initialUrl: '${_url}',
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              '${widget.isOpenWithGoole ? AppUrl.url_google_doc : ""}${this.widget.url}',
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onWebResourceError: (error) {
            print("error: ${error}");
          },
        ),
      ),
    );
  }
}
