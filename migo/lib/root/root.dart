import 'package:migo/common/const/cosnt.dart';
import 'package:migo/page/coins/page/coins_page.dart';
import 'package:migo/page/contract/page/contract_page.dart';
import 'package:migo/page/home/page/home_page.dart';
import 'package:migo/page/mine/page/mine_page.dart';
import 'package:migo/page/order/page/order_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> pages = <Widget>[
          HomePage(),
          OrderPage(),
          ContractPage(),
          CoinsPage(),
          MinePage()
        ];

  static const List<String> tabTitles = [
    "首页",
    "交易圈", 
    "智能交易", 
    '排行榜', 
    '我的'
  ];

  static const List<String> tabIconsName = [
    "icon_zhuyexz.png",
    "icon_jiaoyiquan.png",
    "icon_zhinengjiaoyi.png",
    "icon_paihangbang.png",
    "icon_wode.png"
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
    return tabTitles.map((e) {
      final index = tabTitles.indexOf(e);
      return BottomNavigationBarItem(
      icon: Image.asset("assets/${tabIconsName[index]}", color: AppColor.fontgrey,),
      activeIcon: Image.asset("assets/${tabIconsName[index]}", color: AppColor.blue,),
      title: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(e, style: TextStyle(fontSize: 10, color: currentIndex == index ? AppColor.blue : AppColor.fontgrey)),
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