import 'package:flutter/material.dart';
import 'package:migo/page/mine/view/alert_account_pay_view.dart';

import '../../../common/commview/alert.dart';
import '../../../common/commview/alert.dart';
import '../../../common/commview/btn_image_bottom.dart';
import '../../../common/commview/commback_view.dart';
import '../../../common/textstyle/textstyle.dart';
import '../../../generated/i18n.dart';
import '../../../generated/i18n.dart';
import '../../contract/view/alert_password_view.dart';

class AutoAccountPage extends StatefulWidget {
  @override
  _AutoAccountPageState createState() => _AutoAccountPageState();
}

class _AutoAccountPageState extends State<AutoAccountPage> {
  
  bool islock = false;

  void _alertAccount() {
    Alert.showBottomViewDialog(context, AlertAccountPayView(onTap: () {
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (sender) {

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
                      child: Text(islock ? "abc" : I18n.of(context).accountright, style: AppFont.textStyle(12, color: const Color(0xff23496E)),),
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