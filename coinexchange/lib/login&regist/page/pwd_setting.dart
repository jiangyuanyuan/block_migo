import 'package:coinexchange/common/commview/bottom_buttom.dart';
import 'package:coinexchange/common/const/cosnt.dart';
import 'package:coinexchange/common/network/network.dart';
import 'package:coinexchange/common/textstyle/textstyle.dart';
import 'package:coinexchange/common/util/tool.dart';
import 'package:coinexchange/login&regist/view/normal_textfield.dart';
import 'package:coinexchange/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class PwdSettingPage extends StatefulWidget {

  final Map params;

  const PwdSettingPage({Key key, this.params}) : super(key: key);
  @override
  _PwdSettingPageState createState() => _PwdSettingPageState();
}

class _PwdSettingPageState extends State<PwdSettingPage> {

  final _pwdController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  final _pwdFocus = FocusNode();
  final _inviteCodeFocus = FocusNode();

  @override
  void dispose() {
    _pwdController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  void _jumpToRoot(){
    SharedPreferences.getInstance().then((value) => value.setBool(AppConst.APP_IS_LOGIN, true));
    Navigator.of(context).pushNamedAndRemoveUntil('/root',(Route<dynamic> route) => false);
  }

  void _unfocus() {
    _pwdFocus.unfocus();
    _inviteCodeFocus.unfocus();
  }

  void _login() {
    if(!Tool.isLoginPassword(_pwdController.text)) {
      EasyLoading.showError("请输入8-20个字符，不可以是纯数字");
      return;
    }
    EasyLoading.show(status: "Loading...");
    // 注册或者登录
    String pwd = Tool.generateMd5(_pwdController.text);
    Networktool.request(
      API.register, 
      params: {
        "phone": widget.params["phone"], 
        "inviteCode": _inviteCodeController.text, 
        "phoneCode": widget.params["code"],
        "password": pwd,
        "confirmPassword": pwd,
      }, success: (data){
        EasyLoading.dismiss();
      if(data["data"] != null) {
        final temp = data["data"];
        UserInfoModel model = UserInfoModel.fromJson(temp["user"]);
        // 保存token
        SharedPreferences.getInstance().then((value) => value.setString(AppConst.KEY_user_token, temp["token"]));
        // 更新用户信息
        Provider.of<UserModel>(context, listen: false).setModel(model);
        _jumpToRoot();
      }
    }, fail: (msg) => EasyLoading.showError(msg));
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final marginH = size.height * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _unfocus,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Image.asset("assets/icon_zuo.png"),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: marginH,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("请设置密码", style: AppFont.textStyle(25, color: AppColor.font333, fontWeight: FontWeight.bold),),
                    SizedBox(height: 8),
                    Text("8-20个字符，不可以是纯数字", style: AppFont.textStyle(13, color: Colors.grey),),
                    SizedBox(height: marginH,),
                    NormalTextfield(
                      hintText: "请输入密码",
                      obscureText: true,
                      controller: _pwdController,
                      focusNode: _pwdFocus,
                      maxLength: 20,
                    ),
                    SizedBox(height: 15,),
                    NormalTextfield(
                      hintText: "请输入邀请码（选填)",
                      controller: _inviteCodeController,
                      focusNode: _inviteCodeFocus,
                    ),

                    InkWell(
                      onTap: _login,
                      child: BottomButton(
                        margin: const EdgeInsets.only(top: 35),
                        title: "完成",
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