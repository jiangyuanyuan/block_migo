import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/const/const_html.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/local_file.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:migo/root/version_model.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String version = "1.0.0";

  @override
  void initState() {
    super.initState();
    _initVersion();
  }

  void _initVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  void _pushname(BuildContext context, String content, String encontent, String title) async {
    String sufix = content;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageStr = prefs.getString('languageCode');
    if(languageStr == "en") sufix = encontent;
    Navigator.pushNamed(context, "/file", arguments: {"title":title, "content":sufix});
  }

   // 自动更新
  void _requestVersion() async {
    EasyLoading.show(status: "Loading...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isen = prefs.getString('languageCode') == "en";
    Networktool.request(API.version + "${Platform.isAndroid ? 1 : 2}/1",
        method: HTTPMETHOD.GET,
        success: (data) {
          EasyLoading.dismiss();
      final temp = VersionResponse.fromJson(data).data;
      if (temp == null) return;
      if(isen) temp.content = temp.enContent;
      Alert.showMsgDialog(context,
          barrierDismissible: temp.type == 0,
          title: I18n.of(context).settingupdate,
          msg: temp.content.replaceAll(";", "\n"), callback: () async {
      });
    }, fail: (msg) => EasyLoading.showError(msg),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).about,
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Image.asset("assets/logo.png"),
              SizedBox(height: 50,),
              SettingCell(title: I18n.of(context).settinguserprotocol, onTap: () {
                _pushname(context, ConstHTML.proto, ConstHTML.proto_en, I18n.of(context).settinguserprotocol);
              },),
              SettingCell(title: I18n.of(context).settingprotocol, onTap: () {
                _pushname(context, ConstHTML.mine, ConstHTML.mine_en, I18n.of(context).settingprotocol);
              },),
              SettingCell(title: I18n.of(context).settingupdate, onTap: () => _requestVersion(),),
              Spacer(),
              SafeArea(
                child: Text("${I18n.of(context).appcurrversion}  $version", style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
              ),
              SizedBox(height: 70,)
            ],
          ),
        ),
      ),
    );
  }
}