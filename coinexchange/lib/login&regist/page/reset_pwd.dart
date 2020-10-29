import 'package:coinexchange/common/commview/alert.dart';
import 'package:coinexchange/common/commview/bottom_buttom.dart';
import 'package:coinexchange/common/const/cosnt.dart';
import 'package:coinexchange/common/network/network.dart';
import 'package:coinexchange/common/textstyle/textstyle.dart';
import 'package:coinexchange/common/util/tool.dart';
import 'package:coinexchange/login&regist/view/normal_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ResetPwdPage extends StatefulWidget {
  @override
  _ResetPwdPageState createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> {

  final _pwdController = TextEditingController();
  final _pwdFocus = FocusNode();

  @override
  void dispose() {
    _pwdController.dispose();
    super.dispose();
  }

  void _submit() {
    if(!Tool.isLoginPassword(_pwdController.text)) {
      Alert.showToast("请输入8-20个字符，不可以是纯数字");
      return;
    }
    _request();
  }

  void _request() {
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.setpwd, params: {"password":Tool.generateMd5(_pwdController.text)},success: (data){
      int count = 0;
      // 回到密码登录
      Navigator.popUntil(context, (route) {
        count += 1;
        return count > 3;
      });
    }, fail: (msg) => EasyLoading.showError(msg)
    , finaly: () => EasyLoading.dismiss());
  }


  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final marginH = size.height * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _pwdFocus.unfocus(),
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
                    Text("重新设置密码", style: AppFont.textStyle(25, color: AppColor.font333, fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    Text("8-20个字符，不可以是纯数字", style: AppFont.textStyle(13, color: AppColor.fontgrey),),
                    SizedBox(height: marginH + 10,),

                    NormalTextfield(
                      obscureText: true,
                      maxLength: 20,
                      focusNode: _pwdFocus,
                      controller: _pwdController,
                      hintText: "请输入密码",
                    ),

                    SizedBox(height: marginH),
                    InkWell(
                      onTap: _submit,
                      child: BottomButton(
                        margin: const EdgeInsets.only(top: 40),
                        title: "完成",
                      ),
                    ),
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}