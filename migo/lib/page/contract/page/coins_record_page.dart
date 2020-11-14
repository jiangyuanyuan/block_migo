
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
              padding: EdgeInsets.zero,
              itemCount: isrecharge ? rechargeList.length : reflectList.length,
              itemBuilder: (context, index){
                return _Cell();
              }
            ),
          ),
        ),
      ),
    );
  }
}


class _Cell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}