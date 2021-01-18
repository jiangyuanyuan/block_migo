import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/page/mine/model/me_model.dart';
import 'package:migo/page/mine/view/alert_account_pay_view.dart';

import '../../../common/commview/alert.dart';
import '../../../common/commview/btn_image_bottom.dart';
import '../../../common/commview/commback_view.dart';
import '../../../common/textstyle/textstyle.dart';
import '../../../generated/i18n.dart';
import '../../contract/view/alert_password_view.dart';

class AutoAccountPage extends StatefulWidget {
  @override
  _AutoAccountPageState createState() => _AutoAccountPageState();
}

class _AutoAccountPageState extends State<AutoAccountPage> {
  
  bool islock = false;
  String _remark = "";
  List<MineCoinModel> list = [];
  num amount = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      _requestUserInfo();
      _request();
    });
  }

  void _requestUserInfo() {
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.getUserMsg, method: HTTPMETHOD.GET, success: (data) {
      EasyLoading.dismiss();
      final temp = data["data"];
      if(temp != null) {
        islock = temp["status"] == 2;
        if(islock) {
          _remark = temp["remark"];
        }
      }
      if(mounted) setState(() { });
    });
  }

  void _request() {
    Networktool.request(API.mePage, success: (data){
      final _meModel = MeResponse.fromJson(data).data;
      list = _meModel.accountList;
      MineCoinModel model = list.firstWhere((element) => element.coinName == "MIGO");
      amount = model.amount;
      if(mounted) setState(() {
        
      });
    },);
  }

  void _alertAccount() {
    Alert.showBottomViewDialog(context, AlertAccountPayView(amount: amount,onTap: () {
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (sender) {
          EasyLoading.show(status: "Loading...");
          Networktool.request(API.unsealUser, params: {
            "txPassword":Tool.generateMd5(sender),
          }, success: (data) {
            EasyLoading.showToast(I18n.of(context).success);
            EventBus.instance.commit(EventKeys.RefreshMine, null);
            Navigator.pop(context);
            setState(() {
              islock = false;
            });
          }, fail: (msg) => EasyLoading.showToast(msg),);
        },));
      });
    },));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).autoaccount,
        onPop: () => Navigator.pop(context),
        backImg: "share_bg.png",
        child: Column(
          children: [
            SizedBox(height: 40,),
            Image.asset("assets/logo.png"),
            Expanded(
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Image.asset("assets/bg_lock_bg_def.png"),
                        Positioned.fill(
                          child: Image.asset("assets/${islock ? "img_acco_lock_def" : "img_acco_open_def"}.png")
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(islock ? "$_remark" : I18n.of(context).accountright, style: AppFont.textStyle(12, color: const Color(0xff23496E)),),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
                    Visibility(
                      visible: islock,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BtnImageBottomView(
                          title: I18n.of(context).unlockaccount,
                          onTap: _alertAccount,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}