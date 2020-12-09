import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/gradient_text.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/model/me_model.dart';
import 'package:migo/page/mine/model/mine_coins_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinsDetailPage extends StatefulWidget {
  final Map params;

  const CoinsDetailPage({Key key, this.params}) : super(key: key);
  @override
  _CoinsDetailPageState createState() => _CoinsDetailPageState();
}

class _CoinsDetailPageState extends State<CoinsDetailPage> {
  MineCoinModel model;
  RefreshController _refreshController = RefreshController();
  List<MineCoinRecordModel> list = [];
  bool sorted = true;
  String imgs;
  @override
  void initState() {
    super.initState();
    model = widget.params["model"];
    imgs = widget.params["img"];
    _request();
  }

  void _request() {
    Networktool.request(API.getAccountDetailByCoinName + "${model.coinName}", success: (data) async {
      final temp = MineCoinRecordResponse.fromJson(data);
      if(temp.data != null) list = temp.data;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String languageStr = prefs.getString('languageCode');
      if(languageStr == "en") {
        list.forEach((element) { 
          if(element.enBusinessRemark != null) {
            element.businessRemark = element.enBusinessRemark;
          }
        });
      }
      // if(sorted) {
      //   list.sort((a, b) => b.createTime.compareTo(a.createTime));
      // } else {
      //   list.sort((a, b) => a.createTime.compareTo(b.createTime));
      // }
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  void _request2() {
    Networktool.request(API.mePage, success: (data){
      final _meModel = MeResponse.fromJson(data).data;
      if(_meModel.accountList.length > 0) {
        final e = _meModel.accountList.firstWhere((element) => element.coinName == model.coinName, orElse: () => null);
        if(e != null) {
          model = e;
        }
      }
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  void _refresh() {
    _request();
    _request2();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: model.coinName,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 9),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(model.coinUrl ?? "", width: 48, height: 48, fit: BoxFit.fill,),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeGradientText(data: "${Tool.number(model.amount, 4)} ${model.coinName}", fontstyle: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),),
                          // Text("≈¥${Tool.number(model.cnyAmount * model.amount, 2)}", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),)
                          Text(model.cnyAmount == 0 ? "" : "≈¥${Tool.number(model.cnyAmount * model.amount, 2)}", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
                        ],
                      ),
                      Spacer(),
                      // InkWell(
                      //   onTap: () => _refreshController.requestRefresh(),
                      //   child: Image.asset(("assets/coinupdate.png"))
                      // )
                    ],
                  ),
                  Divider(height: 40, color: const Color(0x33ffffff),),
                  Row(
                    children: [
                      Text(I18n.of(context).availablebalance, style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
                      Spacer(),
                      HomeGradientText(data: "${Tool.number(model.amount, 4)} ${model.coinName}", fontstyle: AppFont.textStyle(12, color: Colors.white, fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 24, height: 45,),
                        Text(I18n.of(context).history, style: AppFont.textStyle(12, color: Colors.black),),
                        Spacer(),
                        // IconButton(
                        //   icon: Image.asset("assets/fliter.png"),
                        //   iconSize: 24,
                        //   onPressed: () {
                        //     sorted = !sorted;
                        //     _refreshController.requestRefresh();
                        //   },
                        // )
                      ],
                    ),
                    Expanded(
                      child: RefreshWidget(
                        controller: _refreshController,
                        onRefresh: _refresh,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: list.length,
                          itemBuilder: (context, index){
                            MineCoinRecordModel lastmodel;
                            final model = list[index];
                            if(index > 0) {
                              final templast = list[index - 1];
                              if(Tool.timeFormat("yyyy-MM-dd", model.createTime) != Tool.timeFormat("yyyy-MM-dd", templast.createTime)) {
                                lastmodel = templast;
                              }
                            } else {
                              lastmodel = MineCoinRecordModel();
                            }
                            return _Cell(index: index, cnyAmount: this.model.cnyAmount, model: model, lasatModell: lastmodel,);
                          }
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
  final int index;
  final num cnyAmount;
  final MineCoinRecordModel model;
  final MineCoinRecordModel lasatModell;
  const _Cell({Key key, this.index, this.cnyAmount, this.model, this.lasatModell}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: lasatModell != null,
          child: Container(
            height: 28,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 24),
            color: const Color(0x33C1CDD8),
            child: Text(Tool.timeFormat("yyyy/MM/dd ", model.createTime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            children: [
              Image.asset("assets/${model.changeType != 1 ? "ico_hist_in_def2" : "ico_hist_in_def"}.png"),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("${index == 2 ? I18n.of(context).withdraw:I18n.of(context).recharge}", style: AppFont.textStyle(14, color: Colors.black),),
                  Text("${model.businessRemark}", style: AppFont.textStyle(14, color: Colors.black),),
                  SizedBox(height: 4,),
                  Text(Tool.timeFormat("HH:mm", model.createTime),style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)))
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// 提现为黑色
                  Row(
                    children: [
                      Text("${model.changeType == 1 ? "+" : "-"}${model.amount}", style: AppFont.textStyle(14, color: model.changeType == 1 ? AppColor.green : AppColor.red, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4,),
                      Text(model.coinName, style: AppFont.textStyle(14, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 4,),
                  // Text("≈0.000", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4))),
                  Text(cnyAmount == 0 ? "" : "≈¥${Tool.number(cnyAmount * model.amount, 2)}", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                ],
              ),
              SizedBox(width: 4,),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Text(model.coinName, style: AppFont.textStyle(14, color: Colors.black)),
              //     SizedBox(height: 4,),
              //     Text("USD", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4))),
              //   ],
              // ),
            ],
          ),
        )
      ],
    );
  }
}