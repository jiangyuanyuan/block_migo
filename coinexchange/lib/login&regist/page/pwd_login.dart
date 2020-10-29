import 'package:coinexchange/common/commview/bottom_buttom.dart';
import 'package:coinexchange/common/const/cosnt.dart';
import 'package:coinexchange/common/network/network.dart';
import 'package:coinexchange/common/textstyle/textstyle.dart';
import 'package:coinexchange/common/util/tool.dart';
import 'package:coinexchange/login&regist/view/normal_textfield.dart';
import 'package:coinexchange/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class PwdLoginPage extends StatefulWidget {
  final Map params;

  const PwdLoginPage({Key key, this.params}) : super(key: key);
  @override
  _PwdLoginPageState createState() => _PwdLoginPageState();
}

class _PwdLoginPageState extends State<PwdLoginPage> {

  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.params["phone"];
  }

  void _login(BuildContext context) {
    if(_phoneController.text.length != 11) {
      EasyLoading.showInfo("请输入11位手机号码");
      return;
    }
    EasyLoading.show(status: "Loading...");
    // 注册或者登录
    Networktool.request(API.loginpwd, params: {"phone": _phoneController.text, "password": Tool.generateMd5(_pwdController.text)}, success: (data){
      if(data["data"] != null) {
        final temp = data["data"];
        UserInfoModel model = UserInfoModel.fromJson(temp["user"]);
        // 保存token
        SharedPreferences.getInstance().then((value) => value.setString(AppConst.KEY_user_token, temp["token"]));
        // 更新用户信息
        Provider.of<UserModel>(context, listen: false).setModel(model);
        _jumpToRoot();
      }
    }, fail: (msg) => EasyLoading.showError(msg),
    finaly: () => EasyLoading.dismiss());
  }

  void _jumpToRoot(){
    Navigator.of(context).pushNamedAndRemoveUntil('/root',(Route<dynamic> route) => false);
  }

  void _unfocus() {
    _phoneFocusNode.unfocus();
    _pwdFocusNode.unfocus();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _pwdController.dispose();
    super.dispose();
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
              SizedBox(height: marginH),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("账号密码登录", style: AppFont.textStyle(25, color: AppColor.font333, fontWeight: FontWeight.bold),),
                    SizedBox(height: marginH + 22),
                    NormalTextfield(
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      hintText: "请输入手机号码",
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height: 15,),
                    NormalTextfield(
                      obscureText: true,
                      focusNode: _pwdFocusNode,
                      controller: _pwdController,
                      hintText: "请输入密码",
                    ),

                    InkWell(
                      onTap: () => _login(context),
                      child: BottomButton(
                        margin: const EdgeInsets.only(top: 36),
                        title: "登录",
                      )
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, "/forgetpwd"),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text("忘记密码?", style: AppFont.textStyle(14, color: AppColor.fontgrey),),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text('验证码登录', style: AppFont.textStyle(14, color: AppColor.blue),),
                          ),
                        ),
                      ],
                    )
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