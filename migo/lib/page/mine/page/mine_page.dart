import 'package:flutter/material.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/me_model.dart';
import 'package:migo/page/mine/view/mine_action_view.dart';
import 'package:migo/page/mine/view/mine_coin_cell.dart';
import 'package:migo/page/mine/view/mine_head.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  RefreshController _refreshController = RefreshController();
  MeModel _meModel;
  List<MineCoinModel> list = [];
  String tick = "";
  num number = 0;
  @override
  void initState() {
    super.initState();
    _request();
    _getUser();
    EventBus.instance.addListener(EventKeys.RefreshMine, (arg) {
        _refreshController.requestRefresh();
    });
  }

  void _request() {
    Networktool.request(API.mePage, success: (data){
      _meModel = MeResponse.fromJson(data).data;
      list = _meModel.accountList;
      if(mounted) setState(() {
        
      });
    }, finaly: _endRefresh);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getUser() {
    Networktool.request(API.getUserTicket, method: HTTPMETHOD.GET, success: (data) async {
      final tmep = data["data"];
      if(tmep != null) {
        tick = tmep["ticketTitle"];
        number = tmep["ticketNumber"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if(prefs.getString('languageCode') == "en") {
          tick = tmep["ticketTitleEn"];
        }
      }
      
      if(mounted) setState(() {
        
      });
    });
  }

  void _refresh() {
    _request();
    _getUser();
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
                itemCount: list.length + 1,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  if(index == list.length) {
                    return InkWell(
                      onTap: () => Navigator.pushNamed(context, "/reel"),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/reel_cell.png"),
                                SizedBox(width: 20,),
                                // Text(I18n.of(context).reelusename, style: AppFont.textStyle(14, color: Colors.black),),
                                Text(tick, style: AppFont.textStyle(14, color: Colors.black),),
                                Spacer(),
                                Text("$number", style: AppFont.textStyle(14, color: Colors.black),),
                              ],
                            ),
                            SizedBox(height: 16,),
                            Divider(height: 1,)
                          ],
                        ),
                      ),
                    );
                  }
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