import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_detail_cell.dart';
import 'package:migo/page/mine/model/mine_earn_model.dart';
import 'package:migo/page/mine/model/mines_earn2_model.dart';
import 'package:migo/page/mine/model/mines_type_model.dart';
import 'package:migo/page/mine/view/earn_date_view.dart';
import 'package:migo/page/mine/view/mine_earn_head.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineEarnPage extends StatefulWidget {
  @override
  _MineEarnPageState createState() => _MineEarnPageState();
}

class _MineEarnPageState extends State<MineEarnPage> {
  
  int tabindex = 0;
  RefreshController _refreshController = RefreshController();
  // 矿池名字 传‘-1’返回全部
  int type = -1;
  String datetime = "-1";
  List<MinesPayEarnModel> list = [];
  List<MinesEarnsModel> list2 = [];
  int year = 2020;
  int month = 1;
  int page = 1;
  List<MinesTypeModel> typelist = [];
  bool ispay = true;
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
    Networktool.request(API.getMyProfitOrPayListPage, method: HTTPMETHOD.GET, success: (data) async {
      final temp = MinesTypeResponse.fromJson(data).data;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final isen = prefs.getString('languageCode') == "en";
      if(isen) temp.forEach((e) { if(e.enName != null)e.name = e.enName;});
      if(temp != null) typelist = temp;
      if(mounted) setState(() {
        
      });
    });
  }

  void _request([bool isclear = false]) {
    String url = API.getMyPayList;
    if(ispay == false) url = API.getMyProfitList;
    Networktool.request(url + "$type/$datetime/$page/10", method: HTTPMETHOD.GET, success: (data) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final isen = prefs.getString('languageCode') == "en";
      if(ispay) {
        final temp = MinePayEarnResponse.fromJson(data).data.records;
        if(isclear) list.clear();
        if(isen) temp.forEach((e) { if(e.enEarnName != null) e.earnName = e.enEarnName ;});
        list.addAll(temp);
        if(temp.length < 10) _refreshController.loadNoData();
      } else {
        final temp = MinesEarnsResponse.fromJson(data).data.records;
        if(isen) temp.forEach((e) { if(e.enEarnName != null) e.earnName = e.enEarnName ;});
        if(isclear) list2.clear();
        list2.addAll(temp);
        if(temp.length < 10) _refreshController.loadNoData();
      }
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
      datetime = "${year}_${month.toString().length < 2 ? "0" : ""}$month";
      _refreshController.requestRefresh();
    }
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
                    EarnDateView(
                      datetime: datetime == "-1" ? "--" : "$year.$month", 
                      onSelected: _dateAction,
                      ispay: ispay,
                      onChoosed: (sender) {
                        setState(() {
                          ispay = sender;
                        });
                        _refreshController.requestRefresh();
                      },
                    ),
                    Expanded(
                      child: SafeArea(
                        top: false,
                        child: RefreshWidget(
                          controller: _refreshController,
                          onRefresh: _refresh,
                          onLoading: _loading,
                          minPage: page,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            itemBuilder: (context, index) {
                              // EarnModel lastmodel;
                              // final model = list[index];
                              // if(index > 0) {
                              //   final templast = list[index - 1];
                              //   if(Tool.timeFormat("yyyy-MM-dd", templast.createTime) != Tool.timeFormat("yyyy-MM-dd", templast.createTime)) {
                              //     lastmodel = templast;
                              //   }
                              // } else {
                              //   lastmodel = EarnModel();
                              // }
                              // return _Cell(last: lastmodel, model: model,);
                              if(ispay) {
                                final model = list[index];
                                return _HomeDetailCell(tabindex: 0, minesName: model.earnName, coinName: model.coinName, amount: model.payAmount, createtime: model.createTime,);
                              } else {
                                final model = list2[index];
                                return _HomeDetailCell(tabindex: 1,minesName: model.earnName, coinName: model.coinName, amount: model.earnAmount, createtime: model.createTime,);
                              }
                            }, 
                            separatorBuilder: (context, index) => Divider(height: 1,), 
                            itemCount: ispay ? list.length : list2.length
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

class _HomeDetailCell extends StatelessWidget {
  final int tabindex;
  final num amount;
  final String minesName;
  final int createtime;
  final String coinName;
  const _HomeDetailCell({Key key, this.minesName, this.coinName, this.tabindex, this.amount, this.createtime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(minesName, style: AppFont.textStyle(12, color: Colors.black, fontWeight: FontWeight.bold),),
              Text("${tabindex == 0 ? "-" : "+"}$amount $coinName", style: AppFont.textStyle(14, color: AppColor.back998),),
            ],
          ),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tabindex == 0 ? "" : I18n.of(context).dayincome, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
              Text(Tool.timeFormat("yyyy-MM-dd HH:mm", createtime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
            ],
          )
        ],
      ),
    );
  }
}