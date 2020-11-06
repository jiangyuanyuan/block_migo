import 'package:flutter/material.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/contract/view/choose_coin_view.dart';

class ReflectPage extends StatefulWidget {
  
  @override
  _ReflectPageState createState() => _ReflectPageState();
}

class _ReflectPageState extends State<ReflectPage> {

  void _submit() {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd) {
      Navigator.pushNamed(context, "/reflectsuccess");
    },));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).withdraw,
        onPop: () => Navigator.pop(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ChooseCoinView(
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
                          child: Text("选择币种", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.2)), textAlign: TextAlign.center,)
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
                titles: ["USDT", "BTC"],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(I18n.of(context).withdrawaddress, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    SizedBox(height: 12,),
                    Stack(
                      children: [
                        IgnorePointer(
                          ignoring: true,
                          child: NormalTextfield(
                            hintText: I18n.of(context).pleaseinputorcopy,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: Image.asset("assets/scan_icon.png"),
                            onPressed: () {
                            },
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(I18n.of(context).withdrawnum, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    ),
                    NormalTextfield(
                      hintText: I18n.of(context).pleaseinputonumber,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffE5F0FA),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                          _Row(titles: I18n.of(context).availableamount, val: "1283 MIGO",),
                          SizedBox(height: 10,),
                          _Row(titles: I18n.of(context).handlingfee, val: "5%",),
                          SizedBox(height: 10,),
                          _Row(titles: I18n.of(context).actualarrival, val: "12 MIGO",)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Text(I18n.of(context).withdrawrule, style: AppFont.textStyle(12, color: Colors.black),),
                    ),
                    Text("1. 提现会扣取部分手续费，以实际到账为主。", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    SizedBox(height: 32,),
                    BtnAction(
                      title: I18n.of(context).sure,
                      onTap: _submit,
                    )
                  ]
                )
            )
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String titles;
  final String val;
  final double padding;
  const _Row({Key key, this.padding, this.titles, this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titles, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
        Text(val, style: AppFont.textStyle(12, color: AppColor.back998,)),
      ],
    );
  }
}