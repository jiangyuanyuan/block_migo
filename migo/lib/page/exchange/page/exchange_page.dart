import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/exchange/model/basead_model.dart';
import 'package:migo/page/exchange/model/exchange_model.dart';
import 'package:migo/page/exchange/view/exchange_cell.dart';
import 'package:migo/page/exchange/view/exchange_head_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExchangeCoinPage extends StatefulWidget {
  @override
  _ExchangeCoinPageState createState() => _ExchangeCoinPageState();
}

class _ExchangeCoinPageState extends State<ExchangeCoinPage> {

  int page = 0;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  BaseAdModel baseAdModel;
  String min = "1";
  String max = "20";
  List<ExhangeModel> list = [];
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
    _requestBase();
  }
  
  void _loading() {
    page += 1;
    _request();
  }
  
  void _request([bool refresh = false]) {
    Networktool.request(API.adList+"/$min/$max/$page/10", method: HTTPMETHOD.GET, success: (data) {
      final temp = ExchangeResponse.fromJson(data);
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

  void _requestBase() {
    Networktool.request(API.adBase, method: HTTPMETHOD.GET, success: (data) {
      final temp = BaseAdResponse.fromJson(data);
      baseAdModel = temp.data;
      if(mounted) setState(() {
        
      });
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "MIGO"+I18n.of(context).coinexchange,
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () {
              Navigator.pushNamed(context, "/exchangerecord");
            },
          )
        ],
        child: RefreshWidget(
          onRefresh: _refresh,
          onLoading: _loading,
          controller: _refreshController,
          minPage: page,
          child: ListView.builder(
            itemCount: list.length + 1,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              if(index == 0) {
                return ExhangeCoinHeadView(
                  model: baseAdModel, 
                  onRefresh: () {
                    _refresh();
                  },
                  onSelect: (rate) {
                    final temp = rate.split("-");
                    if(temp.length == 2) {
                      min = temp.first;
                      max = temp.last;
                    } else {
                      min = "300";
                      max = "1000000";
                    }
                    _refreshController.requestRefresh();
                  },
                );
              } else {
                return ExchangeCell(index: index, model: list[index - 1], onRefresh: () {
                  _refreshController.requestRefresh();
                },);
              }
            }
          ),
        ),
      ),
    );
  }
}