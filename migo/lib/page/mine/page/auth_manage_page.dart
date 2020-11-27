import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/page/mine_auth_page.dart';
import 'package:migo/page/mine/page/threeauth_page.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';

class AuthManagePage extends StatefulWidget {
  @override
  _AuthManagePageState createState() => _AuthManagePageState();
}

class _AuthManagePageState extends State<AuthManagePage> {
  PageController _pageController = PageController();
  bool isfor = false;
  @override
  void initState() {
    super.initState();
    _getlocallang();
  }

  void _getlocallang() async {
    List languages = await Devicelocale.preferredLanguages;
    String locale = await Devicelocale.currentLocale;
    bool res = locale.toLowerCase().contains("en");
    setState(() {
      isfor = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).verified,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            Visibility(
              visible: isfor,
              child: MineTeamTabarView(
                titles: [I18n.of(context).curruser, I18n.of(context).otheruser],
                isscrolll: false,
                onTabIndex: (sender) {
                  _pageController.animateToPage(sender, duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
                },
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ThreeAuthPage(),
                  MineAuthPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}