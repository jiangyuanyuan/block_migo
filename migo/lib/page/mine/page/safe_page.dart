import 'package:flutter/material.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/safe_model.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';

import 'alert_auth_view.dart';

class SafePage extends StatefulWidget {

  @override
  _SafePageState createState() => _SafePageState();
}

class _SafePageState extends State<SafePage> {

  SafeModel model;
  @override
  void initState() {
    super.initState();
    _request();

    EventBus.instance.addListener(EventKeys.RefreshAuth, (arg) { 
      _request();
      EventBus.instance.commit(EventKeys.RefreshMine, null);
    });
  }

  void _request() {
    Networktool.request(API.securityCenter, success: (data){
      model = SafeResponse.fromJson(data).data;
      if(mounted) setState(() {
        
      });
    });
  }

  List<Widget> _create(BuildContext context) {
    List<String> titles = [
      I18n.of(context).verified,
      I18n.of(context).currentbinding,
      I18n.of(context).loginpwd,
      I18n.of(context).txpassword,
    ];
    
    return titles.map((e) => SettingCell(
      title: e, 
      detail: _getString(titles.indexOf(e)),
      onTap: () {
        _jump(context, titles.indexOf(e));
      },
    )).toList();
  }

  String _getString(int sender) {
    switch (sender) {
      case 0:
      {
        List<String> titles = [
          I18n.of(context).auth0,
          I18n.of(context).auth1,
          I18n.of(context).auth2,
          I18n.of(context).auth3,
        ];
        return titles[model?.isAuth ?? 0];
      }
        break;
      case 1:
      {
        final data = Provider.of<UserModel>(context, listen: false).data;
        String account = data.mobile;
        if(data.registerType == 1) {
          account = data.mobile;
        }
        return account;
      }
        break;
      default:
        return "";
    }
  }

  void _jump(BuildContext context, int index) {
    switch (index) {
      case 0:
        if(model.isAuth == 0 || model.isAuth == 3) {
          Navigator.pushNamed(context, "/authmanage");
        } else if(model.isAuth == 1){
          Alert.showViewDialog(context, AlertAuthView(status: 1, onSure: () {
            
          },));
        }
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
      body: CommbackView(
        titles: I18n.of(context).safecenter,
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _create(context),
          ),
        ),
      ),
    );
  }
}