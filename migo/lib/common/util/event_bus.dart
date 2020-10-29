typedef void EventCallback(arg);

class EventKeys {
  static const String RefreshAPI = "RefreshAPI"; // 添加成功之后刷新API
  static const String Opendrawer = "Opendrawer"; // 打开侧边栏
  static const String BuyAction = "BuyAction"; // 打开侧边栏
  static const String TabIndex = "TabIndex"; // 打开侧边栏
  static const String CoinsCloseKeyBoard = "CoinsCloseKeyBoard"; // 币币交易关闭键盘
  static const String ContractCloseKeyBoard = "ContractCloseKeyBoard"; // 合约交易关闭键盘
  static const String Login = "JUMP_TO_LOGIN"; // 跳到登录
  static const String AccountTransferRefresh = "AccountTransferRefresh"; // 划转刷新数据
  static const String ContractPriceRefresh = "ContractPriceRefresh"; // 平仓价格更新
  static const String ContractPriceCloseBoard = "ContractPriceCloseBoard"; // 平仓关闭键盘
  static const String JumpKline = "JumpKline"; // 平仓关闭键盘
  static const String JumpContractDelegatepage = "JumpContractDelegatepage"; // 平仓关闭键盘

  static const String ContractInpuprice = "ContractInpuprice"; // 平仓关闭键盘
  static const String ContractOpenInpuprice = "ContractOpenInpuprice"; // 点击开仓价格
  static const String CoinOpenInpuprice = "ContractOpenInpuprice"; // 币币点击开仓价格
}

class EventBus {
  factory EventBus() => _getInstance();
  static EventBus get instance => _getInstance();
  static EventBus _instance;
  
  EventBus._internal(){
    // init
  }
  static EventBus _getInstance() {
    if(_instance == null) {
      _instance = EventBus._internal();
    }
    return _instance;
  }

  Map<String, EventCallback> _events = {};

  // 添加监听
  void addListener(String eventkey, EventCallback callback) {
    if(eventkey == null || callback == null) return;
    _events[eventkey] = callback;
  }

  // 移除监听
  void removeListener(String eventKey) {
    if(eventKey == null) return;
    _events.remove(eventKey);
  }

  void commit(String eventKey, Object arg) {
    if(eventKey == null) return;
    EventCallback callback = _events[eventKey];
    if(callback != null) {
      callback(arg);
    }
  }
}