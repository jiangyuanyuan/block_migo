import 'package:flutter/material.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/page/mine/model/me_model.dart';
import 'package:migo/page/mine/view/mine_action_view.dart';
import 'package:migo/page/mine/view/mine_coin_cell.dart';
import 'package:migo/page/mine/view/mine_head.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  RefreshController _refreshController = RefreshController();
  MeModel _meModel;
  List<MineCoinModel> list = [];
  @override
  void initState() {
    super.initState();
    _request();
  }

  void _request() {
    Networktool.request(API.mePage, success: (data){
      _meModel = MeResponse.fromJson(data).data;
      list = _meModel.accountList;
      if(mounted) setState(() {
        
      });
    }, finaly: _endRefresh);
  }

  void _refresh() {
    _request();
  }

  void _endRefresh() {
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainHeadView(model: _meModel,),
          Expanded(
            child: RefreshWidget(
              controller: _refreshController,
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.pushNamed(context, "/coinsdetail", arguments: {"model":list[index]}),
                    child: MineCoinCell(model: list[index])
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}