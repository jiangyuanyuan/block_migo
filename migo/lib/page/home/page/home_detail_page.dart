import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/home/model/home_detail_model.dart';
import 'package:migo/page/home/model/home_list_model.dart';
import 'package:migo/page/home/view/alert_pay_view.dart';
import 'package:migo/page/home/view/home_detail_cell.dart';
import 'package:migo/page/home/view/home_detail_head.dart';
import 'package:migo/page/home/view/home_detail_tabbar.dart';
import 'package:migo/page/home/view/home_detail_use.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/model/me_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeDetailPage extends StatefulWidget {
  final Map params;

  const HomeDetailPage({Key key, this.params}) : super(key: key);
  @override
  _HomeDetailPageState createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {

  int tabindex = 0;
  HomeModel model;
  HomeDetialModel detailModel;
  List<MineEarnRecordModel> mineEarnRecordList = [];
  List<MinePayRecordModel> minePayRecordList = [];
  RefreshController _refreshController = RefreshController();
  num migoAmount = 0;
  @override
  void initState() {
    super.initState();
    model = widget.params["model"];
    _refresh();
  }
  /// 立即挖矿
  void _getAction() {
    Alert.showBottomViewDialog(context, AlertHomePayView(
      amount: migoAmount,
      coinName: model.pledgeCoinName,
      onSure: (sender) {
        Future.delayed(const Duration(milliseconds: 100)).then((value) => _inputPwd(sender));    
      },
    ));
  }

  void _inputPwd(String sedner) {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd){
      // EasyLoading.showToast("支付成功");
      EasyLoading.show(status: "Loading...");
      Networktool.request(API.homeminingBeltShovel, params: {
        	"mineBaseId": model.id,
	        "txPwd": Tool.generateMd5(pwd)
      }, success: (data) {
        EasyLoading.showToast(I18n.of(context).success);
        _refreshController.requestRefresh();
      }, fail: (e) => EasyLoading.showError(e));
    }));
  }

  void _requestAmount() {
    Networktool.request(API.mePage, success: (data){
      final meModel = MeResponse.fromJson(data).data;
      meModel.accountList.forEach((element) { 
        if(element.coinName == model.pledgeCoinName) {
          migoAmount = element.amount;
        }
      });
    });
  }

  /// 请求挖矿列表详情
  void _request() {
    Networktool.request(API.getMyMineList + model.id, method: HTTPMETHOD.GET, success: (data) {
      final temp = HomeDetailResponse.fromJson(data);
      detailModel = temp.data;
      if(detailModel.mineEarnRecordList != null) {
        mineEarnRecordList = detailModel.mineEarnRecordList;
      }
      if(detailModel.minePayRecordList != null) {
        minePayRecordList = detailModel.minePayRecordList;
      }
      if(mounted) setState(() {
        
      });
    }, finaly: () => _refreshController.refreshCompleted());
  }

  void _refresh() {
    _request();
    _requestAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: model.mineTitle,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            HomeDetailHeadView(model: model),
            SizedBox(height: 20,),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 120,
                    child: Image.asset("assets/migo_back.png", width: double.infinity, height: double.infinity, fit: BoxFit.fill,)
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: HomeDetailUserView(onTap: _getAction, endTime: detailModel?.endTime, coinName: model.pledgeCoinName, amount: model.pledgeAmount, shovelCount: detailModel?.useCount ?? 0,),
                  ),
                  Positioned.fill(
                    top: 215,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFDFEFF),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                      ),
                      child: Column(
                        children: [
                          HomeDetailBarView(onTabIndex: (sender) {
                            setState(() {
                              tabindex = sender;
                            });
                          },),
                          Expanded(
                            child: RefreshWidget(
                              controller: _refreshController,
                              onRefresh: _refresh,
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                itemBuilder: (context, index) {
                                  if(tabindex == 0) {
                                    final model = minePayRecordList[index];
                                    return HomeDetailCell(tabindex: tabindex, coinName: model.coinName, amount: model.payAmount, createtime: model.payTime,);
                                  } else {
                                    final model = mineEarnRecordList[index];
                                    return HomeDetailCell(tabindex: tabindex, coinName: model.coinName, amount: model.earnAmount, createtime: model.earnTime,);
                                  }
                                }, 
                                separatorBuilder: (context, index) => Divider(height: 1,), 
                                itemCount: tabindex == 0 ? minePayRecordList.length : mineEarnRecordList.length
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}