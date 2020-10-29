import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/login&regist/model/user_model.dart';
import 'package:migo/login&regist/view/sms_counter.dart';
import 'package:migo/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/sms_input.dart';

class SmsCodePage extends StatelessWidget {
  final Map params;

  const SmsCodePage({Key key, this.params}) : super(key: key);

  String _phone() {
    final phone = params["phone"].toString();
    
    return phone.substring(0, 3) + " " + phone.substring(3, 7) + " " + phone.substring(7, phone.length);
  }

  void _jumpSettingpwd(BuildContext context, String code) {
    if(code.length == 6) {
      params["code"] = code;
      _userisRegist(context);
    }
  }

  void _jumpToRoot(BuildContext context){
    SharedPreferences.getInstance().then((value) => value.setBool(AppConst.APP_IS_LOGIN, true));
    Navigator.of(context).pushNamedAndRemoveUntil('/root',(Route<dynamic> route) => false);
  }

  void _userisRegist(BuildContext context) {
    EasyLoading.show(status: "Loading...");
    // 注册或者登录
    Networktool.request(API.isregister, params: {"phoneNumber": params["phone"]}, jsonbody: false, success: (data){
      final res = data["data"];
      EasyLoading.dismiss();
      if(res != null) {
        if(res["code"] == 0) {
          _regist(context);
        } else {
          // 未注册
          Navigator.pushNamed(context, "/pwdsetting", arguments: params);
        }
      }
    }, fail: (msg) => EasyLoading.showError(msg));
  }

  void _regist(BuildContext context) {
    EasyLoading.show(status: "Loading...");
    // 注册或者登录
    Networktool.request(API.loginsms, params: {"phone": params["phone"], "phoneCode": params["code"]}, success: (data){
      if(data["data"] != null) {
        EasyLoading.dismiss();
        final temp = data["data"];
        UserInfoModel model = UserInfoModel.fromJson(temp["user"]);
        // 保存token
        SharedPreferences.getInstance().then((value) => value.setString(AppConst.KEY_user_token, temp["token"]));
        // 更新用户信息
        Provider.of<UserModel>(context, listen: false).setModel(model);
        if(params['forget'] == true) {
          // 老用户忘记密码了. 
          Navigator.pushNamed(context, "/resetpwd");
        } else {
          _jumpToRoot(context);
        }
      }
    }, fail: (msg) => EasyLoading.showError(msg));
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final marginH = size.height * 0.06;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Image.asset("assets/icon_zuo.png"),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(height: marginH),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("请输入验证码", style: AppFont.textStyle(26, color: Colors.black, fontWeight: FontWeight.bold),),
                  SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '验证码已发送至',
                          style: AppFont.textStyle(13, color: AppColor.fontgrey)
                        ),
                        TextSpan(
                          text: ' ' + _phone(),
                          style: AppFont.textStyle(13, color: AppColor.font333)
                        )
                      ]
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: marginH, bottom: 10),
                    child: SmsInputView(onChanged: (val){
                      _jumpSettingpwd(context, val);
                    },)
                  ),
                  SmsCounterView(phone: params["phone"],)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

