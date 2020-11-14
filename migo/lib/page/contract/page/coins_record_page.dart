
import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/model/recharge_record_model.dart';
import 'package:migo/page/contract/model/reflect_record_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoinsRecordPage extends StatefulWidget {
  final Map params;

  const CoinsRecordPage({Key key, this.params}) : super(key: key);
  @override
  _CoinsRecordPageState createState() => _CoinsRecordPageState();
}

class _CoinsRecordPageState extends State<CoinsRecordPage> {
  bool isrecharge = true;
  String coinName = "USDT";
  RefreshController _refreshController = RefreshController();
  List<RechargeRecordModel> rechargeList = [];
  List<ReflectRecordModel> reflectList = [];
  @override
  void initState() {
    super.initState();
    isrecharge = widget.params["isrecharge"];
    if(widget.params["coinName"] != null) coinName = widget.params["coinName"];
    _request();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _request() {
    String url = API.rechargeDetailList;
    HTTPMETHOD me = HTTPMETHOD.POST;
    if(!isrecharge) {
      url = API.getTransferOut + coinName;
      me = HTTPMETHOD.GET;
    }
    Networktool.request(url, method: me, success: (data) {
      if(isrecharge) {
        final temp = RechageRecordResponse.fromJson(data);
        rechargeList = temp.data;
      } else {
        final temp = ReflectRecordResponse.fromJson(data);
        reflectList = temp.data;
      }

      if(mounted) setState(() {
        
      });
    },finaly: _endrefresh);
  }

  void _refresh() {
    _request();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }

  String _getRemark(int status) {
    List<String> list = [
      I18n.of(context).coinStatus0,
      I18n.of(context).coinStatus1,
      I18n.of(context).coinStatus2,
      I18n.of(context).coinStatus3,
      I18n.of(context).coinStatus4,
      I18n.of(context).coinStatus5,
      I18n.of(context).coinStatus6,
      I18n.of(context).coinStatus7,
    ];
    return list[status];
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: CommbackView(
        onPop: () => Navigator.pop(context),
        titles: isrecharge ? I18n.of(context).rechargerecord : I18n.of(context).relfectrecord,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            color: Colors.white
          ),
          child: RefreshWidget(
            controller: _refreshController,
            onRefresh: _refresh,
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: isrecharge ? rechargeList.length : reflectList.length,
              itemBuilder: (context, index){
                if(isrecharge) {
                  final m = rechargeList[index];
                  return _Cell(coinName: m.coinName, createtie: m.createTime, amount: m.amount, remark: "",);
                } else {
                  final m = reflectList[index];
                  return _Cell(coinName: m.coinName, createtie: m.createTime, amount: m.amount, remark: _getRemark(m.status),);
                }
              }
            ),
          ),
        ),
      ),
    );
  }
}


class _Cell extends StatelessWidget {
  final String coinName;
  final num amount;
  final int createtie;
  final String remark;
  
  const _Cell({Key key, this.coinName, this.amount, this.createtie, this.remark}) : super(key: key);@override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(coinName, style: AppFont.textStyle(12, color: Colors.black, fontWeight: FontWeight.bold),),
              Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),),
            ],
          ),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Tool.timeFormat("yyyy-MM-dd HH:mm", createtie), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
              Text(remark, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
            ],
          ),
          Divider(height: 20,)
        ],
      ),
    );
  }
}