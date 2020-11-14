class ReflectResponse {
  int code;
  String msg;
  List<ReflectModel> data;

  ReflectResponse({this.code, this.msg, this.data});

  ReflectResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<ReflectModel>();
      json['data'].forEach((v) {
        data.add(new ReflectModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReflectModel {
  WCoinModel wCoin;
  AccountModel account;

  ReflectModel({this.wCoin, this.account});

  ReflectModel.fromJson(Map<String, dynamic> json) {
    wCoin = json['wCoin'] != null ? new WCoinModel.fromJson(json['wCoin']) : null;
    account =
        json['account'] != null ? new AccountModel.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wCoin != null) {
      data['wCoin'] = this.wCoin.toJson();
    }
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    return data;
  }
}

class WCoinModel {
  int id;
  String coinType;
  String coinName;
  String shortName;
  String coinImg;
  num outQtyToColdAddress;
  String contract;
  num coinDecimal;
  num allowRecharge;
  num allowWithdraw;
  num outWithdrawFee;
  num maxOutQty;
  num minOutQty;
  num warningQty;
  num outQtyToMainAddress;
  num inWithdrawFee;
  num minRechargeQty;
  String propertyId;
  int syncBlockNumber;
  int confirmationsNum;
  int isShow;
  int allowExchange;
  int allowTransfer;

  WCoinModel(
      {this.id,
      this.coinType,
      this.coinName,
      this.shortName,
      this.coinImg,
      this.outQtyToColdAddress,
      this.contract,
      this.coinDecimal,
      this.allowRecharge,
      this.allowWithdraw,
      this.outWithdrawFee,
      this.maxOutQty,
      this.minOutQty,
      this.warningQty,
      this.outQtyToMainAddress,
      this.inWithdrawFee,
      this.minRechargeQty,
      this.propertyId,
      this.syncBlockNumber,
      this.confirmationsNum,
      this.isShow,
      this.allowExchange,
      this.allowTransfer});

  WCoinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coinType = json['coinType'];
    coinName = json['coinName'];
    shortName = json['shortName'];
    coinImg = json['coinImg'];
    outQtyToColdAddress = json['outQtyToColdAddress'];
    contract = json['contract'];
    coinDecimal = json['coinDecimal'];
    allowRecharge = json['allowRecharge'];
    allowWithdraw = json['allowWithdraw'];
    outWithdrawFee = json['outWithdrawFee'];
    maxOutQty = json['maxOutQty'];
    minOutQty = json['minOutQty'];
    warningQty = json['warningQty'];
    outQtyToMainAddress = json['outQtyToMainAddress'];
    inWithdrawFee = json['inWithdrawFee'];
    minRechargeQty = json['minRechargeQty'];
    propertyId = json['propertyId'];
    syncBlockNumber = json['syncBlockNumber'];
    confirmationsNum = json['confirmationsNum'];
    isShow = json['isShow'];
    allowExchange = json['allowExchange'];
    allowTransfer = json['allowTransfer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coinType'] = this.coinType;
    data['coinName'] = this.coinName;
    data['shortName'] = this.shortName;
    data['coinImg'] = this.coinImg;
    data['outQtyToColdAddress'] = this.outQtyToColdAddress;
    data['contract'] = this.contract;
    data['coinDecimal'] = this.coinDecimal;
    data['allowRecharge'] = this.allowRecharge;
    data['allowWithdraw'] = this.allowWithdraw;
    data['outWithdrawFee'] = this.outWithdrawFee;
    data['maxOutQty'] = this.maxOutQty;
    data['minOutQty'] = this.minOutQty;
    data['warningQty'] = this.warningQty;
    data['outQtyToMainAddress'] = this.outQtyToMainAddress;
    data['inWithdrawFee'] = this.inWithdrawFee;
    data['minRechargeQty'] = this.minRechargeQty;
    data['propertyId'] = this.propertyId;
    data['syncBlockNumber'] = this.syncBlockNumber;
    data['confirmationsNum'] = this.confirmationsNum;
    data['isShow'] = this.isShow;
    data['allowExchange'] = this.allowExchange;
    data['allowTransfer'] = this.allowTransfer;
    return data;
  }
}

class AccountModel {
  int id;
  int userId;
  num amount;
  num frozenAmount;
  num refereeAmount;
  num teamAmount;
  int createTime;
  String coinName;
  String address;
  String omniAddress;
  int isShow;
  String trcAddress;
  String coinType;

  AccountModel(
      {this.id,
      this.userId,
      this.amount,
      this.frozenAmount,
      this.refereeAmount,
      this.teamAmount,
      this.createTime,
      this.coinName,
      this.address,
      this.omniAddress,
      this.isShow,
      this.trcAddress,
      this.coinType});

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    amount = json['amount'];
    frozenAmount = json['frozenAmount'];
    refereeAmount = json['refereeAmount'];
    teamAmount = json['teamAmount'];
    createTime = json['createTime'];
    coinName = json['coinName'];
    address = json['address'];
    omniAddress = json['omniAddress'];
    isShow = json['isShow'];
    trcAddress = json['trcAddress'];
    coinType = json['coinType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['frozenAmount'] = this.frozenAmount;
    data['refereeAmount'] = this.refereeAmount;
    data['teamAmount'] = this.teamAmount;
    data['createTime'] = this.createTime;
    data['coinName'] = this.coinName;
    data['address'] = this.address;
    data['omniAddress'] = this.omniAddress;
    data['isShow'] = this.isShow;
    data['trcAddress'] = this.trcAddress;
    data['coinType'] = this.coinType;
    return data;
  }
}
