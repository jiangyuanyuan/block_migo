import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/model/mine_team_model.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';
import 'package:migo/page/mine/view/team_bottom_view.dart';
import 'package:migo/page/mine/view/team_headview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineTeamPage extends StatefulWidget {
  @override
  _MineTeamPageState createState() => _MineTeamPageState();
}

class _MineTeamPageState extends State<MineTeamPage> {
  int tabIndex = 0;
  TeamModel teamModel;
  RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    _request();
  }

  void _request() {
    Networktool.request(API.myTeamPage, success: (data) async {
      final temp = MineTeamResponse.fromJson(data);
      teamModel = temp.data;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final isen = prefs.getString('languageCode') == "en";
      if(isen) {
        teamModel.shareDTO.pseniorityConfigList.forEach((e) { 
          if(e.enSeeRemark != null)e.seeRemark = e.enSeeRemark;
        });
        teamModel.leaderDTO.title = teamModel.leaderDTO.enTitle;
        teamModel.directDTO.pdirectConfig.remark = teamModel.directDTO.pdirectConfig.enRemark;
      }
      if(mounted) setState(() {
        
      });
    }, finaly: () => _refreshController.refreshCompleted());
  }
  
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
        child: RefreshWidget(
          controller: _refreshController,
          onRefresh: _request,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TeamHeadView(
                  model: teamModel,
                  onTapIndex: (sender) {
                  setState(() {
                    tabIndex = sender;
                  });
                },),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TeamBottomView(model: teamModel, tabindex: tabIndex, )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}