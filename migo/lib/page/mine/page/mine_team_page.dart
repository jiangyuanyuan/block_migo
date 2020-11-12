import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';
import 'package:migo/page/mine/view/team_bottom_view.dart';
import 'package:migo/page/mine/view/team_headview.dart';

class MineTeamPage extends StatefulWidget {
  @override
  _MineTeamPageState createState() => _MineTeamPageState();
}

class _MineTeamPageState extends State<MineTeamPage> {
  int tabIndex = 0;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).myteam,
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: Image.asset("assets/ico_incom_hist_def.png"),
            onPressed: () {
              Navigator.pushNamed(context, "/teamrecord");
            },
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              TeamHeadView(onTapIndex: (sender) {
                setState(() {
                  tabIndex = sender;
                });
              },),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: TeamBottomView(tabindex: tabIndex,)
              )
            ],
          ),
        ),
      ),
    );
  }
}