import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/mine_earn_model.dart';
import 'package:migo/page/mine/model/mines_type_model.dart';
import 'package:migo/page/mine/view/earn_date_view.dart';
import 'package:migo/page/mine/view/mine_earn_head.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineEarnPage extends StatefulWidget {
  @override
  _MineEarnPageState createState() => _MineEarnPageState();
}

class _MineEarnPageState extends State<MineEarnPage> {
  
  int tabindex = 0;
  RefreshController _refreshController = RefreshController();
  // 矿池名字 传‘-1’返回全部
  int type = -1;
  int datetime = -1;
  List<EarnModel> list = [];
  int year = 2020;
  int month = 1;
  int page = 1;
  List<MinesTypeModel> typelist = [];
  @override
  void initState() {
    super.initState();
    _request();
    _requestType();
    DateTime now = DateTime.now();
    year = now.year;
    month = now.month;
    if(mounted) setState(() {
      
    });
  }

  void _requestType() {
    Networktool.request(API.getMyProfitOrPayListPage, method: HTTPMETHOD.GET, success: (data) {
      final temp = MinesTypeResponse.fromJson(data).data;
      if(temp != null) typelist = temp;
      if(mounted) setState(() {
        
      });
    });
  }

  void _request([bool isclear = false]) {
    Networktool.request(API.getMyPayList + "$type/$datetime/$page/10", method: HTTPMETHOD.GET, success: (data){
      final temp = MineEarnResponse.fromJson(data);
      list = temp.data;
      list.sort((a, b) => a.earnTime.compareTo(b.earnTime));
      if(isclear) list.clear();
      if(temp.data.length < 10) _refreshController.loadNoData();
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  void _refresh() {
    page = 1;
    _request(true);
    _requestType();
  }

  void _loading() {
    page += 1;
    _request();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }

  void _dateAction() async{
    final params = await Navigator.pushNamed<Map<String, dynamic>>(context, "/choosemonth", arguments: {"year":year, "month":month});
    if(params != null) {
      setState(() {
        year = params["year"];
        month = params["month"];
      });
    }
    datetime = DateTime.parse("$year${month}00").millisecondsSinceEpoch;
    _refreshController.requestRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).myearn,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            MineEarnHeadView(
              tabindex: tabindex,
              titles: typelist.map((e) => e.name).toList(),
              onTap: (sender) {
                tabindex = sender;
                type = typelist[sender].id;
                if(tabindex == 0) type = -1;

                _refreshController.requestRefresh();
                setState(() {
                  
                });
              },
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                ),
                child: Column(
                  children: [
                    EarnDateView(datetime: "$year.$month", onSelected: _dateAction,),
                    Expanded(
                      child: SafeArea(
                        top: false,
                        child: RefreshWidget(
                          controller: _refreshController,
                          onRefresh: _refresh,
                          onLoading: _loading,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              EarnModel lastmodel;
                              final model = list[index];
                              if(index > 0) {
                                final templast = list[index - 1];
                                if(Tool.timeFormat("yyyy-MM-dd", templast.createTime) != Tool.timeFormat("yyyy-MM-dd", templast.createTime)) {
                                  lastmodel = templast;
                                }
                              } else {
                                lastmodel = EarnModel();
                              }
                              return _Cell(last: lastmodel, model: model,);
                            }, 
                            separatorBuilder: (context, index) => Divider(height: 1,), 
                            itemCount: list.length
                          ),
                        ),
                      ),
                    )
                  ],
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
  final EarnModel model;
  final EarnModel last;
  const _Cell({Key key, this.model, this.last}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: last != null,
          child: Container(
            color: AppColor.back998.withOpacity(0.05),
            height: 40,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 24),
            child: Text(Tool.timeFormat("yyyy/MM/dd", model.earnTime), style: AppFont.textStyle(12, color: AppColor.back998),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.earnName, style: AppFont.textStyle(12, color: AppColor.back998),),
                  Text("+${model.earnAmount} ${model.coinName}", style: AppFont.textStyle(12, color: const Color(0xff21C826)),)
                ],
              ),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("日收益", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                  Text(Tool.timeFormat("yyyy/MM/dd HH:mm", model.earnTime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}