import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textfield_number.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/exchange/view/row_pay_view.dart';
import 'package:migo/page/mine/model/mine_pay_model.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';

class ExchangeBuyPage extends StatefulWidget {
  final Map params;

  const ExchangeBuyPage({Key key, this.params}) : super(key: key);

  @override
  _ExchangeBuyPageState createState() => _ExchangeBuyPageState();
}

class _ExchangeBuyPageState extends State<ExchangeBuyPage> {

  bool isasyncprice = true;
  Set paymethod = {};
  String price = "6.5";
  int rate = 0;
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  List<PaymethodModel> paywas = [];

  @override
  void initState() {
    super.initState();
    price = widget.params["price"];
    _controller1.text = price;
    _focusNode1.addListener(() { 
      if(!_focusNode1.hasFocus) {
        final temp = num.parse(_controller1.text);
        num max = num.parse(price) * 1.05;
        num min = num.parse(price) * 0.95;
        if(temp > max) {
          _controller1.text = Tool.number(max, 3);
        }
        if(temp < min) {
          _controller1.text = Tool.number(min, 3);
        }
      }
    });
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
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _clear(){
    _focusNode.unfocus();
    _focusNode1.unfocus();
    _focusNode2.unfocus();
  }

  void _submit() {
    final user = Provider.of<UserModel>(context, listen: false).data;
    if(user.txPassword == null || user.txPassword == "") {
      Alert.showMsgDialog(context, title: I18n.of(context).notice, msg: I18n.of(context).nottxpwd, callback: () {
        Navigator.pushNamed(context, "/login", arguments: {'modtype': 2});
      });
      return;
    }
    if(paymethod.length == 0) {
      EasyLoading.showToast(I18n.of(context).pleaseaddpay);
      return;
    }
    if(_controller.text.isEmpty || num.parse(_controller.text) == 0) {
      EasyLoading.showToast(I18n.of(context).expostplease);
      return;
    }
    if(_controller1.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseprice);
      return;
    }

    num temp = num.parse(_controller1.text);
    num max = num.parse(price) * 1.05;
    num min = num.parse(price) * 0.95;
    String tempp = temp.toString();
    if(temp > max) {
      tempp = Tool.number(max, 3);
    }
    if(temp < min) {
      tempp = Tool.number(min, 3);
    }

    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.otcAdd, params: {
      	"orderNumber": _controller.text,
        "orderPayWay": paymethod.join(","),
        "orderPrice": tempp,
        "orderType": 1,
        "priceRate": rate,
        "priceType": isasyncprice ? 1 : 2
    }, success: (data) {
      EasyLoading.dismiss();
      Navigator.pop(context, {"refresh": true});
    }, fail: (msg) => EasyLoading.showToast(msg),);
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
        child: GestureDetector(
          onTap: _clear,
          behavior: HitTestBehavior.translucent,
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
                          controller: _controller,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          focusNode: _focusNode,
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
                                _clear();
                                _controller1.text = price;
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
                        IgnorePointer(
                          ignoring: isasyncprice,
                          child: NormalTextfield(
                            hintText: "",
                            padding: const EdgeInsets.only(right: 60),
                            textStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
                            controller: _controller1,
                            focusNode: _focusNode1,
                            inputFormatters: [
                              NumberFormat(decimalRange: 4)
                            ],
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 8,
                          bottom: 8,
                          child: Center(
                            child: Text("USDT", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),)
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: !isasyncprice,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    _Item(img: "btn_price_minus_def", onTap: () {
                                      if(rate <= -5) return;
                                      setState(() {
                                        rate -= 1;
                                      });
                                      _controller1.text = (num.parse(price) * (1 + rate / 100)).toStringAsFixed(3);
                                    },),
                                    Expanded(
                                      child: Center(
                                        child: Text("$rate%", style: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),)
                                      ),
                                    ),
                                    _Item(img: "btn_price_plus_def", onTap: () {
                                      if(rate >= 5) return;
                                      setState(() {
                                        rate += 1;
                                      });
                                      _controller1.text = (num.parse(price) * (1 + rate / 100)).toStringAsFixed(3);
                                    },),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
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
                            // children: List.generate(3, (index) => RowPaySelectItem(titles: listtitle[index + 1], isselect: paymethod.contains(index), onTap: () => _onSelectPay(index),),).toList(),
                            children: [
                              // Text("微信", style: AppFont.textStyle(14, color: AppColor.back998),),
                              RowPaySelectItem(titles: "TRC20", isselect: paymethod.contains(3), onTap: () => _onSelectPay(3),),
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
                      onTap: _submit,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _Item extends StatelessWidget {
  final String img;
  final Function onTap;
  const _Item({Key key, this.img, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 44,
        color: const Color(0x1A7BA0B9),
        child: Image.asset("assets/$img.png"),
      ),
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

