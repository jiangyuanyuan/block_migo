import 'dart:io';

import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    // if (Platform.isAndroid) WebView.platform = ();
  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          print("js fucntion${message.message}");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar.normal(
        title: Text("web"),
        onPress: () => Navigator.pop(context)
      ),
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: <JavascriptChannel>[
            _alertJavascriptChannel(context),
          ].toSet(),
          initialUrl: "http://127.0.0.1:8090/",
        ),
      ),
    );
  }
}