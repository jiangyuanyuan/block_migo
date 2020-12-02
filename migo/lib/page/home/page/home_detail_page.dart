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
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';
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
  // List<MineEarnRecordModel> mineEarnRecordList = [];
  List<MmineUserModel> minePayRecordList = [];
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
    // Alert.showBottomViewDialog(context, AlertHomePayView(
    //   amount: migoAmount,
    //   coinName: model.pledgeCoinName,
    //   onSure: (sender) {
    //     Future.delayed(const Duration(milliseconds: 100)).then((value) => _inputPwd(sender));    
    //   },
    // ));
    final user = Provider.of<UserModel>(context, listen: false).data;
    if(user.txPassword == null || user.txPassword == "") {
      Alert.showMsgDialog(context, title: I18n.of(context).notice, msg: I18n.of(context).nottxpwd, callback: () {
        Navigator.pushNamed(context, "/login", arguments: {'modtype': 2});
      });
      return;
    }
    _inputPwd("");
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
        // _refreshController.requestRefresh();
        _request();
      }, fail: (e) => EasyLoading.showError(e));
    }));
  }

  void _requestAmount() {
    // Networktool.request(API.mePage, success: (data){
    //   final meModel = MeResponse.fromJson(data).data;
    //   meModel.accountList.forEach((element) { 
    //     if(element.coinName == model.pledgeCoinName) {
    //       migoAmount = element.amount;
    //     }
    //   });
    // });
  }

  /// 请求挖矿列表详情
  void _request() {
    Networktool.request(API.getMineBaseById + model.id, method: HTTPMETHOD.GET, success: (data) {
      final temp = HomeDetailResponse.fromJson(data);
      detailModel = temp.data;
      // if(detailModel.mineEarnRecordList != null) {
      //   mineEarnRecordList = detailModel.mineEarnRecordList;
      // }
      if(detailModel.mmineUserList != null) {
        minePayRecordList = detailModel.mmineUserList;
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
        actions: [
          IconButton(
              icon: Image.asset("assets/coins_record.png"),
              onPressed: () {
                Navigator.pushNamed(context, "/mineearn");
              },
            )
        ],
        child: Column(
          children: [
            HomeDetailHeadView(model: model, userCount: detailModel?.count,),
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
                    bottom: 0,
                    child: Column(
                      children: [
                        HomeDetailUserView(onTap: _getAction, title: model.mineTitle, endTime: null, coinName: model.pledgeCoinName, amount: model.pledgeAmount),
                        SizedBox(height: 60,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: minePayRecordList.length,
                            padding: const EdgeInsets.only(top: 0),
                            itemBuilder: (context, index) {
                              final tempmodel = minePayRecordList[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: HomeDetailUserView(onTap: _getAction, paytime: tempmodel.createTime, title: model.mineTitle, endTime: tempmodel.endTime, coinName: model.pledgeCoinName, amount: model.pledgeAmount,),
                              );
                            }
                          ),
                        )
                      ],
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}