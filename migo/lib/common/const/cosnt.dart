import 'package:flutter/material.dart';

class AppConst {
  ///
  ///
  ///
  /// 是否是发布版本
  ///
  /// 修改这个,注意修改single => websocket的地址
  ///
  static const bool APP_IS_RELEASE = true;

  ///
  /// usertoken
  static const String KEY_user_token = "KEY_user_token";

  ///
  /// 是否是第一次登录
  ///
  static const String APP_IS_FIRST = "APP_IS_FIRST";

  ///
  /// 是否已经登录
  ///
  static const String APP_IS_LOGIN = "APP_IS_LOGIN";

  /// 缓存的banner图
  static const String APP_BANNERS_KEY = "APP_BANNERS_KEY";

  ///
  /// test data
  ///
  static const String KConstData = '''
  {"ch":"market.btcusdt.kline.1day","status":"ok","ts":1594778752403,"data":[{"id":1594742400,"open":9220.01,"close":9250.19,"low":9210.0,"high":9275.0,"amount":6681.430723164349,"vol":6.180599482122426E7,"count":0},{"id":1594656000,"open":9290.28,"close":9220.01,"low":9117.12,"high":9321.74,"amount":29028.893313235458,"vol":2.673504187475434E8,"count":0}]}
''';
}

class AppColor {
  static const Color blue = Color(0xff1476FE);
  static const Color yellowMain = Color(0xff816C65);
  static const Color green = Color(0xff1BAF82);
  static const Color red = Color(0xffF33E3F);
  static const Color grey = Color(0xfff9f9f9);
  static const Color yellow = Color(0xffFFB819);

  /// f9f9f9
  static const Color f9f9f9 = Color(0xfff9f9f9);
  static const Color ccc = Color(0xfffcccccc);

  /// a5a5a5
  static const Color fontgrey = Color(0xffa5a5a5);
  static const Color font666 = Color(0xff666666);
  static const Color font333 = Color(0xff333333);

  /// f3f3f3
  static const Color divigrey = Color(0xfff3f3f3);
  static const Color back998 = Color(0xff4C7998);
}
