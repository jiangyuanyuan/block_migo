import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textfield_number.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/contract/model/reflect_model.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/contract/view/choose_coin_view.dart';
import 'package:migo/page/contract/view/recharge_head_view.dart';

class ReflectPage extends StatefulWidget {
  
  @override
  _ReflectPageState createState() => _ReflectPageState();
}

class _ReflectPageState extends State<ReflectPage> {

  List<ReflectModel> list = [];
  String coinName = "";
  num banlance = 0;
  num fee = 0;
  num outnumber = 0;
  TextEditingController _editingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TextEditingController _numController = TextEditingController();
  FocusNode _numFocusNode = FocusNode();
  // 1ERC20提币 2TRC20提币
  int type = 1;
  @override
  void initState() {
    super.initState();
    _requestCoinList();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _numController.dispose();
    super.dispose();
  }

  void _requestCoinList() {
    Networktool.request(API.withDrawCoins, success: (data) {
      final temp = ReflectResponse.fromJson(data);
      list = temp.data;
      if(list.length > 0) {
        _updateAmount(list.first);
      }
      if(mounted) setState(() {
        
      });
    });
  }

  void _updateAmount(ReflectModel model) {
    coinName = model.wCoin.coinName;
    banlance = model.account.amount;
    fee = model.wCoin.outWithdrawFee ?? 0;
    setState(() {
    });
  }

  void _submit() {
    if(_editingController.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinput);
      return;
    }

    if(_numController.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputonumber);
      return;
    }
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd) {
      _reqeust(pwd);
    },));
  }

  void _reqeust(String pwd) {
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.withDrawOut, params: {
      	"amount": _numController.text,
        "coinName": coinName,
        "fee": fee,
        "outType": type,
        "toAddress": _editingController.text,
        "txPassword": pwd
    }, success: (data) {
      EasyLoading.showToast(I18n.of(context).success);
      // Navigator.pop(context);
      Navigator.pushNamed(context, "/reflectsuccess", arguments: {
        "coinName":coinName,
        "num": outnumber,
        "realnum":Tool.number(outnumber * (1 - fee), 4),
        "fee":"${Tool.number(fee * 100, 2)}%"
      });
    }, fail: (e) => EasyLoading.showError(e));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _focusNode.unfocus();
          _numFocusNode.unfocus();
        },
        child: CommbackView(
          titles: I18n.of(context).withdraw,
          onPop: () => Navigator.pop(context),
          actions: [
            IconButton(
              icon: Image.asset("assets/coins_record.png"),
              onPressed: () {

              },
            )
          ],
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
                            child: Text(coinName, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.2)), textAlign: TextAlign.center,)
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
                  titles: list.map((e) => e.wCoin.coinName).toList(),
                ),
              ),
              
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  // padding: const EdgeInsets.symmetric(),
                  // padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RechargeHeadView(
                        onSelected: (tabindex) {
                          type = tabindex == 0 ? 1 : 2;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(I18n.of(context).withdrawaddress, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                            SizedBox(height: 12,),
                            Stack(
                              children: [
                                NormalTextfield(
                                  controller: _editingController,
                                  focusNode: _focusNode,
                                  hintText: I18n.of(context).pleaseinputorcopy,
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
                              controller: _numController,
                              focusNode: _numFocusNode,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                NumberFormat(decimalRange: 4)
                              ],
                              onChanged: (val) {
                                outnumber = num.parse(val);
                                setState(() {
                                });
                              },
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
                                  _Row(titles: I18n.of(context).availableamount, val: "${Tool.number(banlance, 2)} $coinName",),
                                  SizedBox(height: 10,),
                                  _Row(titles: I18n.of(context).handlingfee, val: "${Tool.number(fee * 100, 2)}%",),
                                  SizedBox(height: 10,),
                                  _Row(titles: I18n.of(context).actualarrival, val: "${Tool.number(outnumber * (1 - fee), 4)} $coinName",)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                              child: Text(I18n.of(context).withdrawrule, style: AppFont.textStyle(12, color: Colors.black),),
                            ),
                            Text(I18n.of(context).withDrawNotice, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                            SizedBox(height: 32,),
                            BtnAction(
                              title: I18n.of(context).sure,
                              onTap: _submit,
                            )
                          ],
                        ),
                      )
                    ]
                  )
              )
            ],
          ),
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