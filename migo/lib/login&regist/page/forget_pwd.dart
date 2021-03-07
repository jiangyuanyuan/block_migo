import 'package:migo/common/authbyimage/geetest_verfied.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/login&regist/view/phone_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgetPwdPage extends StatefulWidget {
  @override
  _ForgetPwdPageState createState() => _ForgetPwdPageState();
}

class _ForgetPwdPageState extends State<ForgetPwdPage> {

  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _jumpSmsCode() {
    if(_controller.text.length != 11) {
      EasyLoading.showInfo("请输入11位手机号码");
      return;
    }
    GeetestVerfied.show((geetestResult) {
      EasyLoading.show(status: "Loading...");
      Networktool.requestGeetest(API.sms + _controller.text, method: HTTPMETHOD.GET, success: (data){
        Navigator.pushNamed(context, "/smscode", arguments: {"phone":_controller.text, "forget": true, "code": data["data"]});
      },finaly: () => EasyLoading.dismiss(),geetestParams :geetestResult);
    });
  }

  void _userisRegist() {
    EasyLoading.show(status: "Loading...");
    // 注册或者登录
    Networktool.request(API.isregister, params: {"phoneNumber": _controller.text}, jsonbody: false, success: (data){
      final res = data["data"];
      if(res != null) {
        if(res["code"] == 0) {
          _jumpSmsCode();
        } else {
          EasyLoading.showError("该用户尚未注册,请注册");
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final marginH = size.height * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _focusNode.unfocus(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Image.asset("assets/icon_zuo.png"),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: marginH),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("找回密码", style: AppFont.textStyle(25, color: AppColor.font333, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text("为了保证您的账户安全，1天只能操作1次，否则账户将会被锁定无法登录",style: AppFont.textStyle(13, color: AppColor.fontgrey),),
                    ),
                    SizedBox(height: marginH),
                    PhoneTextFieldView(
                      focusNode: _focusNode,
                      controller: _controller,
                      hintText: "请输入手机号码",
                    ),
                    SizedBox(height: marginH),
                    InkWell(
                      onTap: _userisRegist,
                      child: BottomButton(
                        margin: const EdgeInsets.only(top: 40),
                        title: "下一步",
                      ),
                    ),
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