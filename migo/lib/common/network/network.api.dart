part of 'network.dart';
class API {
  
  /// banner图数据1 首页 2理财页
  static const String banner = "user/bBanner/getBanner/";
  /// 获取验证码, 获取邮箱验证码
  static const String sms = "sms/sms/sendPhone/";
  static const String emailcode = "sms/email/sendEmailCode/";
  static const String login = "user/uUser/loginByPass";
  static const String identityAuthen = "user/uUser/authUserByPhoto";
  static const String version = "user/bAppVersion/getNewVersion/";
  /// 上传文件
  static const String file = "user/uploadFile/upload";

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
  static const String miningBeltShovel = "user/uMineUserShovel/useMyShovel/";
  static const String getMyKnapsack = "user/uMineUserShovel/getMyKnapsack";
  static const String getAccountDetailByCoinName = "user/uUserAccountDetail/getAccountDetailByCoinName/";
  static const String exchangePage = "user/eExchangeRecord/exchangePage";
  static const String exchangePagePost = "user/eExchangeRecord/exchangeCoin";
  static const String getMyPayList = "user/mMineUser/getMyPayList/";
  static const String getMyProfitList = "user/mMineUser/getMyProfitList/";
  // static const String getAccountPageByCoinName = "user/uUserAccountDetail/getAccountPageByCoinName/";
  static const String myTeamPage = "user/uUserReferee/myTeamPage";
  static const String getMyMineList = "user/mMineUser/getMyMineList/";
  static const String getMineBaseById = "user/mMineBase/getMineBaseById/";
  static const String homeminingBeltShovel = "user/mMineUser/miningBeltShovel";
  /// 团队
  static const String teamProfitPage = "user/uUserReferee/teamProfitPage/";
  /// 分红
  static const String poolBonusPage = "user/uUserReferee/poolBonusPage";
  // 查询
  static const String securityCenter = "user/uUser/securityCenter";
  static const String authUserByBank = "user/uUser/authUserByBank";
  // 提现币种列表
  static const String  withDrawCoins = "user/wRecordTransferOut/withDrawCoins";
  // 提现
  static const String  withDrawOut = "user/wRecordTransferOut/withDrawOut";

  // 充币地址
  static const String  rechargeCoinList = "user/wRecordRecharge/rechargeCoinList";

  // 充值记录
  static const String  rechargeDetailList = "user/wRecordRecharge/rechargeDetailList";

  static const String getTransferOut = "user/wRecordTransferOut/getTransferOut/";

  static const String getMyProfitOrPayListPage = "user/mMineUser/getMyProfitOrPayListPage";
}
  