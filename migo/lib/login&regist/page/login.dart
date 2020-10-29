import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/login&regist/view/phone_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../view/rich_protocol.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _jumpSmsCode() {
    if(_controller.text.isEmpty) return;
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.sms + _controller.text, method: HTTPMETHOD.GET, success: (data){
      Navigator.pushNamed(context, "/smscode", arguments: {"phone":_controller.text, "code": data["data"]});
    },finaly: () => EasyLoading.dismiss());
  }

  void _jumpPwdlogin() {
    Navigator.pushNamed(context, "/pwdlogin", arguments: {"phone": _controller.text});
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _focusNode.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.05,),
                Text("你好，\n欢迎来到币小贝！", 
                  style: AppFont.textStyle(25, color: AppColor.font333, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.1),
                PhoneTextFieldView(
                  hintText: "请输入手机号码",
                  focusNode: _focusNode,
                  controller: _controller,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Text("未注册的手机号验证后自动创建账户", style: AppFont.textStyle(12, color: AppColor.fontgrey),),
                ),
                InkWell(
                  onTap: _jumpSmsCode,
                  child: BottomButton(
                    margin: const EdgeInsets.only(top: 75, left: 0, right: 0),
                    title: "获取短信验证码",
                  ),
                ),
                InkWell(
                  onTap: _jumpPwdlogin,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text("密码登录", style: AppFont.textStyle(14, color: AppColor.blue),),
                    ),
                  ),
                ),
                Spacer(),
                Center(child: RichProtocolView())
              ],
            ),
          ),
        ),
      ),
    );
  }
}