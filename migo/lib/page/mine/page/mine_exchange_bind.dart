import 'package:flutter/services.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/login&regist/view/sms_counter.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class MineExchangeBindPage extends StatefulWidget {
  @override
  _MineExchangeBindPageState createState() => _MineExchangeBindPageState();
}

class _MineExchangeBindPageState extends State<MineExchangeBindPage> {
  TextEditingController _editingController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _codefocusNode = FocusNode();
  String phone = "";
  
  @override
  void dispose() {
    _editingController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _submit() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "更改绑定",
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 14),
                child: Text("目前绑定", style: AppFont.textStyle(16, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),),
              ),
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/input_back.png"),
                    fit: BoxFit.fill
                  )
                ),
                alignment: Alignment.centerLeft,
                child: Text("19803801948", style: AppFont.textStyle(14, color: Colors.white, showshadow: true),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 14, top: 24),
                child: Text("更改绑定", style: AppFont.textStyle(16, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),),
              ),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: "请填写证件号",
                    align: TextAlign.right,
                    controller: _editingController,
                    focusNode: _focusNode,
                  ),
                  Positioned(
                    left: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.only(left: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("证件号", style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                          SizedBox(width: 6,),
                          Image.asset("assets/sign_choos_arrow_down.png"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: I18n.of(context).verificationcode,
                    backgroundColor: Colors.white,
                    maxLength: 6,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    focusNode: _codefocusNode,
                    controller: _codeController,
                  ),
                  Positioned(
                    right: 12,
                    top: 0,
                    bottom: 0,
                    child: Center(child: SmsCounterView(phone: phone,)),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 6.0, top: 10),
                child: Row(
                  children: [
                    Image.asset("assets/sign_tip_arrow_right.png"),
                    SizedBox(width: 6,),
                    Text("绑定规则：手机号及邮箱选择一个绑定即可", style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),)
                  ],
                ),
              ),
              SizedBox(height: 46,),
              BtnImageBottomView(
                title: "确认",
                onTap: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}