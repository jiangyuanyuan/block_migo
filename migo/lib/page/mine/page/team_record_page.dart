import "package:flutter/material.dart";
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/team_record_model.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeamRecordPage extends StatefulWidget {
  @override
  _TeamRecordPageState createState() => _TeamRecordPageState();
}

class _TeamRecordPageState extends State<TeamRecordPage> {

  int tabIndex = 0;
  int type = -1;
  RefreshController _refreshController = RefreshController();
  List<TeamRecordModel> list = [];
  @override
  void initState() {
    super.initState();

    _request();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _request() {
    Networktool.request(API.teamProfitPage + type.toString(), success: (data){
      final temp = TeamRecordResponse.fromJson(data).data;
      list = temp;
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  void _refresh() {
    _request();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }

  List<String> _tags() {
    return [
      I18n.of(context).all,
      I18n.of(context).teamgroupshare,
      I18n.of(context).teamgroupleader,
      I18n.of(context).teamgrouppush,
      I18n.of(context).minedividends
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
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (context, index) {
                      return _Cell(model: list[index]);
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

class _Cell extends StatelessWidget {
  final TeamRecordModel model;

  const _Cell({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.businessRemark, style: AppFont.textStyle(14, color: Colors.black),),
              
              Row(
                children: [
                  Text("+${model.amount}", style: AppFont.textStyle(14, color: AppColor.green, fontWeight: FontWeight.bold),),
                  SizedBox(width: 4,),
                  Text("${model.coinName}", style: AppFont.textStyle(14, color: Colors.black),)
                ],
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${Tool.timeFormat("MM/dd", model.createTime)}达标${model.businessRemark}", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
              Text(Tool.timeFormat("yyyy-MM-dd HH:mm", model.createTime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
            ],
          )
        ],
      ),
    );
  }
}