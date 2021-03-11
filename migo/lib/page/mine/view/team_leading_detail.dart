import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/mine_team_model.dart';
import 'package:migo/page/mine/model/subordinate_leader_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeamLeadingDetailView extends StatefulWidget {

  final int number;
  final List<SubordinateLeaderDTOModel> subordinateLeaderDTOList;

  @override
  _TeamLeadingDetailViewState createState() => _TeamLeadingDetailViewState();

  const TeamLeadingDetailView({Key key, this.number, this.subordinateLeaderDTOList}) : super(key: key);
}

class _TeamLeadingDetailViewState extends State<TeamLeadingDetailView> {

  int page = 0;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  String min = "1";
  String max = "20";
  List<SubordinateLeaderDTOModel> list = [];

  @override
  void initState() {
    super.initState();
    _request();

    EventBus.instance.addListener(EventKeys.RefreshLoading, (arg) {
      _loading();
    });
  }

  @override
  void dispose() {
    EventBus.instance.removeListener(EventKeys.RefreshLoading);
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
    Networktool.request(API.mySmallTeamPageStatistics+"/$page/100", method: HTTPMETHOD.GET,success: (data) {
      final temp = SubordinateLeaderModel.fromJson(data);
      print("---------"+temp.data.length.toString());
      if(refresh) list.clear();
      if(temp.data.length < 10) _refreshController.loadNoData();
      list.addAll(temp.data);
      if(mounted) setState(() {

      });
    }, fail: (msg) => EasyLoading.showToast(msg)
        ,finaly: _endRefresh);
  }

  void _endRefresh() {
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(I18n.of(context).mycommunity, style: AppFont.textStyle(12, color: Colors.black)),
              Text(I18n.of(context).myteam, style: AppFont.textStyle(12, color: Colors.black)),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: I18n.of(context).teamleadertotal,
                      style: AppFont.textStyle(12, color: Colors.black)
                    ),
                    TextSpan(
                      text: widget.number.toString(),
                      style: AppFont.textStyle(12, color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: I18n.of(context).peopleintotal,
                      style: AppFont.textStyle(12, color: Colors.black)
                    ),
                  ]
                )
              )
            ],
          ),
        ),
        Divider(height: 30,),
        Expanded(
          child:RefreshWidget(
          onRefresh: _refresh,
          onLoading: _loading,

          controller: _refreshController,
            minPage: page,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index){
              final model = list[index];
              return _Cell(index: index + 1, model: model,);
            }
          ),
        )
        )
      ]
    );
  }
}

class _Cell extends StatelessWidget {
  final int index;
  final SubordinateLeaderDTOModel model;
  const _Cell({Key key, this.index, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/bg_team_area_def.png"),
                  Text("$index", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(width: 18,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${model.userNumber}", style: AppFont.textStyle(12, color: Colors.black),),
                        SizedBox(width: 4,),
                        Text(model.isAuthStatus == 1 ? I18n.of(context).auth : I18n.of(context).notauth, style: AppFont.textStyle(12, color: model.isAuthStatus == 1 ? AppColor.red : AppColor.blue),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(I18n.of(context).teamnumber, style: AppFont.textStyle(12, color: Colors.black),),
                          Text("${model.subordinateUserCount}", style: AppFont.textStyle(12, color: Colors.black, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(I18n.of(context).dynamicincome, style: AppFont.textStyle(12, color: Colors.black),),
                        Text(I18n.of(context).teamminetotal, style: AppFont.textStyle(12, color: Colors.black),),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "${model.maxTeamAmount}", style: AppFont.textStyle(12, color: AppColor.green, fontWeight: FontWeight.bold),),
                              TextSpan(text: " MIGO", style: AppFont.textStyle(12, color: Colors.black),)
                            ]
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 16,),
          Divider(height: 1,)
        ],
      ),
    );
  }
}