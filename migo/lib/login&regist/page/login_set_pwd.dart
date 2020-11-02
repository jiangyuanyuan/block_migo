import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
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

  void _submit() {
    Navigator.of(context).pushNamedAndRemoveUntil('/root', (route) => false);
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
                title: Text(I18n.of(context).resetpwd, style: AppFont.textStyle(14, color: Colors.white, fontWeight: FontWeight.bold),),
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
                    ),
                    SizedBox(height: 10,),
                    NormalTextfield(
                      focusNode: _pwd1Node,
                      controller: _pwd1Controller,
                      hintText: I18n.of(context).confirminputnewpwd,
                      obscureText: true,
                    ),
                    SizedBox(height: 22,),
                    BtnAction(
                      title: I18n.of(context).confirmlogin,
                      onTap: _submit,
                    )
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