import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/exchange/model/sell_detail_model.dart';
import 'package:migo/page/exchange/view/alert_choose_apply.dart';
import 'package:migo/page/exchange/view/alert_payinfo_dart.dart';
import 'package:migo/page/exchange/view/alert_userinfo.dart';
import 'package:migo/page/exchange/view/endtime_view.dart';
import 'package:migo/page/exchange/view/row_pay_view.dart';
import 'package:migo/page/exchange/view/step_view.dart';
import 'package:migo/page/mine/model/mine_pay_model.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';

import '../../../common/commview/alert.dart';

class SellPage extends StatefulWidget {
  final Map params;

  const SellPage({Key key, this.params}) : super(key: key);
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {

  Set<String> paymethod = {};
  int step = 1;
  SellDetailModel detailModel;
  /// 1买入, 2卖出
  int ordertype = 2;
  bool issell = true;
  @override
  void initState() {
    super.initState();
    detailModel = widget.params["model"];
    issell = widget.params["issell"];
    if(detailModel.orderPayWay != null) {
      paymethod = detailModel.orderPayWay.split(",").toSet();
    }
    if(widget.params["step"] != null) {
      // step = widget.params["step"];
      switch (detailModel.status) {
        case 0:
          step = 2;
          break;
        case 1:
          step = 3;
          break;
        case 2:
          step = 4;
          break;
        default:
      }
    }
    if(widget.params["ordertype"] != null) {
      ordertype = widget.params["ordertype"];
    }
  }

  void _submit() {
    final user = Provider.of<UserModel>(context, listen: false).data;
    if(user.txPassword == null || user.txPassword == "") {
      Alert.showMsgDialog(context, title: I18n.of(context).notice, msg: I18n.of(context).nottxpwd, callback: () {
        Navigator.pushNamed(context, "/login", arguments: {'modtype': 2});
      });
      return;
    }
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (sender) {
      EasyLoading.show(status: 'Loading...');
      Networktool.request(API.sureaddOrder, params: {
        "adId": detailModel.adId,
        "orderNo": detailModel.orderNo,
        "txPassword": Tool.generateMd5(sender)
      }, success: (data) {
        EasyLoading.showToast(I18n.of(context).success);
        Navigator.pop(context, {"refresh": true});
      }, fail: (msg) => EasyLoading.showToast(msg),);
    },));
  }

  Widget _createpay(BuildContext context) {
    final listtitle = {
      "1":I18n.of(context).payalipay, 
      "2":I18n.of(context).paybank,
      "3":"TRC20",
    };
    if(detailModel.orderPayWay == null) {
      return SizedBox();
    }
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE5F0FA),
        borderRadius: BorderRadius.circular(4)
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: detailModel.orderPayWay.split(",").map((e) => RowPaySelectItem(titles: listtitle[e], isselect: true,),).toList()),
    );
  }

  // 申诉类型 1 状态为买家付款时,卖家点(买家已付款,确认放币) 2 状态为买家付款时 卖家点(买家未付款，交易取消) 3 状态为卖家放币时 卖家点(买家未付款，交易取消) 4 状态为卖家放币时 买家点(我已付款，卖家未放币)
  void _applyOrder(int type) {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd) {
      EasyLoading.show(status: "Loading...");
      Networktool.request(API.otctappealOrder, params: {
          "appealType": type,
          "id": detailModel.id,
          "txPassword": Tool.generateMd5(pwd)
      }, success: (data) {
        EasyLoading.showToast(I18n.of(context).success);
        Navigator.pop(context, {"refresh": true});
      }, fail: (msg) => EasyLoading.showToast(msg));
    },));
  }

  Widget _createBottom(BuildContext context) {
    if(ordertype == 1) { // 买单
      switch (detailModel.status) {
        case 0:{
          if(detailModel.userPayWay != null) {
            return Column(
              children: [
                InkWell(
                  onTap: () => _requestChangePay(context),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 42,
                      child: Stack(
                        children: [
                          Image.asset("assets/input_back.png", fit: BoxFit.fill, width: double.infinity,),
                          Positioned(
                            left: 10,
                            height: 42,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(_getpayString(context), style: AppFont.textStyle(12, color: Colors.black), textAlign: TextAlign.center,)
                            ),
                          ),
                          Positioned(
                            right: 10,
                            height: 42,
                            child: Image.asset("assets/coin_select.png"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                EndTimeView(
                  endtime: 0,
                  onTap: () {
                    Alert.showViewDialog(context, AlertChooseApplyView(
                      titles: [I18n.of(context).notrealname],
                      onTap: (sender) {
                        _applyOrder(6);
                      },
                    ));
                  },
                ),
                BtnImageBottomView(
                  title: I18n.of(context).rsurepay,
                  onTap: () {
                    _requestChangeStatus(context);
                  },
                )
              ],
            );
          } else {
            return Column(
              children: [
                EndTimeView(
                  endtime: 0,
                  onTap: () {
                    Alert.showViewDialog(context, AlertChooseApplyView(
                      titles: [I18n.of(context).notrealname],
                      onTap: (sender) {
                        _applyOrder(6);/// 付款信息不符合交易取消
                      },
                    ));
                  },
                ),
                BtnImageBottomView(
                  title: I18n.of(context).rpayinfo,
                  onTap: () => _requestChangePay(context),
                ),
              ],
            );
          }
        }
          break;
        case 1:
          return Column(
            children: [
              EndTimeView(
                endtime: detailModel.buyCancelOfTime,
                onTap: () {
                  // Alert.showBottomDialog(context, [I18n.of(context).sellnotpaycoin], onTapIndex: (index){
                  //   _applyOrder(4);
                  // });
                  Alert.showViewDialog(context, AlertChooseApplyView(
                    titles: [I18n.of(context).sellnotpaycoin],
                    onTap: (sender) {
                      _applyOrder(4);
                    },
                  ));
                },
              ),
              BtnImageBottomView(
                title: I18n.of(context).rsurepaycoin,
                onTap: () {
                  Alert.showViewDialog(context, AlerUserInfoView(usermobile: detailModel.userMobile, username: detailModel.userName ?? "--",));
                },
              ),
            ],
          );
          break;
        default:
          return SizedBox();
      }
    } else {
      switch (detailModel.status) {
        case 0:{
          return Column(
            children: [
              EndTimeView(
                endtime: detailModel.outOfTime,
                onTap: () {
                  // Alert.showBottomDialog(context, [I18n.of(context).buynotpay, I18n.of(context).buypaiad, I18n.of(context).notpayall], onTapIndex: (index){
                  //   if(index == 1) {
                  //     _applyOrder(1);
                  //   } else {
                  //     _applyOrder(2);
                  //   }
                  // });
                  Alert.showViewDialog(context, AlertChooseApplyView(
                    titles: [I18n.of(context).buynotpay, I18n.of(context).buypaiad, I18n.of(context).notpayall],
                    onTap: (sender) {
                      if(sender == 0) {
                        _applyOrder(1);
                      } else if(sender == 1){
                        _applyOrder(2);
                      } else {
                        _applyOrder(5);
                      }
                    },
                  ));
                },
              ),
              BtnImageBottomView(
                img: "btn_inactive.png",
                title: I18n.of(context).sellwaitpay,
              ),
            ],
          );
        }
          break;
        case 1:
          return Column(
            children: [
              EndTimeView(
                endtime: detailModel.cancelOfTime,
                onTap: () {
                  // Alert.showBottomDialog(context, [I18n.of(context).buynotpay], onTapIndex: (index){
                  //   _applyOrder(3);
                  // });
                  Alert.showViewDialog(context, AlertChooseApplyView(
                    titles: [I18n.of(context).buynotpay, I18n.of(context).notpayall],
                    onTap: (sender) {
                      if(sender == 0) {
                        _applyOrder(3);
                      } else {
                        _applyOrder(5);
                      }
                    },
                  ));
                },
              ),
              BtnImageBottomView(
                title: I18n.of(context).sellsellcoin,
                onTap: () => _requestChangeCoinStatus(context),
              ),
            ],
          );
          break;
        default:
          return SizedBox();
      }
    }
  }


  String _getpayString(BuildContext context) {
    final listtitle = {
      1:I18n.of(context).payalipay, 
      2:I18n.of(context).paybank,
      3:"TRC20",
    };
    num money = detailModel.userPayWay == 3 ? detailModel.orderTotalUsdt : detailModel.orderTotalCny;
    String uint = detailModel.userPayWay == 3 ? "USDT" : "CNY";
    return I18n.of(context).rsurepay + " ${Tool.number(money, 2)} $uint(${listtitle[detailModel.userPayWay]})";
  }

  void _requestChangePay(BuildContext context) {
    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.getUserPay+"${detailModel.adId}/${detailModel.userId}", method: HTTPMETHOD.GET, success: (data) {
      EasyLoading.dismiss();
      final temp = MinePaymethodResponse.fromJson(data);
      Alert.showViewDialog(context, AlertPayInfoView(
        list: temp.data,
        onSelect: (sender) {
          // print("abc");
          _changeStatus(sender.id, detailModel.id, detailModel.adId, sender.payWay, sender.payName);
        },
      ));
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  void _changeStatus(String payid, String orderid, String aid, int payway, String payname) {
    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.orderPay, params: {
      	"adId": aid,
        "orderId": orderid,
        "userPayId": payid
    }, success: (data) {
      EasyLoading.dismiss();
      setState(() {
        detailModel.userPayWay = payway;
        detailModel.userPayName = payname;
      });
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  // 确定付款
  void _requestChangeStatus(BuildContext context) {
    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.payMoney, params: {
      "orderId":detailModel.id,
    }, success: (data) {
      // EasyLoading.dismiss();
      // setState(() {
      //   detailModel.status = 1;
      //   step = 3;
      // });
      EasyLoading.showToast(I18n.of(context).success);
      Navigator.pop(context, {"refresh": true});
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  //确认放币
  void _requestChangeCoinStatus(BuildContext context) {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd) {
      EasyLoading.show(status: 'Loading...');
      Networktool.request(API.payCoin, params: {
        "orderId":detailModel.id,
        "txPassword":Tool.generateMd5(pwd)
      }, success: (data) {
        EasyLoading.dismiss();
        setState(() {
          detailModel.status = 2;
          step = 4;
        });
      }, fail: (msg) => EasyLoading.showToast(msg),);
    },));
  }

  @override
  Widget build(BuildContext context) {
    final listtitle = {
      1:I18n.of(context).payalipay, 
      2:I18n.of(context).paybank,
      3:"TRC20",
    };
    return Scaffold(
      body: CommbackView(
        titles: (ordertype == 1 ? I18n.of(context).rbuy : I18n.of(context).rsell) + "(MIGO)",
        onPop: () => Navigator.pop(context, {"refresh": true}),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StepView(step: step,),
              SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 2),
                      color: Colors.black.withOpacity(0.4)
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE5F0FA),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 2),
                      child: Column(
                        children: [
                          _ItemLabel(title: I18n.of(context).exorderno + "：", val: detailModel.orderNo,),
                          _ItemLabel(title: issell ? I18n.of(context).selluser : I18n.of(context).sellllllluser, val: issell ? detailModel.sellMobile : detailModel.userMobile,),
                          _ItemLabel(title: I18n.of(context).exposetnumber + "：", val: "${Tool.number(detailModel.orderNumber, 2)} MIGO",),
                          _ItemLabel(title: I18n.of(context).selllevel + "：", val: "M${detailModel.userLevel} ${Tool.number(detailModel.userFee * 100, 2)}%", color: const Color(0xffF28600),),
                          _ItemLabel(title: I18n.of(context).sellfee + "：", val: "${Tool.number(detailModel.userTotalSell - detailModel.orderNumber, 2)} MIGO",),
                          _ItemLabel(title: I18n.of(context).selltotalnumber + "：", val: "${Tool.number(detailModel.userTotalSell, 2)} MIGO",),
                          _ItemLabel(title: I18n.of(context).sellsingleprice + "：", val: "${Tool.number(detailModel.orderPrice, 2)} USDT",),
                          _ItemLabel(title: I18n.of(context).selltotalprice + "：", val: "${detailModel.orderTotalUsdt} USDT ≈ ${Tool.number(detailModel.orderTotalCny, 2)} CNY",),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Row(
                        children: [
                          Text(I18n.of(context).sellneedknow, style: AppFont.textStyle(12),),
                          Text(I18n.of(context).sellneedknowinfo, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, top: 10, bottom: 10),
                      child: Text(I18n.of(context).sellpaymethod, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    ),
                    _createpay(context),
                    Visibility(
                      visible: step > 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffE5F0FA),
                          borderRadius: BorderRadius.circular(4)
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 2),
                        child: Column(
                          children: [
                            _ItemLabel(title: I18n.of(context).selluser, val: detailModel.userPayName,),
                            _ItemLabel(title: I18n.of(context).expostpaymethod + "：", val: listtitle[detailModel.userPayWay],),
                            _ItemLabel(title: I18n.of(context).realpayamount + "：", val: "${detailModel.orderTotalUsdt} USDT / ${Tool.number(detailModel.orderTotalCny, 2)} CNY",),
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 40,),
                    Visibility(
                      visible: step > 2,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset("assets/success_icon.png"),
                            SizedBox(height: 14,),
                            Text(I18n.of(context).sellpaid, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: step == 1 ? BtnImageBottomView(
                        title: I18n.of(context).sure,
                        onTap: _submit,
                      ) : _createBottom(context),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemLabel extends StatelessWidget {
  final String title;
  final String val;
  final Color color;

  const _ItemLabel({Key key, this.title, this.val, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
          Text(val ?? "--", style: AppFont.textStyle(12, color: color ?? AppColor.back998),)
        ],
      ),
    );
  }
}
