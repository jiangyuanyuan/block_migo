import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/contract/view/choose_coin_view.dart';

class PaySettingPage extends StatefulWidget {
  final Map params;

  const PaySettingPage({Key key, this.params}) : super(key: key);
  @override
  _PaySettingPageState createState() => _PaySettingPageState();
}

class _PaySettingPageState extends State<PaySettingPage> {
  
  int paymethod = 0;
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  List<int> payways = [];
  @override
  void initState() {
    super.initState();
    payways = widget.params["payways"];
    paymethod = payways.first;
    EventBus.instance.addListener(EventKeys.RefreshQrCode, (arg) { 
      _controller1.text = arg;
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    EventBus.instance.removeListener(EventKeys.RefreshQrCode);
    super.dispose();
  }

  void _clear() {
    _focusNode.unfocus();
    _focusNode1.unfocus();
    _focusNode2.unfocus();
    _focusNode3.unfocus();
  }

  void _scanAction() {
    Navigator.pushNamed(context, "/qrcode");
  }

  void _submit() {
    if(_controller.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).susernameplease);
      return;
    }
    if(_controller1.text.isEmpty) {
      EasyLoading.showToast(paymethod == 2 ? I18n.of(context).pleaseinputorcopy : I18n.of(context).saccountplease);
      return;
    }
    if(_controller2.text.isEmpty && paymethod == 0) {
      EasyLoading.showToast(I18n.of(context).pleasesbank);
      return;
    }
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.addUserPay, params: {
      	"openBank": _controller2.text,
        "openBranchBank": _controller3.text,
        "payName": _controller.text,
        "payNo": _controller1.text,
        "payWay": paymethod
    }, success: (data) {
      EasyLoading.dismiss();
      Navigator.pop(context, {"success":true});
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
      body: GestureDetector(
        onTap: () {
          _clear();
        },
        behavior: HitTestBehavior.translucent,
        child: CommbackView(
          titles: I18n.of(context).spaysetting,
          onPop: () => Navigator.pop(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ChooseCoinView(
                      iscoupon: true,
                      onSelected: (selectindex, sender) {
                        setState(() {
                          paymethod = payways[selectindex];
                        });
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
                                child: Text(listtitle[paymethod], style: AppFont.textStyle(12, color: Colors.black), textAlign: TextAlign.center,)
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
                      titles: payways.map((e) => listtitle[e]).toList(),
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
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
                    children: [
                      Text(I18n.of(context).susername, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      SizedBox(height: 10,),
                      NormalTextfield(
                        hintText: I18n.of(context).susernameplease,
                        controller: _controller,
                        focusNode: _focusNode,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20.0),
                        child: Text(I18n.of(context).snameeg, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      ),
                      Text(paymethod == 3 ? I18n.of(context).saccountaddress : I18n.of(context).saccount, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      SizedBox(height: 10,),
                      Stack(
                        children: [
                          NormalTextfield(
                            hintText: paymethod == 3 ? I18n.of(context).pleaseinputorcopy : I18n.of(context).saccountplease,
                            controller: _controller1,
                            focusNode: _focusNode1,
                          ),
                          Positioned(
                            right: 0,
                            child: Visibility(
                              visible: paymethod == 3,
                              child: IconButton(
                                icon: Image.asset("assets/scan_icon.png"),
                                onPressed: () {
                                  _clear();
                                  Future.delayed(const Duration(milliseconds: 100)).then((value) => _scanAction());
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(I18n.of(context).saccounteg, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      ),
                      Visibility(
                        visible: paymethod == 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(I18n.of(context).bankename, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                            ),
                            SizedBox(height: 10,),
                            NormalTextfield(
                              hintText: I18n.of(context).pleasebankname,
                              controller: _controller2,
                              focusNode: _focusNode2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 20.0),
                              child: Text(I18n.of(context).bandeg, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                            ),
                            Text(I18n.of(context).sbank, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                            SizedBox(height: 10,),
                            NormalTextfield(
                              hintText: I18n.of(context).pleasesbank,
                              controller: _controller3,
                              focusNode: _focusNode3,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(I18n.of(context).paynotice, style: AppFont.textStyle(12, color: AppColor.red),),
                      ),
                      BtnImageBottomView(
                        title: I18n.of(context).sure,
                        onTap: () {
                          _submit();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}