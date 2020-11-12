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
  /// "提现地址："
  String get withdrawaddress => "提现地址：";
  /// "提现数量："
  String get withdrawnum => "提现数量：";
  /// "提现规则："
  String get withdrawrule => "提现规则：";
  /// "提现成功"
  String get withdrawsuccess => "提现成功";
  /// "到账数量："
  String get arrivalquantity => "到账数量：";
  /// "团队"
  String get team => "团队";
  /// "日收益"
  String get dayincome => "日收益";
  /// "我的团队"
  String get myteam => "我的团队";
  /// "我的收益"
  String get myearn => "我的收益";
  /// "邀请好友"
  String get invite => "邀请好友";
  /// "密码"
  String get password => "密码";
  /// "请填写身份证上的姓名"
  String get pleaseinputname => "请填写身份证上的姓名";
  /// "请填写证件号"
  String get pleaseinputid => "请填写证件号";
  /// "姓名"
  String get name => "姓名";
  /// "证件类型"
  String get idtype => "证件类型";
  /// "证件号"
  String get idnumber => "证件号";
  /// "驾驶证"
  String get iddrive => "驾驶证";
  /// "护照"
  String get idprotect => "护照";
  /// "身份证"
  String get idcard => "身份证";
  /// "手机"
  String get phone => "手机";
  /// "邮箱"
  String get email => "邮箱";
  /// "恭喜获得"
  String get congratulations => "恭喜获得";
  /// "请输入手机号码"
  String get pleaseinputphone => "请输入手机号码";
  /// "请输入邮箱"
  String get pleaseinputemail => "请输入邮箱";
  /// "请输入密码"
  String get pleaseinputpwd => "请输入密码";
  /// "输入交易密码"
  String get pleasetxpassword => "输入交易密码";
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
  /// "兑换成功"
  String get exchagesuccess => "兑换成功";
  /// "设置"
  String get setting => "设置";
  /// "安全中心"
  String get safecenter => "安全中心";
  /// "帮助反馈"
  String get feedback => "帮助反馈";
  /// "关于"
  String get about => "关于";
  /// "数量"
  String get number => "数量";
  /// "日期"
  String get date => "日期";
  /// "时间"
  String get time => "时间";
  /// "总计"
  String get total => "总计";
  /// "完成"
  String get finish => "完成";
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
  /// "金铲子"
  String get shovel_gold => "金铲子";
  /// "银铲子"
  String get shovel_sliver => "银铲子";
  /// "铜铲子"
  String get shovel_iron => "铜铲子";
  /// "新手"
  String get newer => "新手";
  /// "前往背包查看"
  String get gotopackage => "前往背包查看";
  /// "邀请记录"
  String get inviterecord => "邀请记录";
  /// "可用资产"
  String get availablebalance => "可用资产";
  /// "可用资产"
  String get assetaccount => "可用资产";
  /// "分享奖励"
  String get teamgroupshare => "分享奖励";
  /// "领导奖金"
  String get teamgroupleader => "领导奖金";
  /// "直推奖"
  String get teamgrouppush => "直推奖";
  /// "输出"
  String get output => "输出";
  /// "预估"
  String get estimate => "预估";
  /// "昨日团队收益价值"
  String get lasetteamvalue => "昨日团队收益价值";
  /// "总价值收益"
  String get totalteamvalue => "总价值收益";
  /// "建立自己团队的矿场\n参与MIGO矿池分红"
  String get totalnotice => "建立自己团队的矿场\n参与MIGO矿池分红";
  /// "立即参与"
  String get teamjoin => "立即参与";
  /// "小区静态产出"
  String get teamstaticvalue => "小区静态产出";
  /// "余额"
  String get balance => "余额";
  /// "选择币种"
  String get choosecoin => "选择币种";
  /// "价格"
  String get price => "价格";
  /// "手续费减免"
  String get feereduction => "手续费减免";
  /// "手续费"
  String get feereduction2 => "手续费";
  /// "当前${level}级别"
  String currlevel(String level) => "当前${level}级别";
  /// "下一级${level}级别"
  String nextlevel(String level) => "下一级${level}级别";
  /// "立即兑换"
  String get redeemnow => "立即兑换";
  /// "确认兑换"
  String get confirmexchange => "确认兑换";
  /// "供应量"
  String get supply => "供应量";
  /// "最少获得"
  String get leastget => "最少获得";
  /// "价格滑点"
  String get priceslippage => "价格滑点";
  /// "手续费"
  String get handlingfee => "手续费";
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
  /// "扫描二维码进行充值"
  String get scanqrtorecharge => "扫描二维码进行充值";
  /// "充值地址（复制地址如下)"
  String get copyaddress => "充值地址（复制地址如下)";
  /// "1. 该币种合约地址为migo.token"
  String get notice1 => "1. 该币种合约地址为migo.token";
  /// "2. 此地址只接受EOS，发送其他币种到此地址将不可找回。"
  String get notice2 => "2. 此地址只接受EOS，发送其他币种到此地址将不可找回。";
  /// "3. 默认充值至钱包余额。"
  String get notice3 => "3. 默认充值至钱包余额。";
  /// "4. 您的充值地址不会经常改变，可以重复充值；如有更改，我们会尽量通过网站公告或邮件通知您。"
  String get notice4 => "4. 您的充值地址不会经常改变，可以重复充值；如有更改，我们会尽量通过网站公告或邮件通知您。";
  /// "请输入或长按粘贴"
  String get pleaseinputorcopy => "请输入或长按粘贴";
  /// "请输入数量"
  String get pleaseinputonumber => "请输入数量";
  /// "可提数量："
  String get availableamount => "可提数量：";
  /// "实际到账："
  String get actualarrival => "实际到账：";
  /// "赚取"
  String get homeearn => "赚取";
  /// "抵押"
  String get mortgage => "抵押";
  /// "日产量"
  String get dailyoutput => "日产量";
  /// "挖矿周期"
  String get miningcycle => "挖矿周期";
  /// "挖矿量"
  String get miningamount => "挖矿量";
  /// "矿池日产量"
  String get miningoutput => "矿池日产量";
  /// "矿池总产量"
  String get miningtotaloutput => "矿池总产量";
  /// "获得"
  String get obtain => "获得";
  /// "立即挖矿"
  String get minenow => "立即挖矿";
  /// "已使用"
  String get homeused => "已使用";
  /// "挖矿支付记录"
  String get miningpaymentrecord => "挖矿支付记录";
  /// "挖矿收益记录"
  String get miningrevenuerecord => "挖矿收益记录";
  /// "团队收益记录"
  String get teamearnrecord => "团队收益记录";
  /// "支付"
  String get pay => "支付";
  /// "分享奖励"
  String get sharerewards => "分享奖励";
  /// "目前称号"
  String get currtitle => "目前称号";
  /// "小区累计质押挖矿"
  String get cumulativepledgedmining => "小区累计质押挖矿";
  /// "达标等级"
  String get compliancelevel => "达标等级";
  /// "见点奖励"
  String get seePoint => "见点奖励";
  /// "使用中铲子"
  String get shovelinuse => "使用中铲子";
  /// "天"
  String get day => "天";
  /// "已认证"
  String get inviteverified => "已认证";
  /// "未认证"
  String get notinviteverified => "未认证";
  /// "全部"
  String get all => "全部";
  /// "代"
  String get generation => "代";
  /// "每个有效用户"
  String get everyactiveuser => "每个有效用户";
  /// "奖励"
  String get reward => "奖励";
  /// "享受"
  String get enjoy => "享受";
  /// "当前等级"
  String get currentlevel => "当前等级";
  /// "矿池分红"
  String get minedividends => "矿池分红";
  /// "我的小区"
  String get mycommunity => "我的小区";
  /// "今日完成认证人数"
  String get numberpeople => "今日完成认证人数";
  /// "累计完成认证人数"
  String get totalnumberpeople => "累计完成认证人数";
  /// "设置新密码"
  String get resetpwd => "设置新密码";
  /// "${sender}"
  String space(String sender) => "${sender}";
  /// "共"
  String get teamleadertotal => "共";
  /// "团队人数"
  String get teamnumber => "团队人数";
  /// "团队总业绩"
  String get teamperformance => "团队总业绩";
  /// "大区挖矿金额"
  String get dynamicincome => "大区挖矿金额";
  /// "直推奖"
  String get directPushAward => "直推奖";
  /// "达标领导奖励"
  String get aimreward => "达标领导奖励";
  /// "我的面值"
  String get denomination => "我的面值";
  /// "更新资产"
  String get coinupdate => "更新资产";
  /// "历史记录"
  String get history => "历史记录";
  /// "提示"
  String get notice => "提示";
  /// "上传证件照"
  String get uploadid => "上传证件照";
  /// "证件照正面"
  String get idfront => "证件照正面";
  /// "证件照反面"
  String get idback => "证件照反面";
  /// "拍摄"
  String get takephoto => "拍摄";
  /// "从相册选择"
  String get album => "从相册选择";
  /// "提交"
  String get submit => "提交";
  /// "更改绑定"
  String get changebind => "更改绑定";
  /// "当前绑定"
  String get currbind => "当前绑定";
  /// "绑定规则：手机号及邮箱选择一个绑定即可"
  String get bindrule => "绑定规则：手机号及邮箱选择一个绑定即可";
  /// "当前总生产率"
  String get currtotalproduce => "当前总生产率";
  /// "背包容量"
  String get packagesize => "背包容量";
  /// "今日预估获得"
  String get todaypreget => "今日预估获得";
  /// "累计产出"
  String get totalgetmigos => "累计产出";
  /// "规格"
  String get specification => "规格";
  /// "耐久度"
  String get durability => "耐久度";
  /// "生产量"
  String get production => "生产量";
  /// "体积"
  String get volume => "体积";
  /// "使用"
  String get use => "使用";
  /// "请问确定要使用此道具吗?"
  String get usernotice => "请问确定要使用此道具吗?";
  /// "1. 证件类型:身份证、护照或驾照。\n2. 必须看清证件信息和脸，需要手持证件拍摄。\n3. 证件文档不可超过500kb。\n4. 照片内容真实有效，不得做任何修改。\n5. 上传文档格式为pdf、jpg、 jpeg和png。"
  String get uploadnotice => "1. 证件类型:身份证、护照或驾照。\n2. 必须看清证件信息和脸，需要手持证件拍摄。\n3. 证件文档不可超过500kb。\n4. 照片内容真实有效，不得做任何修改。\n5. 上传文档格式为pdf、jpg、 jpeg和png。";
  /// "姓名、证件号首次提交后无法更改，为避免填写虚假信息导致充值、提现无法审核通过，请您慎重填写真实信息。"
  String get authnotice => "姓名、证件号首次提交后无法更改，为避免填写虚假信息导致充值、提现无法审核通过，请您慎重填写真实信息。";
  /// "我的邀请码: "
  String get myinvitecode => "我的邀请码: ";
  /// "邀请5个好友并完成实名认证 \n 即可获得一个盲盒"
  String get myinvitecodenotice => "邀请5个好友并完成实名认证 \n 即可获得一个盲盒";
  /// "邀请链接"
  String get invitelink => "邀请链接";
  /// "保存海报"
  String get saveimage => "保存海报";
  /// "人"
  String get peopleintotal => "人";
  /// "操作成功"
  String get success => "操作成功";
  /// "收益记录"
  String get earnrecord => "收益记录";
  /// "1. 提现会扣取部分手续费，以实际到账为主。"
  String get withDrawNotice => "1. 提现会扣取部分手续费，以实际到账为主。";
  /// "用户协议"
  String get settinguserprotocol => "用户协议";
  /// "隐私协议"
  String get settingprotocol => "隐私协议";
  /// "APP版本更新内容"
  String get settingupdate => "APP版本更新内容";
  /// "APP当前版本"
  String get appcurrversion => "APP当前版本";
  /// "好友邀请流程"
  String get feedinvite => "好友邀请流程";
  /// "账号管理事宜"
  String get feedaccount => "账号管理事宜";
  /// "矿场收益解释"
  String get feedmines => "矿场收益解释";
  /// "其他功能使用"
  String get feeduse => "其他功能使用";
  /// "我要发送反馈"
  String get feed => "我要发送反馈";
  /// "撤资删号流程"
  String get feeddel => "撤资删号流程";
  /// "请简要描述您的问题或者意见，以便我们为您提供更好的帮助。"
  String get feennotice => "请简要描述您的问题或者意见，以便我们为您提供更好的帮助。";
  /// "选择文件"
  String get feedchoose => "选择文件";
  /// "请输入内容"
  String get pleaseinput => "请输入内容";
  /// "使用中"
  String get using => "使用中";
  /// "铲子"
  String get shovel => "铲子";
  /// "已支付"
  String get paid => "已支付";
  /// "密码不一致"
  String get notsamepwd => "密码不一致";
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
  /// "Withdrawal address:"
  @override
  String get withdrawaddress => "Withdrawal address:";
  /// "Withdraw quantity:"
  @override
  String get withdrawnum => "Withdraw quantity:";
  /// "Withdrawal rules:"
  @override
  String get withdrawrule => "Withdrawal rules:";
  /// "Withdraw success"
  @override
  String get withdrawsuccess => "Withdraw success";
  /// "Arrival quantity:"
  @override
  String get arrivalquantity => "Arrival quantity:";
  /// "Team"
  @override
  String get team => "Team";
  /// "Daily income"
  @override
  String get dayincome => "Daily income";
  /// "My Team"
  @override
  String get myteam => "My Team";
  /// "My earnings"
  @override
  String get myearn => "My earnings";
  /// "Invite friends"
  @override
  String get invite => "Invite friends";
  /// "Password"
  @override
  String get password => "Password";
  /// "Please fill in the name on the ID"
  @override
  String get pleaseinputname => "Please fill in the name on the ID";
  /// "Please fill in the ID number"
  @override
  String get pleaseinputid => "Please fill in the ID number";
  /// "Name"
  @override
  String get name => "Name";
  /// "Type of certificate"
  @override
  String get idtype => "Type of certificate";
  /// "ID number"
  @override
  String get idnumber => "ID number";
  /// "Driver license"
  @override
  String get iddrive => "Driver license";
  /// "Passport"
  @override
  String get idprotect => "Passport";
  /// "ID card"
  @override
  String get idcard => "ID card";
  /// "Mobile"
  @override
  String get phone => "Mobile";
  /// "Email"
  @override
  String get email => "Email";
  /// "Congratulations"
  @override
  String get congratulations => "Congratulations";
  /// "Phone number"
  @override
  String get pleaseinputphone => "Phone number";
  /// "Email"
  @override
  String get pleaseinputemail => "Email";
  /// "Password"
  @override
  String get pleaseinputpwd => "Password";
  /// "Enter transaction password"
  @override
  String get pleasetxpassword => "Enter transaction password";
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
  /// "Successful redemption"
  @override
  String get exchagesuccess => "Successful redemption";
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
  /// "Quantity"
  @override
  String get number => "Quantity";
  /// "Date"
  @override
  String get date => "Date";
  /// "Time"
  @override
  String get time => "Time";
  /// "Total"
  @override
  String get total => "Total";
  /// "Done"
  @override
  String get finish => "Done";
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
  /// "Golden shovel"
  @override
  String get shovel_gold => "Golden shovel";
  /// "Sliver shovel"
  @override
  String get shovel_sliver => "Sliver shovel";
  /// "Copper shovel"
  @override
  String get shovel_iron => "Copper shovel";
  /// "Novice"
  @override
  String get newer => "Novice";
  /// "Go to backpack"
  @override
  String get gotopackage => "Go to backpack";
  /// "Invitation record"
  @override
  String get inviterecord => "Invitation record";
  /// "Available balance"
  @override
  String get availablebalance => "Available balance";
  /// "Asset account"
  @override
  String get assetaccount => "Asset account";
  /// "Share"
  @override
  String get teamgroupshare => "Share";
  /// "Leadership"
  @override
  String get teamgroupleader => "Leadership";
  /// "Direct push"
  @override
  String get teamgrouppush => "Direct push";
  /// "Output"
  @override
  String get output => "Output";
  /// "Estimate"
  @override
  String get estimate => "Estimate";
  /// "Yesterday's team earnings"
  @override
  String get lasetteamvalue => "Yesterday's team earnings";
  /// "Total revenue"
  @override
  String get totalteamvalue => "Total revenue";
  /// "Build team of mines\nParticipate pool dividends"
  @override
  String get totalnotice => "Build team of mines\nParticipate pool dividends";
  /// "Participate"
  @override
  String get teamjoin => "Participate";
  /// "Community static output"
  @override
  String get teamstaticvalue => "Community static output";
  /// "Balance"
  @override
  String get balance => "Balance";
  /// "Currency"
  @override
  String get choosecoin => "Currency";
  /// "Price"
  @override
  String get price => "Price";
  /// "Fee reduction"
  @override
  String get feereduction => "Fee reduction";
  /// "Fee"
  @override
  String get feereduction2 => "Fee";
  /// "Current level ${level}"
  @override
  String currlevel(String level) => "Current level ${level}";
  /// "Next level ${level}"
  @override
  String nextlevel(String level) => "Next level ${level}";
  /// "Redeem now"
  @override
  String get redeemnow => "Redeem now";
  /// "Confirm redemption"
  @override
  String get confirmexchange => "Confirm redemption";
  /// "Supply"
  @override
  String get supply => "Supply";
  /// "Least get"
  @override
  String get leastget => "Least get";
  /// "Price slippage"
  @override
  String get priceslippage => "Price slippage";
  /// "Handling fee"
  @override
  String get handlingfee => "Handling fee";
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
  /// "Scan the QR code to recharge"
  @override
  String get scanqrtorecharge => "Scan the QR code to recharge";
  /// "Recharge address (copy address)"
  @override
  String get copyaddress => "Recharge address (copy address)";
  /// "1. The contract address of this currency is migo.token"
  @override
  String get notice1 => "1. The contract address of this currency is migo.token";
  /// "2. This address only accepts EOS, sending other currencies to this address will not be able to retrieve it."
  @override
  String get notice2 => "2. This address only accepts EOS, sending other currencies to this address will not be able to retrieve it.";
  /// "3. Recharge to the wallet balance by default."
  @override
  String get notice3 => "3. Recharge to the wallet balance by default.";
  /// "4. Your recharge address will not change frequently, you can recharge; if there is any change, we will try our best to notify you via website announcement or email."
  @override
  String get notice4 => "4. Your recharge address will not change frequently, you can recharge; if there is any change, we will try our best to notify you via website announcement or email.";
  /// "Please enter or long press to paste"
  @override
  String get pleaseinputorcopy => "Please enter or long press to paste";
  /// "Please enter the quantity"
  @override
  String get pleaseinputonumber => "Please enter the quantity";
  /// "Available amount:"
  @override
  String get availableamount => "Available amount:";
  /// "Actual arrival:"
  @override
  String get actualarrival => "Actual arrival:";
  /// "Earn"
  @override
  String get homeearn => "Earn";
  /// "Mortgage"
  @override
  String get mortgage => "Mortgage";
  /// "Daily output"
  @override
  String get dailyoutput => "Daily output";
  /// "Mining cycle"
  @override
  String get miningcycle => "Mining cycle";
  /// "Mining amount"
  @override
  String get miningamount => "Mining amount";
  /// "Daily output"
  @override
  String get miningoutput => "Daily output";
  /// "Total output"
  @override
  String get miningtotaloutput => "Total output";
  /// "Obtain"
  @override
  String get obtain => "Obtain";
  /// "Mine now"
  @override
  String get minenow => "Mine now";
  /// "Used"
  @override
  String get homeused => "Used";
  /// "Mining payment record"
  @override
  String get miningpaymentrecord => "Mining payment record";
  /// "Mining revenue record"
  @override
  String get miningrevenuerecord => "Mining revenue record";
  /// "Team revenue record"
  @override
  String get teamearnrecord => "Team revenue record";
  /// "Pay"
  @override
  String get pay => "Pay";
  /// "Sharing rewards"
  @override
  String get sharerewards => "Sharing rewards";
  /// "Current title"
  @override
  String get currtitle => "Current title";
  /// "Cumulative pledged mining"
  @override
  String get cumulativepledgedmining => "Cumulative pledged mining";
  /// "Compliance level"
  @override
  String get compliancelevel => "Compliance level";
  /// "See Point Reward"
  @override
  String get seePoint => "See Point Reward";
  /// "Shovel in use"
  @override
  String get shovelinuse => "Shovel in use";
  /// "Days"
  @override
  String get day => "Days";
  /// "Verified"
  @override
  String get inviteverified => "Verified";
  /// "Not Verified"
  @override
  String get notinviteverified => "Not Verified";
  /// "All"
  @override
  String get all => "All";
  /// "generation"
  @override
  String get generation => "generation";
  /// "Every active user"
  @override
  String get everyactiveuser => "Every active user";
  /// "Reward"
  @override
  String get reward => "Reward";
  /// "Enjoy"
  @override
  String get enjoy => "Enjoy";
  /// "My level"
  @override
  String get currentlevel => "My level";
  /// "Mining pool dividend"
  @override
  String get minedividends => "Mining pool dividend";
  /// "My community"
  @override
  String get mycommunity => "My community";
  /// "Number of people certified"
  @override
  String get numberpeople => "Number of people certified";
  /// "Total certified"
  @override
  String get totalnumberpeople => "Total certified";
  /// "Reset password"
  @override
  String get resetpwd => "Reset password";
  /// "${sender}"
  @override
  String space(String sender) => "${sender}";
  /// ""
  @override
  String get teamleadertotal => "";
  /// "Number of team"
  @override
  String get teamnumber => "Number of team";
  /// "Team Grades"
  @override
  String get teamperformance => "Team Grades";
  /// "Mining amount"
  @override
  String get dynamicincome => "Mining amount";
  /// "Direct Push Award"
  @override
  String get directPushAward => "Direct Push Award";
  /// "Reward for meeting standards"
  @override
  String get aimreward => "Reward for meeting standards";
  /// "My value"
  @override
  String get denomination => "My value";
  /// "Update"
  @override
  String get coinupdate => "Update";
  /// "History record"
  @override
  String get history => "History record";
  /// "Notice"
  @override
  String get notice => "Notice";
  /// "Upload ID photo"
  @override
  String get uploadid => "Upload ID photo";
  /// "Front of ID photo"
  @override
  String get idfront => "Front of ID photo";
  /// "Reverse side of ID"
  @override
  String get idback => "Reverse side of ID";
  /// "Take photo"
  @override
  String get takephoto => "Take photo";
  /// "Select from album"
  @override
  String get album => "Select from album";
  /// "Submit"
  @override
  String get submit => "Submit";
  /// "Change binding"
  @override
  String get changebind => "Change binding";
  /// "Current binding"
  @override
  String get currbind => "Current binding";
  /// "Binding rule: select one of mobile phone number and email to bind"
  @override
  String get bindrule => "Binding rule: select one of mobile phone number and email to bind";
  /// "Current Total Productivity"
  @override
  String get currtotalproduce => "Current Total Productivity";
  /// "Backpack Capacity"
  @override
  String get packagesize => "Backpack Capacity";
  /// "Today's estimate obtained"
  @override
  String get todaypreget => "Today's estimate obtained";
  /// "Cumulative output"
  @override
  String get totalgetmigos => "Cumulative output";
  /// "specification"
  @override
  String get specification => "specification";
  /// "Durability"
  @override
  String get durability => "Durability";
  /// "Production Volume"
  @override
  String get production => "Production Volume";
  /// "Volume"
  @override
  String get volume => "Volume";
  /// "Use"
  @override
  String get use => "Use";
  /// "Are you sure you want to use this item?"
  @override
  String get usernotice => "Are you sure you want to use this item?";
  /// "1. Type of document: ID card, passport or driver’s license.\n2. The document information and face must be clearly seen, and the document must be hand-held to take pictures.\n3. The document must not exceed 500kb.\n4. The content of the photo is true and valid, No modification is allowed.\n5. The uploaded file formats are pdf, jpg, jpeg and png."
  @override
  String get uploadnotice => "1. Type of document: ID card, passport or driver’s license.\n2. The document information and face must be clearly seen, and the document must be hand-held to take pictures.\n3. The document must not exceed 500kb.\n4. The content of the photo is true and valid, No modification is allowed.\n5. The uploaded file formats are pdf, jpg, jpeg and png.";
  /// "The name and ID number cannot be changed after the first submission. In order to avoid filling in false information, the recharge and withdrawal cannot be approved, please fill in the real information carefully."
  @override
  String get authnotice => "The name and ID number cannot be changed after the first submission. In order to avoid filling in false information, the recharge and withdrawal cannot be approved, please fill in the real information carefully.";
  /// "Invitation code: "
  @override
  String get myinvitecode => "Invitation code: ";
  /// "Invite 5 friends and complete real-name authentication \n to get a blind box"
  @override
  String get myinvitecodenotice => "Invite 5 friends and complete real-name authentication \n to get a blind box";
  /// "Invite Link"
  @override
  String get invitelink => "Invite Link";
  /// "Save Poster"
  @override
  String get saveimage => "Save Poster";
  /// "people in total"
  @override
  String get peopleintotal => "people in total";
  /// "Successed"
  @override
  String get success => "Successed";
  /// "Earnings Record"
  @override
  String get earnrecord => "Earnings Record";
  /// "1. Withdrawal will deduct part of the handling fee, which is based on the actual arrival."
  @override
  String get withDrawNotice => "1. Withdrawal will deduct part of the handling fee, which is based on the actual arrival.";
  /// "User Agreement"
  @override
  String get settinguserprotocol => "User Agreement";
  /// "Privacy Agreement"
  @override
  String get settingprotocol => "Privacy Agreement";
  /// "APP version update content"
  @override
  String get settingupdate => "APP version update content";
  /// "APP version"
  @override
  String get appcurrversion => "APP version";
  /// "Friend invitation process"
  @override
  String get feedinvite => "Friend invitation process";
  /// "Account management matters"
  @override
  String get feedaccount => "Account management matters";
  /// "Explanation of mine income"
  @override
  String get feedmines => "Explanation of mine income";
  /// "Use of other functions"
  @override
  String get feeduse => "Use of other functions";
  /// "Send feedback"
  @override
  String get feed => "Send feedback";
  /// "Withdrawal of funds and account deletion process"
  @override
  String get feeddel => "Withdrawal of funds and account deletion process";
  /// "Please briefly describe your question or comment so that we can provide you with better help."
  @override
  String get feennotice => "Please briefly describe your question or comment so that we can provide you with better help.";
  /// "Select file"
  @override
  String get feedchoose => "Select file";
  /// "Please input content"
  @override
  String get pleaseinput => "Please input content";
  /// "Using"
  @override
  String get using => "Using";
  /// "shovel"
  @override
  String get shovel => "shovel";
  /// "Paid"
  @override
  String get paid => "Paid";
  /// "Passwords are not consistent"
  @override
  String get notsamepwd => "Passwords are not consistent";

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