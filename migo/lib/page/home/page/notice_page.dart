import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/page/home/model/banner_model.dart';

class NoticePage extends StatelessWidget {
  final Map param;

  const NoticePage({Key key, this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeBannerModel model = param['model'];
    String html = "--";
    if(model.param != null) html = model.param;
    return Scaffold(
      body: CommbackView(
        titles: model.title,
        onPop: () => Navigator.pop(context),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: HtmlWidget(
            html
          ),
        ),
      ),
    );
  }
}