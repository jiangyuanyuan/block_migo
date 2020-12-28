import 'package:migo/common/qrcode/qr_page.dart';
import 'package:migo/login&regist/page/lanuage_page.dart';
import 'package:migo/login&regist/page/login_set_pwd.dart';
import 'package:migo/page/contract/page/coins_record_page.dart';
import 'package:migo/page/contract/page/constract_record_page.dart';
import 'package:migo/page/contract/page/exchange_success_page.dart';
import 'package:migo/page/contract/page/recharge_page.dart';
import 'package:migo/page/contract/page/reflect_page.dart';
import 'package:migo/page/contract/page/reflect_success_page.dart';
import 'package:migo/page/exchange/page/exchange_buy_page.dart';
import 'package:migo/page/home/page/home_detail_page.dart';
import 'package:migo/page/home/page/notice_page.dart';
import 'package:migo/page/home/page/web_page.dart';
import 'package:migo/page/mine/page/about_page.dart';
import 'package:migo/page/mine/page/auth_manage_page.dart';
import 'package:migo/page/mine/page/choose_month_page.dart';
import 'package:migo/page/mine/page/coins_detial_page.dart';
import 'package:migo/page/mine/page/feedback_page.dart';
import 'package:migo/page/mine/page/feedbak_post_page.dart';
import 'package:migo/page/mine/page/file_page.dart';
import 'package:migo/page/mine/page/invite_record_page.dart';
import 'package:migo/page/mine/page/mine_auth_page.dart';
import 'package:migo/page/mine/page/mine_auth_upload.dart';
import 'package:migo/page/mine/page/mine_earn_page.dart';
import 'package:migo/page/mine/page/mine_exchange_bind.dart';
import 'package:migo/page/mine/page/mine_invite_page.dart';
import 'package:migo/page/mine/page/mine_mod.dart';
import 'package:migo/page/mine/page/mine_mod_name.dart';
import 'package:migo/page/mine/page/mine_package_page.dart';
import 'package:migo/page/mine/page/mine_reel.dart';
import 'package:migo/page/mine/page/mine_reel_record.dart';
import 'package:migo/page/mine/page/mine_setting.dart';
import 'package:migo/page/mine/page/mine_shovel_record.dart';
import 'package:migo/page/mine/page/mine_team_page.dart';
import 'package:migo/page/mine/page/safe_page.dart';
import 'package:migo/page/mine/page/team_earth_page.dart';
import 'package:migo/page/mine/page/team_record_detail_page.dart';
import 'package:migo/page/mine/page/team_record_page.dart';
import 'package:migo/page/mine/page/threeauth_page.dart';
import 'package:migo/root/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login&regist/page/forget_pwd.dart';
import 'login&regist/page/login.dart';

final routes = {
  // tabbar
  '/root': (context) => RootPage(),
  '/login': (context, {arguments}) => LoginPage(param: arguments,),
  '/forgetpwd': (context) => ForgetPwdPage(),// 忘记密码
  '/language': (context) => LanguagePage(),  // 重新设置密码
  '/loginsetpwd': (context, {arguments}) => LoginSetPwd(param: arguments,),

  /// mine
  '/package': (context,{arguments}) => MinePackagePage(),// 第一次登录密码设置
  '/setting': (context,{arguments}) => MineSettingPage(),// 第一次登录密码设置
  '/invite': (context,{arguments}) => MineInvitePage(),// 第一次登录密码设置
  '/inviterecord': (context,{arguments}) => InviteRecordPage(),// 第一次登录密码设置
  '/mod': (context,{arguments}) => MineModPage(),// 第一次登录密码设置
  '/modname': (context,{arguments}) => MineModNamePage(params: arguments,),// 第一次登录密码设置
  '/safe': (context,{arguments}) => SafePage(),// 第一次登录密码设置
  '/coinsdetail': (context,{arguments}) => CoinsDetailPage(params: arguments),// 第一次登录密码设置
  '/teamrecord': (context,{arguments}) => TeamRecordPage(),// 第一次登录密码设置
  '/teamearth': (context,{arguments}) => TeamEarthPage(),// 第一次登录密码设置
  '/mineauth': (context,{arguments}) => MineAuthPage(),// 第一次登录密码设置
  '/authupload': (context,{arguments}) => MineAuthUploadPage(params: arguments,),// 第一次登录密码设置
  '/mineexchangebind': (context,{arguments}) => MineExchangeBindPage(),// 第一次登录密码设置
  '/mineearn': (context,{arguments}) => MineEarnPage(),// 第一次登录密码设置
  '/about': (context,{arguments}) => AboutPage(),// 第一次登录密码设置
  '/feedback': (context,{arguments}) => FeedbackPage(),// 第一次登录密码设置
  '/feedpost': (context,{arguments}) => FeedbackPosePage(),// 第一次登录密码设置
  '/choosemonth': (context,{arguments}) => ChooseMonthPage(params: arguments,),// 第一次登录密码设置
  '/notice': (context,{arguments}) => NoticePage(param: arguments,),// 第一次登录密码设置
  '/threeauth': (context,{arguments}) => ThreeAuthPage(),// 第一次登录密码设置
  '/authmanage': (context,{arguments}) => AuthManagePage(),// 第一次登录密码设置
  '/mineshovelrecord': (context,{arguments}) => MineShovelRecordPage(),// 第一次登录密码设置
  '/file': (context,{arguments}) => FilePage(params: arguments,),// 第一次登录密码设置
  '/reel': (context,{arguments}) => MineReelPage(),// 第一次登录密码设置
  '/reelcord': (context,{arguments}) => MineReelRecordPage(),// 第一次登录密码设置

  /// home
  '/homedetail': (context,{arguments}) => HomeDetailPage(params: arguments,),// 第一次登录密码设置


  /// exchange
  '/exchangesuccess': (context,{arguments}) => ExchangeSuccessPage(params: arguments,),// 第一次登录密码设置
  '/recharge': (context,{arguments}) => RechagePage(),// 第一次登录密码设置
  '/reflect': (context,{arguments}) => ReflectPage(),// 第一次登录密码设置
  '/reflectsuccess': (context,{arguments}) => ReflectSuccessPage(params: arguments,),// 第一次登录密码设置
  '/mineteam': (context,{arguments}) => MineTeamPage(),// 第一次登录密码设置
  '/coinsrecord': (context,{arguments}) => CoinsRecordPage(params: arguments,),// 第一次登录密码设置
  '/qrcode': (context,{arguments}) => QrCodePage(),// 第一次登录密码设置
  '/contractrecord': (context,{arguments}) => ConstractRecordPage(),// 第一次登录密码设置
  '/web': (context,{arguments}) => WebPage(params: arguments,),// 第一次登录密码设置
  '/teamrecorddetail': (context,{arguments}) => TeamRecordDetailPage(params: arguments,),// 第一次登录密码设置
  '/exchangebuy': (context,{arguments}) => ExchangeBuyPage(params: arguments,),// 第一次登录密码设置
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