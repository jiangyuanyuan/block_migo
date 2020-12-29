import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/exchange/view/row_pay_view.dart';
import 'package:migo/page/exchange/view/step_view.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {

  Set paymethod = {};

  @override
  void initState() {
    super.initState();
  }

  void _onSelectPay(int sender) {
    if(paymethod.contains(sender)) {
      paymethod.remove(sender);
    } else {
      paymethod.add(sender);
    }
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).rsell + "(MIGO)",
        onPop: () => Navigator.pop(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StepView(step: 4,),
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
                          _ItemLabel(title: I18n.of(context).exorderno + "：", val: "1000",),
                          _ItemLabel(title: I18n.of(context).selluser, val: "1000",),
                          _ItemLabel(title: I18n.of(context).exposetnumber + "：", val: "1000 MIGO",),
                          _ItemLabel(title: I18n.of(context).exsingleprice + "：", val: "1.10 USDT",),
                          _ItemLabel(title: I18n.of(context).totalprice + "：", val: "1000 USDT",),
                          _ItemLabel(title: I18n.of(context).sellfee + "%：", val: "M3 30%", color: const Color(0xffF28600),),
                          _ItemLabel(title: I18n.of(context).sellfee + "：", val: "30 MIGO",),
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
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE5F0FA),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 2),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Text("微信", style: AppFont.textStyle(14, color: AppColor.back998),),
                            RowPaySelectItem(titles: I18n.of(context).paywx, isselect: paymethod.contains(0), onTap: () => _onSelectPay(0),),
                            RowPaySelectItem(titles: I18n.of(context).payalipay, isselect: paymethod.contains(1),onTap: () => _onSelectPay(1)),
                            RowPaySelectItem(titles: I18n.of(context).paybank, isselect: paymethod.contains(2),onTap: () => _onSelectPay(2)),
                          ],
                        ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE5F0FA),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 2),
                      child: Column(
                        children: [
                          _ItemLabel(title: I18n.of(context).selluser, val: "1000",),
                          _ItemLabel(title: I18n.of(context).expostpaymethod + "：", val: I18n.of(context).payalipay,),
                        ],
                      ),
                    ),
                    Divider(height: 40,),
                    Center(
                      child: Column(
                        children: [
                          Image.asset("assets/success_icon.png"),
                          SizedBox(height: 14,),
                          Text(I18n.of(context).sellpaid, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BtnImageBottomView(
                        title: I18n.of(context).sure,
                      ),
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
          Text(val, style: AppFont.textStyle(12, color: color ?? AppColor.back998),)
        ],
      ),
    );
  }
}