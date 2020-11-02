import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/alert_exit.dart';
import 'package:migo/page/mine/view/cache_cell.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineSettingPage extends StatefulWidget {

  static const List<String> titles = [
    "邀请好友",
    "安全中心",
    "操作语言",
    "帮助反馈",
    "关于",
  ];

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
        Navigator.pushNamed(context, "/language");
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
      SharedPreferences.getInstance().then((value) => value.clear());// 清楚用户数据
      Navigator.pushNamedAndRemoveUntil(context, '/login',(route) => false);
    },));
  }

  String _getTitle(BuildContext context,int index) {
    List<String> titles = [
      I18n.of(context).invite,
      I18n.of(context).safecenter,
      I18n.of(context).lang,
      I18n.of(context).feedback,
      I18n.of(context).about,
    ];
    return titles[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NormalAppbar.normal(
        title: Text(I18n.of(context).setting),
        onPress: () => Navigator.pop(context)
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
              //   if(index == 1) return MineSettingClear();
              //   if(index == MineSettingPage.titles.length - 1) return VersionCell();
                return SettingCell(title: _getTitle(context, index), onTap: () => _jump(index),);
              }, 
              itemCount: MineSettingPage.titles.length
            ),
          ),
          SafeArea(
            child: BottomButton(
              title: I18n.of(context).loginout,
              onTap: _exitLogin,
            ),
          )
        ],
      ),
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