import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/contract/view/choose_coin_view.dart';

class PaySettingPage extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final listtitle = [I18n.of(context).paybank, I18n.of(context).paywx, I18n.of(context).payalipay];
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
          _focusNode1.unfocus();
          _focusNode2.unfocus();
          _focusNode3.unfocus();
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
                          paymethod = selectindex;
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
                      titles: listtitle,
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
                        textStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
                        controller: _controller,
                        focusNode: _focusNode,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20.0),
                        child: Text(I18n.of(context).snameeg, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      ),
                      Text(I18n.of(context).saccount, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      SizedBox(height: 10,),
                      NormalTextfield(
                        hintText: I18n.of(context).saccountplease,
                        textStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
                        controller: _controller1,
                        focusNode: _focusNode1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(I18n.of(context).saccounteg, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                      ),
                      Visibility(
                        visible: paymethod == 0,
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
                              textStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
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
                              textStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
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