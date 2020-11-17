import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';

class LoginSetPwd extends StatefulWidget {
  final Map param;

  const LoginSetPwd({Key key, this.param}) : super(key: key);
  @override
  _LoginSetPwdState createState() => _LoginSetPwdState();
}

class _LoginSetPwdState extends State<LoginSetPwd> {
  TextEditingController _pwd1Controller = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  FocusNode _pwd1Node = FocusNode();
  FocusNode _pwdNode = FocusNode();
  bool istxpwd = false;
  int count = 0;
  String oldpwd;
  void _submit() {
    if(_pwdController.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputnewpwd);
      return;
    }
    if(_pwd1Controller.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputpwd);
      return;
    }
    if(oldpwd != null && oldpwd == _pwdController.text) {
      EasyLoading.showToast(I18n.of(context).pleasereinputnew);
      return;
    }
    if(istxpwd) {
      if(_pwd1Controller.text.length < 6) {
        EasyLoading.showToast(I18n.of(context).pleasesixpwd);
        return;
      }
    } else {
      if(!Tool.isLoginPassword(_pwd1Controller.text)) {
        EasyLoading.showToast(I18n.of(context).pleasesixto12pwd);
        return;
      }
    }
    if(_pwd1Controller.text != _pwdController.text) {
      EasyLoading.showError(I18n.of(context).notsamepwd);
      count += 1;
      if(count >= 5) {
        oldpwd = _pwdController.text;
        _pwd1Controller.clear();
        _pwdController.clear();
        count = 0;
      }
      return;
    }
    
    if(istxpwd) {
      ///设置交易密码
      EasyLoading.show(status: "Loading...");
      Networktool.request(API.changeTXPwd, params: {
        	"txPwd": Tool.generateMd5(_pwd1Controller.text),
          "userCode": widget.param["code"],
          "userNumber": widget.param["account"],
      }, success: (data) {
        EasyLoading.showToast(I18n.of(context).success);
        Navigator.pop(context);
        Navigator.pop(context);
      }, fail: (msg) => EasyLoading.showError(msg),);
    } else {
      /// 忘记密码
      EasyLoading.show(status: "Loading...");
      Networktool.request(API.updatePwd, params: {
        	"passWord": Tool.generateMd5(_pwd1Controller.text),
          "userCode": widget.param["code"],
          "userNumber":widget.param["account"]
      }, success: (data) {
        EasyLoading.showToast(I18n.of(context).success);
        Navigator.pop(context);
        Navigator.pop(context);
      }, fail: (msg) => EasyLoading.showError(msg),);
    }
  }

  @override
  void initState() {
    super.initState();
    istxpwd = widget.param["istxpwd"];
  }

  @override
  void dispose() { 
    _pwd1Controller.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColor.back998,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _pwd1Node.unfocus();
          _pwdNode.unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/背景图.png"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            children: [
              NormalAppbar.normal(
                color: Colors.transparent,
                title: Text(istxpwd ? I18n.of(context).txpassword : I18n.of(context).resetpwd, style: AppFont.textStyle(14, color: Colors.white, fontWeight: FontWeight.bold),),
                leading: IconButton(
                  icon: Image.asset("assets/icon_zuo.png", color: Colors.white,),
                  onPressed: () {
                    if(Navigator.canPop(context)) {
                       Navigator.pop(context);
                    }
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 40),
                child: Image.asset("assets/logo.png"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 26,vertical: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8, 
                      color: Colors.black.withOpacity(0.3), 
                      spreadRadius: 0,
                      offset: Offset(0, 2)
                    )
                  ]
                ),
                child: Column(
                  children: [
                    NormalTextfield(
                      focusNode: _pwdNode,
                      controller: _pwdController,
                      hintText: I18n.of(context).pleaseinputnewpwd,
                      obscureText: true,
                      maxLength: istxpwd ? 6 : null,
                      inputFormatters: istxpwd ? [WhitelistingTextInputFormatter.digitsOnly] : null,
                    ),
                    SizedBox(height: 10,),
                    NormalTextfield(
                      focusNode: _pwd1Node,
                      controller: _pwd1Controller,
                      hintText: I18n.of(context).confirminputnewpwd,
                      maxLength: istxpwd ? 6 : null,
                      inputFormatters: istxpwd ? [WhitelistingTextInputFormatter.digitsOnly] : null,
                      obscureText: true,
                    ),
                    SizedBox(height: 22,),
                    BtnAction(
                      title: istxpwd ? I18n.of(context).submit : I18n.of(context).confirmlogin,
                      onTap: _submit,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}