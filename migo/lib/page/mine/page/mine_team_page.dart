import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
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
  TeamModel teamModel = TeamModel();
  RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      _refreshController.requestRefresh();
    });
  }

  // void _request() {
  //   Networktool.request(API.myTeamPage, success: (data) async {
  //     final temp = MineTeamResponse.fromJson(data);
  //     teamModel = temp.data;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final isen = prefs.getString('languageCode') == "en";
  //     if(isen) {
  //       teamModel.shareDTO.pseniorityConfigList.forEach((e) { 
  //         if(e.enRemark != null)e.remark = e.enRemark;
  //       });
  //       teamModel.leaderDTO.title = teamModel.leaderDTO.enTitle;
  //       teamModel.directDTO.pdirectConfig.remark = teamModel.directDTO.pdirectConfig.enRemark;
  //     }
  //     if(mounted) setState(() {
        
  //     });
  //   }, finaly: () => _refreshController.refreshCompleted());
  // }

  void _refresh() {
    _requestMoney();
    _requestShare();
    _requestTeam();
    _requestTeam4();
  }
  void _loading() {
    EventBus.instance.commit(EventKeys.RefreshLoading, null);
  }


  void _requestMoney() {
    Networktool.request(API.myTeamPage2, success: (data) {
      final temp = TeamModel.fromJson(data["data"]);
      teamModel.minTeamAmount = temp.minTeamAmount;
      teamModel.totalTeamAmount = temp.totalTeamAmount;
      teamModel.yesterdayTeamAmount = temp.yesterdayTeamAmount;
      if(mounted) setState(() {
        
      });
    }, finaly:_endRefresh);
  }

  void _requestShare() {
    Networktool.request(API.myTeamPage3, success: (data) {
      teamModel.shareDTO = ShareDTO.fromJson(data["data"]);
      if(mounted) setState(() {
        
      });
    });
  }

  void _requestTeam() {
    Networktool.request(API.myTeamPageStatistics,method:HTTPMETHOD.GET, success: (data) {
      teamModel.leaderDTO = LeaderDTO.fromJson(data["data"]);
      if(mounted) setState(() {
        
      });
    });
  }

  void _requestTeam4() {
    Networktool.request(API.myTeamPage5, success: (data) {
      teamModel.directDTO = DirectDTO.fromJson(data["data"]);
      if(mounted) setState(() {
        
      });
    });
  }

  void _endRefresh() {
    _refreshController.refreshCompleted();
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
          onRefresh: _refresh,
          onLoading: _loading,
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