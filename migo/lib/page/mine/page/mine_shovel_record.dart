import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_detail_cell.dart';
import 'package:migo/page/mine/model/my_shovel_record_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineShovelRecordPage extends StatefulWidget {
  @override
  _MineShovelRecordPageState createState() => _MineShovelRecordPageState();
}

class _MineShovelRecordPageState extends State<MineShovelRecordPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);
  int page = 1;
  List<MyShovelRecordModel> list = [];
  
  void _request() {
    Networktool.request(API.getMyProfitListByShovel, success: (data) {
      final temp = MyShovelRecordResponse.fromJson(data).data;
      if(temp != null) list = temp;
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  @override
  void initState() {
    super.initState();
  }

  void _refresh() {
    page = 1;
    _request();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).myearn,
        onPop: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RefreshWidget(
            onRefresh: _refresh,
            controller: _refreshController,
            child: ListView.separated(
              itemBuilder: (context, index){
                final e = list[index];
                return HomeDetailCell(amount: e.amount, coinName: "${e.coinName} ${e.remark}", createtime: e.createTime,);
              }, 
              separatorBuilder: (context, idnex) {
                return Divider(height: 1,);
              }, 
              itemCount: list.length),
          ),
        ),
      ),
    );
  }
}