import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/alert_exit.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class MineSettingPage extends StatefulWidget {
  @override
  _MineSettingPageState createState() => _MineSettingPageState();
}

class _MineSettingPageState extends State<MineSettingPage> {

  void _jump(int sender) {
    switch (sender) {
      case 0:
        Navigator.pushNamed(context, "/invite");
        break;
      case 1:
        Navigator.pushNamed(context, "/safe");
        break;
      case 2:
        Navigator.pushNamed(context, "/paymain");
        break;
      case 3:
        Navigator.pushNamed(context, "/language");
        break;
      case 4:
        Navigator.pushNamed(context, "/autoaccount");
        break;
      case 5:
        Navigator.pushNamed(context, "/feedback");
        break;
      case 6:
        Navigator.pushNamed(context, "/about");
        break;
      default:
    }
  }

  void _exitLogin() {
    // Alert.showConfirmDialog(context, title: "确定要退出登录",sureCallback:(){
    //   SharedPreferences.getInstance().then((value) => value.clear());// 清楚用户数据
    //   Navigator.pushNamedAndRemoveUntil(context, '/login',(route) => false);
    // });
    Alert.showViewDialog(context, AlertExitView(onSure: () {
      // SharedPreferences.getInstance().then((value) => value.clear());// 清楚用户数据
      Navigator.pushNamedAndRemoveUntil(context, '/login',(route) => false);
    },));
  }

  String _getTitle(BuildContext context,int index) {
    List<String> titles = [
      I18n.of(context).invite,
      I18n.of(context).safecenter,
      I18n.of(context).spaysetting,
      I18n.of(context).lang,
      I18n.of(context).autoaccount,
      I18n.of(context).feedback,
      I18n.of(context).about,
    ];
    return titles[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).setting,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                //   if(index == 1) return MineSettingClear();
                //   if(index == MineSettingPage.titles.length - 1) return VersionCell();
                  return SettingCell(title: _getTitle(context, index), onTap: () => _jump(index),);
                }, 
                itemCount: 7
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: BtnAction(
                  title: I18n.of(context).loginout,
                  onTap: _exitLogin,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class VersionCell extends StatefulWidget {
  @override
  _VersionCellState createState() => _VersionCellState();
}

class _VersionCellState extends State<VersionCell> {
  
  String version = "v1.0";

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
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("当前版本", style: AppFont.textStyle(15, color: AppColor.font333),)),
                Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Text(version, style: AppFont.textStyle(15, color: AppColor.font666)),
                ),
              ],
            ),
          ),
          SizedBox(height: 1, child: Divider(indent: 15, endIndent: 15,))
        ],
      );
  }
}