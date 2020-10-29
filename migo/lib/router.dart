
import 'package:migo/login&regist/page/lanuage_page.dart';
import 'package:migo/root/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login&regist/page/forget_pwd.dart';
import 'login&regist/page/login.dart';
import 'login&regist/page/pwd_login.dart';
import 'login&regist/page/pwd_setting.dart';
import 'login&regist/page/reset_pwd.dart';
import 'login&regist/page/sms_code.dart';

final routes = {
  // tabbar
  '/root': (context) => RootPage(),
  '/login': (context) => LoginPage(),
  '/smscode': (context, {arguments}) => SmsCodePage(params: arguments,), // 验证码登录
  '/pwdlogin': (context, {arguments}) => PwdLoginPage(params: arguments,), // 密码登录
  '/pwdsetting': (context,{arguments}) => PwdSettingPage(params: arguments,),// 第一次登录密码设置
  '/forgetpwd': (context) => ForgetPwdPage(),// 忘记密码
  '/resetpwd': (context) => ResetPwdPage(),  // 重新设置密码
  '/language': (context) => LanguagePage(),  // 重新设置密码
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final CupertinoPageRoute route = CupertinoPageRoute<Map<String, dynamic>>(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final CupertinoPageRoute route =
          CupertinoPageRoute<Map<String, dynamic>>(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};