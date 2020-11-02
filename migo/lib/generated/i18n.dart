import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "你好 ${name}"
  String greetTo(String name) => "你好 ${name}";
  /// "登入"
  String get login => "登入";
  /// "登出"
  String get loginout => "登出";
  /// "中文"
  String get language => "中文";
  /// "切换语言"
  String get lang => "切换语言";
  /// "首页"
  String get home => "首页";
  /// "兑换"
  String get exchange => "兑换";
  /// "市场"
  String get market => "市场";
  /// "我的"
  String get mine => "我的";
  /// "我的背包"
  String get mypackage => "我的背包";
  /// "充值"
  String get recharge => "充值";
  /// "提现"
  String get withdraw => "提现";
  /// "邀请好友"
  String get invite => "邀请好友";
  /// "密码"
  String get password => "密码";
  /// "手机"
  String get phone => "手机";
  /// "邮箱"
  String get email => "邮箱";
  /// "请输入手机号码"
  String get pleaseinputphone => "请输入手机号码";
  /// "请输入邮箱"
  String get pleaseinputemail => "请输入邮箱";
  /// "请输入密码"
  String get pleaseinputpwd => "请输入密码";
  /// "请输入验证码"
  String get verificationcode => "请输入验证码";
  /// "请输入新密码"
  String get pleaseinputnewpwd => "请输入新密码";
  /// "请确认新密码"
  String get confirminputnewpwd => "请确认新密码";
  /// "确认并前往登入"
  String get confirmlogin => "确认并前往登入";
  /// "获取验证码"
  String get getcoude => "获取验证码";
  /// "重新获取"
  String get reacquire => "重新获取";
  /// "设置"
  String get setting => "设置";
  /// "安全中心"
  String get safecenter => "安全中心";
  /// "帮助反馈"
  String get feedback => "帮助反馈";
  /// "关于"
  String get about => "关于";
  /// "实名认证"
  String get verified => "实名认证";
  /// "目前绑定"
  String get currentbinding => "目前绑定";
  /// "登入密码"
  String get loginpwd => "登入密码";
  /// "交易密码"
  String get txpassword => "交易密码";
  /// "保存"
  String get save => "保存";
  /// "新手"
  String get newer => "新手";
  /// "用户名或密码错误"
  String get erroraccount => "用户名或密码错误";
  /// "忘记密码?"
  String get forgetpwd => "忘记密码?";
  /// "注册新账号"
  String get register => "注册新账号";
  /// "下一步"
  String get next => "下一步";
  /// "确认"
  String get sure => "确认";
  /// "取消"
  String get cancel => "取消";
  /// "请问确定要登出吗？"
  String get canyouexit => "请问确定要登出吗？";
  /// "设置新密码"
  String get resetpwd => "设置新密码";
}

class _I18n_zh_CN extends I18n {
  const _I18n_zh_CN();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  /// "Hello ${name}"
  @override
  String greetTo(String name) => "Hello ${name}";
  /// "Sign in"
  @override
  String get login => "Sign in";
  /// "Sign out"
  @override
  String get loginout => "Sign out";
  /// "English"
  @override
  String get language => "English";
  /// "Language"
  @override
  String get lang => "Language";
  /// "Home"
  @override
  String get home => "Home";
  /// "Exchange"
  @override
  String get exchange => "Exchange";
  /// "Market"
  @override
  String get market => "Market";
  /// "Mine"
  @override
  String get mine => "Mine";
  /// "My backpackage"
  @override
  String get mypackage => "My backpackage";
  /// "Recharge"
  @override
  String get recharge => "Recharge";
  /// "Withdraw"
  @override
  String get withdraw => "Withdraw";
  /// "Invite friends"
  @override
  String get invite => "Invite friends";
  /// "Password"
  @override
  String get password => "Password";
  /// "Mobile"
  @override
  String get phone => "Mobile";
  /// "Email"
  @override
  String get email => "Email";
  /// "Phone number"
  @override
  String get pleaseinputphone => "Phone number";
  /// "Email"
  @override
  String get pleaseinputemail => "Email";
  /// "Password"
  @override
  String get pleaseinputpwd => "Password";
  /// "Verification code"
  @override
  String get verificationcode => "Verification code";
  /// "New password"
  @override
  String get pleaseinputnewpwd => "New password";
  /// "Confirm password"
  @override
  String get confirminputnewpwd => "Confirm password";
  /// "Confirm and Sign in"
  @override
  String get confirmlogin => "Confirm and Sign in";
  /// "Verification code"
  @override
  String get getcoude => "Verification code";
  /// "Reacquire"
  @override
  String get reacquire => "Reacquire";
  /// "Setting"
  @override
  String get setting => "Setting";
  /// "Security center"
  @override
  String get safecenter => "Security center";
  /// "Feedback"
  @override
  String get feedback => "Feedback";
  /// "About"
  @override
  String get about => "About";
  /// "Verified"
  @override
  String get verified => "Verified";
  /// "Current binding"
  @override
  String get currentbinding => "Current binding";
  /// "Login password"
  @override
  String get loginpwd => "Login password";
  /// "Transaction password"
  @override
  String get txpassword => "Transaction password";
  /// "Save"
  @override
  String get save => "Save";
  /// "Novice"
  @override
  String get newer => "Novice";
  /// "Error account or password"
  @override
  String get erroraccount => "Error account or password";
  /// "Forget password?"
  @override
  String get forgetpwd => "Forget password?";
  /// "Sign up"
  @override
  String get register => "Sign up";
  /// "Next"
  @override
  String get next => "Next";
  /// "Confirm"
  @override
  String get sure => "Confirm";
  /// "Cancel"
  @override
  String get cancel => "Cancel";
  /// "Are you sure you want to log out?"
  @override
  String get canyouexit => "Are you sure you want to log out?";
  /// "Reset password"
  @override
  String get resetpwd => "Reset password";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("zh", "CN"),
      Locale("en", "US")
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale.languageCode : "";
    if ("zh_CN" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    }
    else if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("zh" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_zh_CN());
    }
    else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}