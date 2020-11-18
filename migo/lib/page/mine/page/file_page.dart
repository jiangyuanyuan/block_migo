import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:migo/common/commview/commback_view.dart';

class FilePage extends StatelessWidget {
  final Map params;
  const FilePage({Key key, this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: CommbackView(
        titles: params["title"],
        onPop: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: HtmlWidget(
              params["content"],
            ),
          ),
        ),
      ),
    );
  }
}
