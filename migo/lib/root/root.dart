import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/common/util/tool_apk.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/page/contract_page.dart';
import 'package:migo/page/exchange/page/exchange_page.dart';
import 'package:migo/page/home/page/home_page.dart';
import 'package:migo/page/mine/page/mine_page.dart';
import 'package:flutter/material.dart';
import 'package:migo/page/mine/page/mine_team_page.dart';
import 'package:migo/provider/user.dart';
import 'package:migo/root/version_model.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int currentIndex = 0;
  DateTime lastPopTime;
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> pages = <Widget>[
          HomePage(),
          // RechagePage(),
          // ContractPage(),
          ExchangeCoinPage(),
          MineTeamPage(),
          // MarketPage(),
          MinePage()
        ];

  // static const List<String> tabTitles = [
  //   "首页",
  //   "兑换", 
  //   '市场', 
  //   '我的'
  // ];

  static const List<String> tabIconsName = [
    "home.png",
    "tab_exchange.png",
    "home_team.png",
    "home_exchange.png",
  ];

  @override
  void initState() {
    super.initState();
    EventBus.instance.addListener(EventKeys.JumtoTeam, (arg) { 
      _pageController.jumpToPage(2);
    });
    print(Provider.of<UserModel>(context, listen: false).data?.id);
    _requestVersion();
    EasyLoading.instance..userInteractions = false;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

   // 自动更新
  void _requestVersion() async {
    if(AppConst.APP_IS_RELEASE == false) return;
    final info = await PackageInfo.fromPlatform();
    String version = Platform.isAndroid ? info.version : info.buildNumber;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isen = prefs.getString('languageCode') == "en";
    Networktool.request(API.version + "${Platform.isAndroid ? 1 : 2}/1",
        method: HTTPMETHOD.GET,
        success: (data) {
      final temp = VersionResponse.fromJson(data).data;
      if (temp == null) return;
      if (temp.version == version) {
        return;
      }
      if(isen) temp.content = temp.enContent;
      Alert.showMsgDialog(context,
          barrierDismissible: temp.isForce == 1 ? false : true,
          title: I18n.of(context).upnotice,
          iswillpop: temp.isForce == 1 ? false : true,
          msg: temp.content.replaceAll(";", "\n"), callback: () async {
        if (Platform.isIOS) {
          launch(temp.url);
          return;
        }
        final status = await Permission.storage.status;
        if (status.isUndetermined) {
          final _ = await Permission.storage.request();
        }
        Navigator.pop(context);
        _download(temp.url);
      });
    });
  }

  void _download(String url) {
    getExternalStorageDirectory().then((value) async {
      String localpath = value.path + "/install" + url.split("/").last;
      var file = File(localpath);
      Networktool.downloadImage(url, progress: (count, total) {
        EasyLoading.showProgress(count / total,
            status: "Loading...(${(count / total * 100).toStringAsFixed(1)}%)...");
      }, success: (data) {
        EasyLoading.showSuccess(I18n.of(context).success);
        file.writeAsBytes(data).then((value) => ToolAPK.installApk(value.path));
      });
    });
  }

  List<BottomNavigationBarItem> _createTabarList() {
    List<String> tabTitles = [
      I18n.of(context).home,
      I18n.of(context).coinexchange,
      I18n.of(context).team,
      I18n.of(context).mine,
    ];
    return tabTitles.map((e) {
      final index = tabTitles.indexOf(e);
      return BottomNavigationBarItem(
      icon: Image.asset("assets/${tabIconsName[index]}",),
      activeIcon: Image.asset("assets/${tabIconsName[index]}",),
      title: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(e, style: TextStyle(
          fontSize: 10, 
          color: currentIndex == index ? AppColor.yellowMain : AppColor.fontgrey,
          fontWeight: FontWeight.bold
        )),
      ));
    }).toList();
  }

  void _tabIndexChanged(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
    if(index == 0) {
      _requestVersion();
      EventBus.instance.commit(EventKeys.RereshHome, null);
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
            lastPopTime = DateTime.now();
            EasyLoading.showToast(I18n.of(context).againexit);
          }else {
            lastPopTime = DateTime.now();
            // 退出app
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
        child: PageView(
          children: pages,
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        fixedColor: Colors.white,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        items: _createTabarList(),
        onTap: _tabIndexChanged,
      ),
    );
  }
}