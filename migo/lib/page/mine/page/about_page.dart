import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:package_info/package_info.dart';

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
              SettingCell(title: I18n.of(context).settinguserprotocol,),
              SettingCell(title: I18n.of(context).settingprotocol,),
              SettingCell(title: I18n.of(context).settingupdate,),
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