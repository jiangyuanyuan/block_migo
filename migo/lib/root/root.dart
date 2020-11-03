import 'package:migo/common/const/cosnt.dart';
import 'package:migo/generated/i18n.dart';

import 'package:migo/page/contract/page/contract_page.dart';
import 'package:migo/page/contract/page/recharge_page.dart';
import 'package:migo/page/home/page/home_page.dart';
import 'package:migo/page/market/page/market_page.dart';
import 'package:migo/page/mine/page/mine_page.dart';
import 'package:flutter/material.dart';
import 'package:migo/page/mine/page/mine_team_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> pages = <Widget>[
          HomePage(),
          // RechagePage(),
          ContractPage(),
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
    "home_recharge.png",
    "home_reflect.png",
    "home_exchange.png",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<BottomNavigationBarItem> _createTabarList() {
    List<String> tabTitles = [
      I18n.of(context).home,
      I18n.of(context).exchange,
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
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: pages,
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
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