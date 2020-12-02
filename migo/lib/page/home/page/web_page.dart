import 'dart:io';

import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/page/home/model/banner_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final Map params;

  const WebPage({Key key, this.params}) : super(key: key);
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
    HomeBannerModel model = widget.params["model"];
    return Scaffold(
      body: CommbackView(
        titles: model.title,
        onPop: () => Navigator.pop(context),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>[
                _alertJavascriptChannel(context),
              ].toSet(),
              initialUrl: model.url,
            ),
          ),
        ),
      )
    );
  }
}