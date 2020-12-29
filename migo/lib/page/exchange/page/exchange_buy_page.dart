import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/exchange/view/row_pay_view.dart';

class ExchangeBuyPage extends StatefulWidget {
  final Map params;

  const ExchangeBuyPage({Key key, this.params}) : super(key: key);

  @override
  _ExchangeBuyPageState createState() => _ExchangeBuyPageState();
}

class _ExchangeBuyPageState extends State<ExchangeBuyPage> {

  bool isasyncprice = true;
  Set paymethod = {};

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
        titles: "${I18n.of(context).expostbuy}(MIGO)",
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () {
              Navigator.pushNamed(context, "/exchangerecord");
            },
          )
        ],
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0, 2)
                  )
                ]
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${I18n.of(context).exposetnumber}：", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  SizedBox(height: 10,),
                  Stack(
                    children: [
                      NormalTextfield(
                        hintText: I18n.of(context).expostplease,
                        padding: const EdgeInsets.only(right: 60),
                        // controller: _controller,
                        // focusNode: _focusNode,
                      ),
                      Positioned(
                        right: 15,
                        top: 8,
                        bottom: 8,
                        child: Center(
                          child: Text("MIGO", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),)
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                    child: Text("${I18n.of(context).exsingleprice}：", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/input_back.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _RowSelectItem(isselect: isasyncprice, titles: I18n.of(context).expostasync, onTap: () {
                              setState(() {
                                isasyncprice = true;
                              });
                            },),
                            _RowSelectItem(isselect: !isasyncprice, titles: I18n.of(context).expostself, onTap: () {
                              setState(() {
                                isasyncprice = false;
                              });
                            },),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Stack(
                    children: [
                      NormalTextfield(
                        hintText: "",
                        padding: const EdgeInsets.only(right: 60),
                        textStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
                        // controller: _controller,
                        // focusNode: _focusNode,
                      ),
                      Positioned(
                        right: 15,
                        top: 8,
                        bottom: 8,
                        child: Center(
                          child: Text("MIGO", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),)
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                    child: Text("${I18n.of(context).expostbili}(-5%~5%)：", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/input_back.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _Item(img: "btn_price_minus_def",),
                            Expanded(
                              child: Center(
                                child: Text("1%", style: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),)
                              ),
                            ),
                            _Item(img: "btn_price_plus_def",),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                    child: Text("${I18n.of(context).expostpaymethod}：", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/input_back.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Text("微信", style: AppFont.textStyle(14, color: AppColor.back998),),
                            RowPaySelectItem(titles: I18n.of(context).paywx, isselect: paymethod.contains(0), onTap: () => _onSelectPay(0),),
                            RowPaySelectItem(titles: I18n.of(context).payalipay, isselect: paymethod.contains(1),onTap: () => _onSelectPay(1)),
                            RowPaySelectItem(titles: I18n.of(context).paybank, isselect: paymethod.contains(2),onTap: () => _onSelectPay(2)),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  BtnImageBottomView(
                    title: I18n.of(context).expostsend,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _Item extends StatelessWidget {
  final String img;

  const _Item({Key key, this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 44,
      color: const Color(0x1A7BA0B9),
      child: Image.asset("assets/$img.png"),
    );
  }
}

class _RowSelectItem extends StatelessWidget {
  final bool isselect;
  final Function onTap;
  final String titles;

  const _RowSelectItem({Key key, this.isselect, this.onTap, this.titles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset("assets/${isselect ? "radio_price_sel_sel" : "radio_price_unsel_unsel"}.png"),
          SizedBox(width: 6,),
          Text(titles, style: AppFont.textStyle(14, color: isselect ? AppColor.back998 : const Color(0xff7BA0B9)),),
        ],
      ),
    );
  }
}

