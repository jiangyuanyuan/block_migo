import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:migo/common/authbyimage/auth_manager.dart';
import 'package:migo/common/authbyimage/wangyi_verfied.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/model/login_status_model.dart';
import 'package:migo/login&regist/model/user_model.dart';
import 'package:migo/login&regist/view/login_email.dart';
import 'package:migo/login&regist/view/login_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final Map param;

  const LoginPage({Key key, this.param}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  int tabIndex = 0;
  PageController _pageController = PageController();
  // 1: 修改密码 2: 修改交易密码 3 忘记密码
  int modtype = 0;
  bool showerror = false;
  bool isopenemail = false;
  List<LoginStatusModel> listStatus = [];
  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if(widget.param != null) {
      modtype = widget.param["modtype"];
    }
    Future.delayed(const Duration(milliseconds: 100)).then((value) => _requestStatus());
  }

  void _requestStatus() {
    EasyLoading.showToast("Loading...");
    Networktool.request(API.checkStatus, method: HTTPMETHOD.GET, success: (data) {
      final temp = LoginStatusResponse.fromJson(data).data;
      EasyLoading.dismiss();
      if(temp != null) {
        listStatus = temp;
      }
      isopenemail = listStatus.last.configValue == "1";
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  void _jumpSmsCode() {
    if(_controller.text.isEmpty) return;
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.sms + _controller.text, method: HTTPMETHOD.GET, success: (data){
      Navigator.pushNamed(context, "/smscode", arguments: {"phone":_controller.text, "code": data["data"]});
    },finaly: () => EasyLoading.dismiss());
  }

  void _login(String account, String pwd, String code, bool isemail) async {
    if(account.isEmpty) {
      EasyLoading.showToast(isemail ? I18n.of(context).pleaseinputemail : I18n.of(context).pleaseinputphone);
      return;
    }
    if(modtype == 3 || modtype == 1) { // 忘记密码
      if(code.isEmpty) {
        EasyLoading.showToast(I18n.of(context).verificationcode);
        return;
      }
      Navigator.pushNamed(context, "/loginsetpwd",arguments: {
        "account": account, 
        "isemail":isemail, 
        "code": code,
        "istxpwd":false
      });
      return;
    } else if(modtype == 2) {
      if(code.isEmpty) {
        EasyLoading.showToast(I18n.of(context).verificationcode);
        return;
      }
      Navigator.pushNamed(context, "/loginsetpwd", arguments: {
        "account": account, 
        "isemail":isemail, 
        "code": code, 
        "istxpwd":true
      });
      return;
    }
    if(pwd.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputpwd);
      return;
    }
    print(Tool.generateMd5(pwd));

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = "";
    
    if(Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      deviceId = info.identifierForVendor;
    }

    WangyVerfied.showCaptcha((issuccess) {
      if(issuccess) {
        EasyLoading.showToast("Loading...");
        // 登录类型 1手机号 2邮箱
        Networktool.request(API.login, params: {
            "loginType": isemail ? 2 : 1,
            "passWord": Tool.generateMd5(pwd),
            "userNumber": account,
            "deviceNo":deviceId
        }, success: (data) {
          EasyLoading.dismiss();
          final temp = data["data"];
          UserInfoModel model = UserInfoModel.fromJson(temp["user"]);
          // 保存token
          SharedPreferences.getInstance().then((value) => value.setString(AppConst.KEY_user_token, temp["token"]));
          // 更新用户信息
          Provider.of<UserModel>(context, listen: false).setModel(model);
          Navigator.of(context).pushNamedAndRemoveUntil('/root', (route) => false);
        },fail: (e) {
          setState(() {
            showerror = true;
          });
          EasyLoading.showError(e);
        });
      }
    });
  }

  String _getTitle(BuildContext context) {
    switch (modtype) {
      case 0:
        return I18n.of(context).login;
        break;
      case 1:
        return I18n.of(context).setting + " " + I18n.of(context).loginpwd;
        break;
      case 3: 
        return I18n.of(context).forgetpwd;
        break;
      default:
        return I18n.of(context).setting + " " + I18n.of(context).txpassword;
    }
  } 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColor.back998,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _focusNode.unfocus(),
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
                title: Text(_getTitle(context), style: AppFont.textStyle(14, color: Colors.white, fontWeight: FontWeight.bold),),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        tabIndex = 0;
                      });
                      _pageController.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.bounceInOut);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/${tabIndex == 0 ? "phone_left":"phone_in_left"}.png"),
                        Text(I18n.of(context).phone, textAlign: TextAlign.center, style: AppFont.textStyle(14, color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  SizedBox(width: 1,),
                  InkWell(
                    onTap: () {
                      EasyLoading.showToast(I18n.of(context).notopen);
                      return;
                      Alert.showConfirmDialog(context, title: I18n.of(context).cannoteamil,);
                      setState(() {
                        tabIndex = 1;
                      });
                      _pageController.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.bounceInOut);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/${tabIndex != 1 ? "email_right" : "email_in_right"}.png"),
                        Text(I18n.of(context).email, textAlign: TextAlign.center, style: AppFont.textStyle(14, color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    LoginPhoneView(modetype: modtype, showerror: showerror, onLogin: (sender, pwd, code) => _login(sender, pwd, code, false),),
                    LoginEmailView(modtype: modtype, onLogin: (sender, pwd, code) => _login(sender, pwd, code, true))
                  ],
                  onPageChanged: (value) {
                    setState(() {
                      tabIndex = value;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}