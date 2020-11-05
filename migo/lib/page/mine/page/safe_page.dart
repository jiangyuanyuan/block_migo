import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/setting_cell.dart';

class SafePage extends StatelessWidget {

  List<Widget> _create(BuildContext context) {
    List<String> titles = [
      I18n.of(context).verified,
      I18n.of(context).currentbinding,
      I18n.of(context).loginpwd,
      I18n.of(context).txpassword,
    ];
    return titles.map((e) => SettingCell(title: e, onTap: () {
      _jump(context, titles.indexOf(e));
    },)).toList();
  }

  void _jump(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, "/mineauth");
        break;
      case 1:
        Navigator.pushNamed(context, "/mineexchangebind");
        break;
      case 2:
        Navigator.pushNamed(context, "/login", arguments: {'modtype': 1});
        break;
      case 3:
        Navigator.pushNamed(context, "/login", arguments: {'modtype': 2});
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar.normal(
        title: Text(I18n.of(context).safecenter),
        onPress: () => Navigator.pop(context)
      ),
      body: Column(
        children: _create(context),
      ),
    );
  }
}