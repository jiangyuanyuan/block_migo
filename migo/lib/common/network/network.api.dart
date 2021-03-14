part of 'network.dart';
class API {
  
  /// banner图数据1 首页 2理财页
  static const String banner = "user/bBanner/getBanner/";
  static const String gtRegister = "user/gt/register";
  static const String gtValidate = "user/gt/gValidate";
  /// 获取验证码, 获取邮箱验证码
  static const String sms = "sms/sms/sendPhone/";
  static const String emailcode = "sms/email/sendEmailCode/";
  static const String login = "user/uUser/loginByPass";
  static const String authTimes = "user/uUser/authTimes";
  static const String identityAuthen = "user/uUser/authUserByPhoto";
  static const String version = "user/bAppVersion/getNewVersion/";
  static const String getMyProfitListByShovel = "user/uMineUserShovel/getMyProfitListByShovel";
  /// 上传文件
  static const String file = "user/uploadFile/upload";

  /// 修改用户资料
  static const String mod = "user/uUser/changeInformation";

  /// 检查用户否注册
  static const String isregister = "uUser/beforeRegister";

  static const String changeBinding = "user/uUser/changeBinding";
  static const String changeBinding2 = "user/uUser/changeBinding2";
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
  static const String myExchangeRecordPage = "user/eExchangeRecord/myExchangeRecordPage";
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

  static const String myExchangeRecord = "user/eExchangeRecord/myExchangeRecord/";

  static const String uUserFeedback = "user/uUserFeedback/submit";

  static const String checkAddress = "transfer/withdraw/checkAddress";
  
  static const String getUserTicket = "user/uUserTicket/getUserTicket";
  static const String checkUser = "user/uUserTicket/checkUser";
  static const String sendUserTicket = "user/uUserTicket/sendUserTicket";
  static const String uUserTicketRecord = "user/uUserTicketRecord/record/";
  /// 
  static const String shareDetails = "user/uUserReferee/shareDetails/";
  static const String checkStatus = "user/uUser/checkStatus";
  static const String myTeamPage2 = "user/uUserReferee/myTeamPage2";
  static const String myTeamPage3 = "user/uUserReferee/myTeamPage3";
  static const String myTeamPage4 = "user/uUserReferee/myTeamPage4";
  static const String myTeamPageStatistics = "user/uUserReferee/myTeamPageStatistics";
  static const String myTeamPage5 = "user/uUserReferee/myTeamPage5";

  static const String mySmallTeamPageStatistics = "user/uUserReferee/mySmallTeamPageStatistics";

  
  ///设置收款账号
  static const String addUserPay = "otc/oUserPay/addUserPay";
  static const String updateUserPay = "otc/oUserPay/updateUserPay";
  static const String userPays = "otc/oUserPay/userPays";
  static const String videoAd = "otc/oAd/VideoAd";
  static const String adBase = "otc/oAd/adBase";
  static const String otcAdd = "otc/oAd/addAd";
  static const String adList = "otc/oAd/adList";
  static const String buildOrder = "otc/oOrder/buildOrder";
  static const String sureaddOrder = "otc/oOrder/addOrder";
  static const String orderList = "otc/oOrder/orderList/";
  static const String getUserPay = "otc/oOrder/getUserPay/";
  static const String orderPay = "otc/oOrder/orderPay";
  static const String payMoney = "otc/oOrder/payMoney";
  static const String payCoin = "otc/oOrder/payCoin";
  /// 委托中的订单
  static const String myad = "otc/oAd/myAd";
  static const String myadCancel = "otc/oAd/cancel";
  /// 订单申诉
  static const String otctappealOrder = "otc/oOrder/appealOrder";
  static const String getUserMsg = "user/uUser/getUserMsg";
  static const String unsealUser = "otc/oAd/unsealUser";
   
}
  