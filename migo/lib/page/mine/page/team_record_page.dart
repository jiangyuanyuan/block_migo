import "package:flutter/material.dart";
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/team_record_model.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';
import 'package:migo/page/mine/view/team_record_cell.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamRecordPage extends StatefulWidget {
  @override
  _TeamRecordPageState createState() => _TeamRecordPageState();
}

class _TeamRecordPageState extends State<TeamRecordPage> {

  int tabIndex = 0;
  int type = -1;
  List<TeamRecordModel> list = [];
  int page = 0;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
  
  void _refresh() {
    page = 1;
    _request(true);
  }
  
  void _loading() {
    page += 1;
    _request();
  }
  
  void _request([bool refresh = false]) {
    Networktool.request(API.teamProfitPage + type.toString() + "/$page/10", success: (data) async{
      final temp = TeamRecordResponse.fromJson(data).data;
      if(refresh) list.clear();
      if(temp.length < 10) _refreshController.loadNoData();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final isen = prefs.getString('languageCode') == "en";
      if(isen) temp.forEach((e) { if(e.enBusinessRemark != null)e.businessRemark = e.enBusinessRemark;});
      list.addAll(temp);
      if(mounted) setState(() {
        
      });
    }, finaly: _endRefresh);
  }
  
  void _endRefresh() {
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }
  

  List<String> _tags() {
    return [
      I18n.of(context).all,
      I18n.of(context).teamgroupshare,
      // I18n.of(context).teamgroupleader,
      I18n.of(context).teammoney,
      I18n.of(context).seePoint,
      // I18n.of(context).minedividends
      I18n.of(context).globlalmoney
    ];
  }

  void _settype(int sender) {
    switch (sender) {
      case 0:
        type = -1;
        break;
      case 1:
        type = 10;
        break;
      case 2:
        type = 11;
        break;
      case 3:
        type = 12;
        break;
      case 4:
        type = 13;
        break;
      default:
        type = -1;
    }

    _refreshController.requestRefresh();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).teamearnrecord,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: MineTeamTabarView(
                titles: _tags(),
                isscrolll: true,
                onTabIndex: (sender) {
                  setState(() {
                    tabIndex = sender;
                  });
                  _settype(sender);
                },
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.divigrey,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                ),
                child: RefreshWidget(
                  controller: _refreshController,
                  onRefresh: _refresh,
                  onLoading: _loading,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (context, index) {
                      return TeamRecordCell(model: list[index], isshowarrow: tabIndex == 1,);
                    }, 
                    separatorBuilder: (context, index) => Divider(height: 1, color: const Color(0xffD8D8D8),), 
                    itemCount: list.length
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

