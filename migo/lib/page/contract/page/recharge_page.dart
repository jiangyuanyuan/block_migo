import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/screen_tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/model/recharge_model.dart';
import 'package:migo/page/contract/view/choose_coin_view.dart';
import 'package:migo/page/contract/view/recharge_head_view.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RechagePage extends StatefulWidget {
  @override
  _RechagePageState createState() => _RechagePageState();
}

class _RechagePageState extends State<RechagePage> {

  int type = 0;
  List<RechargeModel> list = [];
  String coinName = "--";
  String address = "";
  num minadd = 1;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value) => _request());
  }

  void _request() {
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.rechargeCoinList, success: (data) {
      EasyLoading.dismiss();
      final temp = RechargeResponse.fromJson(data);
      list = temp.data;
      if(list.length > 0) {
        coinName = list.first.coinName;
        _updateAmount(list.first);
      }
      if(mounted) setState(() {
        
      });
    }, fail: (msg) => EasyLoading.showError(msg),);
  }

  void _updateAmount(RechargeModel model) {
    if(mounted) {
      setState(() {
        coinName = model.coinName;
        minadd = model.minRechargeQty;
        address = type == 0 ? model.trcAddress : model.baseAddress;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).recharge,
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () {
              Navigator.pushNamed(context, "/coinsrecord", arguments: {"isrecharge" : true});
            },
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ChooseCoinView(
                  onSelected: (selectindex, sender) {
                    _updateAmount(list[selectindex]);
                  },
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
                            child: Text(coinName, style: AppFont.textStyle(12, color: Colors.black), textAlign: TextAlign.center,)
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
                  titles: list.map((e) => e.coinName).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    RechargeHeadView(
                      onSelected: (tabindex) {
                        setState(() {
                          type = tabindex;
                          final e = list.firstWhere((element) => element.coinName == coinName);
                          address = type == 0 ? e.trcAddress : e.baseAddress;
                        });

                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                      child: Text(I18n.of(context).scanqrtorecharge, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: 180,
                      height: 180,
                      color: Colors.white,
                      child: QrImage(data: address,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(I18n.of(context).copyaddress, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xffE5F0FA),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(address, style: AppFont.textStyle(12, color: AppColor.back998),),
                          IconButton(
                            icon: Image.asset("assets/coin_copy.png"),
                            onPressed: () {
                              ScreenTool.copy(address);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(I18n.of(context).notice, style: AppFont.textStyle(14, color: Colors.white),),
                    SizedBox(height: 20,),
                    // Text(I18n.of(context).notice1("$minadd"), style: AppFont.textStyle(14, color: Colors.white.withOpacity(0.5)),),
                    // SizedBox(height: 10,),
                    Text(I18n.of(context).notice2("${type == 0 ? "TRC20_": "ERC20_"}$coinName"), style: AppFont.textStyle(14, color: Colors.white.withOpacity(0.5)),),
                    SizedBox(height: 10,),
                    Text(I18n.of(context).notice3, style: AppFont.textStyle(14, color: Colors.white.withOpacity(0.5)),),
                    SizedBox(height: 10,),
                    Text(I18n.of(context).notice4, style: AppFont.textStyle(14, color: Colors.white.withOpacity(0.5)),),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}