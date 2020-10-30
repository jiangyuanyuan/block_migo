import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/page/mine/view/cache_cell.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineSettingPage extends StatefulWidget {

  static const List<String> titles = [
    "安全中心",
    "清除缓存",
    "问题反馈",
    "用户协议",
    "隐私条款说明",
    "当前版本"
  ];

  @override
  _MineSettingPageState createState() => _MineSettingPageState();
}

class _MineSettingPageState extends State<MineSettingPage> {

  void _jump(int sender) {
    switch (sender) {
      case 0:
        Navigator.pushNamed(context, "/safe");
        break;
      case 2:
        Navigator.pushNamed(context, "/feedback");
        break;
      default:
    }
  }

  void _exitLogin() {
    Alert.showConfirmDialog(context, title: "确定要退出登录",sureCallback:(){
      SharedPreferences.getInstance().then((value) => value.clear());// 清楚用户数据
      Navigator.pushNamedAndRemoveUntil(context, '/pwdlogin',(route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NormalAppbar.normal(
        title: Text("设置"),
        onPress: () => Navigator.pop(context)
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if(index == 1) return MineSettingClear();
                if(index == MineSettingPage.titles.length - 1) return VersionCell();
                return SettingCell(title: MineSettingPage.titles[index], onTap: () => _jump(index),);
              }, 
              itemCount: MineSettingPage.titles.length
            ),
          ),
          SafeArea(
            child: BottomButton(
              title: "退出登录",
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