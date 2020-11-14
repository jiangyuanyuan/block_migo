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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).verified,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            MineTeamTabarView(
              titles: [I18n.of(context).curruser, I18n.of(context).otheruser],
              isscrolll: false,
              onTabIndex: (sender) {
                _pageController.animateToPage(sender, duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
              },
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