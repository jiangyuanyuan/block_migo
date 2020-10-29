part of 'network.dart';
class API {
  
  /// banner图数据1 首页 2理财页
  static const String banner = "banner/list/";
  /// 邀请注册获取type=1下载页面,type=2注册页面
  static const String invite = "user/userInvite/";
  /// 获取验证码, 获取邮箱验证码
  static const String sms = "sms/sendSms/";
  static const String loginsms = "sms/sendSms/";
  static const String emailcode = "email/sendEmailCode";
  
  /// 验证码登录注册
  static const String login = "user/loginByCode";
  
  static const String forgetpwd = "user/forgetPasswordPhone";
  /// 用户邀请登录
  static const String register = "user/register";

  /// 绑定邮箱
  static const String bindEmail = "user/bindEmail";

  static const String version = "app/getNewVersion";
  
  /// 用户反馈
  static const String uploadUserFeedback = "userfeedback/uploadUserFeedback";
  

  /// 设置登录密码
  static const String setpwd = "user/forgetPasswordPhone";
  static const String updatePassword = "uUser/updatePassword";
  /// 设置交易密码
  static const String setTransactionPassword = "user/setTransactionPassword";
  static const String openOrCloseTradePassword = "user/openOrCloseTradePassword";
  /// 身份认证
  static const String identityAuthen = "user/identityAuthen";
  
  /// 密码登录
  static const String loginpwd = "user/login";

  /// 上传文件
  static const String file = "file/uploadBase64";

  /// 修改用户资料
  static const String mod = "uUser/updateUser";

  /// 用户资产
  static const String useramount = "uUserAccount/userAmount";

  /// 币种充值列表
  static const String conintypelist = "userCoin/coinList/";
  static const String coinAddress = "userCoin/recharge/";

  /// 币种充值记录
  static const String coin_record = "userCoin/getCoinRecord/";

  /// 添加api
  static const String uploaduserapi = "cQuantizedUserApi/uploadUserApi";

  /// 检查用户否注册
  static const String isregister = "uUser/beforeRegister";
  
  /// 用户对外提现
  static const String withDrawOut = "userCoin/withDrawOut";

  /// 提币类型
  // static const String withDrawCoins = "userCoin/withdrawal";
  /// 提币记录
  static const String getTransferOut = "userCoin/getTransferOut/";

  /// 钱包
  static const String getUserEarn = "uUserAccount/getUserEarn";


  //// 用户资金账户
  static const String accountList = "userCoin/accountList";

  /// 用户下单委托单
  static const String coinsAdd = "orders/add";
  /// 撤销订单
  static const String cancelOrder = "orders/cancelOrder";
  /// 公告 公告类型 1新币上线 2最新公告 3常见问题 4信息公示 5条款说明 6关于我们
  static const String homenotice = "article/list/";
  /// 历史订单
  static const String tradelist = "trade/tradeList";
  static const String allTradeList = "orders/orderList";
  /// 市场交易对
  static const String marketList = "market/marketList";
  // 资金划转
  static const String transferAccount = "userAccountTransfer/transferAccount";
  // 获取可用
  static const String getAccount = "userCoin/getAccount/";
  /// 申请
  static const String apply = "userCoin/apply";
  // 邀请
  static const String getRefeRee = "userReferee/getRefeRee";
  
  // 我的团队
  static const String myTeam = "userReferee/myTeam";
  // 获取个人资料
  static const String userCenter = "user/userCenter";
  // 修改手机号码
  static const String updatePhone = "user/updatePhone";

  // 资金划转记录
  static const String getTransferDetail = "userAccountTransfer/getTransferDetail/";

  // 资金账户明细
  static const String detail = "userAccountDetail/detail";

  /// 理财产品记录
  static const String product = "financialProduct/product";
  static const String getUserProduct = "financialUserRecord/getUserProduct";
  static const String addUserProduct = "financialUserRecord/addUserProduct";
  /// 获取用户身份状态
  static const String getApplyUser = "userCoin/getApplyUser";
  /// 取消理财产品
  static const String cancelUserProduct = "financialUserRecord/cancelUserProduct";
  /// 获取理财收益明细
  static const String getUserDetail = "financialUserRecord/getUserDetail";
  /// 获取用户最新理财收益明细
  static const String getUserByFinancialId = "financialUserRecord/getUserByFinancialId/";

  // 合约下单
  static const String lendOrdersAdd = "lendOrders/add";
  /// 合约订单列表
  static const String lendOrderList = "lendOrders/orderList";
  
  /// 取消撤单
  static const String lendCancelOrder = "lendOrders/cancelOrder";
  /// 合约历史委托
  static const String lendhistoryOrderList = "lendOrders/historyOrderList";

  /// 合约持仓
  static const String lendGetUserHold = "lendUserHold/getUserHold";

  static const String getContractAccount = "userAccountTransfer/getContractAccount";
  
  /// 永续合约资金明细
  static const String getLendDetail = "lendDetail/getLendDetail/";
  static const String lendGetMarket = "lendMarket/getMarket/";
  static const String lengGetGetHistory = "lendOrders/getHistory/";
}
  