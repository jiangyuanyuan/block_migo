import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/exchange/model/sell_detail_model.dart';
import 'package:migo/page/exchange/view/alert_payinfo_dart.dart';
import 'package:migo/page/mine/model/mine_pay_model.dart';

import 'alert_userinfo.dart';

class ExchangeRecordCell extends StatelessWidget {
  final SellDetailModel model;
  final int orderType;
  final Function onRefresh;
  final Function(String payid, String orderid, String adid) onChangeStatus;
  const ExchangeRecordCell({Key key, this.model, this.orderType, this.onRefresh, this.onChangeStatus}) : super(key: key);

  Color _getColor() {
    switch (model.status) {
      case 0:
        return AppColor.red;
        break;
      case 1:
        return AppColor.back998;
      case 2:
        return AppColor.green;
      default:
        return AppColor.fontgrey;
    }
  }
  Color _getBackColor() {
    switch (model.status) {
      case 0:
        return const Color(0xffFCF2F3);
        break;
      case 1:
        return const Color(0xffF4F7FA);
        break;
      case 2:
        return const Color(0xffF2FBF4);
      case 3:
        return Colors.black.withOpacity(0.05);
        break;
      default:
        return Colors.black12;
    }
  }

  Widget _createStatus(BuildContext context) {
    switch (model.status) {
      case 0:
        return Text(I18n.of(context).rnotpay, style: AppFont.textStyle(12, color: _getColor()),);
        break;
      case 1:
        return Text(I18n.of(context).rnotsure, style: AppFont.textStyle(12, color: _getColor()),);
        break;
      case 2:
        return Text(I18n.of(context).rfinish, style: AppFont.textStyle(12, color: _getColor()),);
        break;
      default:
        return Text(I18n.of(context).rnotfinish, style: AppFont.textStyle(12, color: _getColor()),);
    }
  }

  String _getpayString(BuildContext context) {
    final listtitle = {
      1:I18n.of(context).payalipay, 
      2:I18n.of(context).paybank,
      3:"TRC20",
    };
    num money = model.userPayWay == 3 ? model.orderTotalUsdt : model.orderTotalCny;
    String uint = model.userPayWay == 3 ? "USDT" : "CNY";
    return I18n.of(context).rsurepay + " ${Tool.number(money, 2)} $uint(${listtitle[model.userPayWay]})";
  }

  void _requestChangePay(BuildContext context) {
    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.getUserPay+"${model.adId}/${model.userId}", method: HTTPMETHOD.GET, success: (data) {
      EasyLoading.dismiss();
      final temp = MinePaymethodResponse.fromJson(data);
      Alert.showViewDialog(context, AlertPayInfoView(
        list: temp.data,
        onSelect: (sender) {
          if(onChangeStatus != null) onChangeStatus(sender.id, model.id, model.adId);
        },
      ));
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  // 确定付款
  void _requestChangeStatus(BuildContext context) {
    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.payMoney, params: {
      "orderId":model.id,
    }, success: (data) {
      EasyLoading.dismiss();
      onRefresh();
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  //确认放币
  void _requestChangeCoinStatus(BuildContext context) {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd) {
      EasyLoading.show(status: 'Loading...');
      Networktool.request(API.payCoin, params: {
        "orderId":model.id,
        "txPassword":Tool.generateMd5(pwd)
      }, success: (data) {
        EasyLoading.dismiss();
        onRefresh();
      }, fail: (msg) => EasyLoading.showToast(msg),);
    },));
  }

  Widget _createBottom(BuildContext context) {
    if(orderType == 1) {
      switch (model.status) {
        case 0:{
          if(model.userPayWay != null) {
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
                BtnImageBottomView(
                  title: I18n.of(context).rsurepay,
                  onTap: () {
                    _requestChangeStatus(context);
                  },
                )
              ],
            );
          } else {
            return BtnImageBottomView(
              title: I18n.of(context).rpayinfo,
              onTap: () => _requestChangePay(context),
            );
          }
        }
          break;
        case 1:
          return BtnImageBottomView(
            title: I18n.of(context).rsurepaycoin,
            onTap: () {
              Alert.showViewDialog(context, AlerUserInfoView(usermobile: model.userMobile, username: model.userName ?? "--",));
            },
          );
          break;
        default:
          return SizedBox();
      }
    } else {
      switch (model.status) {
        case 0:{
          return BtnImageBottomView(
            img: "btn_inactive.png",
            title: I18n.of(context).sellwaitpay,
          );
        }
          break;
        case 1:
          return BtnImageBottomView(
            title: I18n.of(context).sellsellcoin,
            onTap: () => _requestChangeCoinStatus(context),
          );
          break;
        default:
          return SizedBox();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if(model.status == 3) {
          return;
        }
        final res = await Navigator.pushNamed(context, "/sell", arguments: {"model":model, "step":true, "ordertype": orderType, "issell": orderType == 2});
        if(onRefresh != null && res != null) onRefresh();
      },
      child: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 40,
              color: _getBackColor(),
              child: Row(
                children: [
                  Text(orderType == 1 ? I18n.of(context).rbuy : I18n.of(context).rsell, style: AppFont.textStyle(14, color: _getColor(), fontWeight: FontWeight.bold),),
                  SizedBox(width: 10,),
                  Text(Tool.timeFormat("yyyy-MM-dd HH:mm", model.createTime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  Spacer(),
                  _createStatus(context)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((orderType == 1 ? I18n.of(context).buynumber : I18n.of(context).sellnumber) + " (MIGO)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      Text((orderType == 1 ? I18n.of(context).buyamout : I18n.of(context).sellamount)  + "(USDT/CNY)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      // Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Tool.number(model.orderNumber, 2), style: AppFont.textStyle(12, color: AppColor.back998),),
                      Text(Tool.number(model.orderTotalUsdt, 2) + " / " + Tool.number(model.orderTotalCny, 2), style: AppFont.textStyle(12, color: AppColor.back998),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(I18n.of(context).exorderno, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      Text(I18n.of(context).subtime, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      // Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.orderNo, style: AppFont.textStyle(12, color: AppColor.back998),),
                      Text(Tool.timeFormat("yyyy-MM-dd HH:mm", model.updateTime), style: AppFont.textStyle(12, color: AppColor.back998),),
                    ],
                  ),
                  _createBottom(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}