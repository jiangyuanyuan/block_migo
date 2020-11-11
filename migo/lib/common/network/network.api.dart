part of 'network.dart';
class API {
  
  /// banner图数据1 首页 2理财页
  static const String banner = "user/bBanner/getBanner/";
  /// 获取验证码, 获取邮箱验证码
  static const String sms = "sms/sms/sendPhone/";
  static const String emailcode = "sms/email/sendEmailCode/";
  static const String login = "user/uUser/loginByPass";
  /// 上传文件
  static const String file = "file/uploadBase64";

  /// 修改用户资料
  static const String mod = "user/uUser/changeInformation";

  /// 检查用户否注册
  static const String isregister = "uUser/beforeRegister";

  static const String changeBinding = "user/uUser/changeBinding";
  static const String changeTXPwd = "user/uUser/changeTXPwd";
  static const String updatePwd = "user/uUser/updatePwd";
  static const String getMineBaseList = "user/mMineBase/getMineBaseList/";
  static const String getMyNotOpenBox = "user/mMineUserToolbox/getMyNotOpenBox";
  static const String openBox = "user/mMineUserToolbox/openBox";
  static const String mePage = "user/uUser/mePage";
  // static const String getMyNotUseShovel = "user/uMineUserShovel/getMyKnapsack";
  static const String invite = "user/uUserReferee/invite";
  static const String myInviteDetail = "user/uUserReferee/myInviteDetail";
  static const String miningBeltShovel = "user/mMineUser/miningBeltShovel";
  static const String getMyKnapsack = "user/uMineUserShovel/getMyKnapsack";
  static const String getAccountDetailByCoinName = "user/uUserAccountDetail/getAccountDetailByCoinName/";
  static const String exchangePage = "user/eExchangeRecord/exchangePage";
  static const String exchangePagePost = "user/eExchangeRecord/exchangeCoin";
}
  