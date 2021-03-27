import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/exchange/model/Video_model.dart';
import 'package:migo/page/exchange/model/exchange_model.dart';
import 'package:migo/page/exchange/model/sell_detail_model.dart';
import 'package:migo/page/mine/model/mine_pay_model.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';

class ExchangeCell extends StatelessWidget {
  final int index;
  final ExhangeModel model;
  final Function onRefresh;
  const ExchangeCell({Key key, this.index, this.onRefresh, this.model}) : super(key: key);
  

  void _submit(BuildContext context) {
    // EasyLoading.show(status: "Loading...");
    // Navigator.pushNamed(context, "/sell", arguments: {"model": temp.data, "issell": true});
    // Navigator.pushNamed(context, "/adVideo",arguments: {"model": model,"video":List()});
    Networktool.request(API.videoAd, method: HTTPMETHOD.GET, success: (data) {
      final temp = VideoModel.fromJson(data);
      if(temp.data.isNotEmpty){
        Navigator.pushNamed(context, "/adVideo",arguments: {"model": model,"video":temp.data});
      }else{
        Networktool.request(API.userPays, method: HTTPMETHOD.GET, success: (data) {
          final temp = MinePaymethodResponse.fromJson(data);
          if(temp.data.length == 0) {
            EasyLoading.dismiss();
            Alert.showMsgDialog(context, title: I18n.of(context).notice, msg: I18n.of(context).addpaymethod, callback: () {
              // Navigator.pushNamed(context, "/login", arguments: {'modtype': 2});
              Navigator.pushNamed(context, "/paysetting", arguments: {"payways":[1,2,3]});
            });
          } else {
            _jumppage(context);
          }
        }, fail: (msg) => EasyLoading.showToast(msg),);

      }
    });
  }

  void _jumppage(BuildContext context) {
    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.buildOrder, params: {
      "adId":model.id,
    }, success: (data) async {
      EasyLoading.dismiss();
      final temp = SellDetailResponse.fromJson(data);
      temp.data.sellMobile = "--";
      final res = await Navigator.pushNamed(context, "/sell", arguments: {"model": temp.data, "issell": true});
      if(res != null) onRefresh();
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  @override
  Widget build(BuildContext context) {
    final pays = model.orderPayWay.split(",");
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 24),
            color: const Color(0xffF4F7FA),
            child: Row(
              children: [
                Text(I18n.of(context).exorderno, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Text(model.adNo, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Item(title: "${I18n.of(context).exordernoNum}(MIGO)", val: Tool.number(model.orderNumber, 2),),
                _Item(title: "${I18n.of(context).exsingleprice}(USDT)", val: Tool.number(model.orderPrice, 3),),
                _Item(title: "${I18n.of(context).expreamount}(USDT)", val: Tool.number(model.orderAmount, 2),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 5),
                  child: Text(I18n.of(context).expostpaymethod + ":", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                ),
                _ImageItem(isshow: pays.contains("3"), name: "usdt",),
                _ImageItem(isshow: pays.contains("2"), name: "logo_colle_bank_def",),
                _ImageItem(isshow: pays.contains("1"), name: "alipay",),
                Spacer(),
                SizedBox(
                  width: 80,
                  height: 45,
                  child: BtnImageBottomView(
                    img: "home_btn.png",
                    onTap: () {
                      _submit(context);
                    },
                    title: I18n.of(context).exsellnow,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16,)
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String val;

  const _Item({Key key, this.title, this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
        SizedBox(height: 8,),
        Text(val, style: AppFont.textStyle(12, color: AppColor.back998),)
      ],
    );
  }
}

class _ImageItem extends StatelessWidget {
  final String name;
  final bool isshow;
  const _ImageItem({Key key, this.name, this.isshow = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isshow,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 10),
        child: Image.asset("assets/$name.png", fit: BoxFit.fitHeight, height: 20,),
      )
    );
  }
}