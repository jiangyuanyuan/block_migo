import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/share_model.dart';
import 'package:migo/page/mine/model/team_record_model.dart';
import 'package:migo/page/mine/view/team_record_cell.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeamRecordDetailPage extends StatefulWidget {
  final Map params;

  const TeamRecordDetailPage({Key key, this.params}) : super(key: key);
  @override
  _TeamRecordDetailPageState createState() => _TeamRecordDetailPageState();
}

class _TeamRecordDetailPageState extends State<TeamRecordDetailPage> {

  int page = 0;
  List<ShareModel> list = [];
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  int time;
  String title;
  @override
  void initState() {
    super.initState();
    time = widget.params['time'];
    title = widget.params["title"] + "(${Tool.timeFormat("yyyy-MM-dd", time)})";
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
    Networktool.request(API.shareDetails, params: {
      "timeString": Tool.timeFormat("yyyy-MM-dd", time)
    }, success: (data) {
      final temp = ShareResponse.fromJson(data);
      list.clear();
      if(temp.data != null)list = temp.data;
      if(mounted) setState(() {
        
      });
    }, finaly: _endRefresh);
  }
  
  void _endRefresh() {
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: title,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
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
                      return _Cell(model: list[index],);
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
  final ShareModel model;

  const _Cell({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final time = DateTime.parse(model.timeString).millisecondsSinceEpoch;
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0, top: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(I18n.of(context).secondegenra(model.seniority.toString()), style: AppFont.textStyle(14, color: Colors.black),),
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
                      Text("${Tool.timeFormat("MM/dd", time)} ${I18n.of(context).arriveAim}", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                      Text(model.timeString, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}