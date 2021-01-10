class SellDetailResponse {
  int code;
  String msg;
  SellDetailModel data;

  SellDetailResponse({this.code, this.msg, this.data});

  SellDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new SellDetailModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SellDetailModel {
  String id;
  String adId;
  String adUserId;
  int userPayWay;
  String userName;
  String userMobile;
  String sellMobile;
  String userPayName;
  String adUserPayNo;
  String adOpenBank;
  String adOpenBranchBank;
  String userId;
  String orderNo;
  num orderNumber;
  num orderPrice;
  num orderTotalUsdt;
  num orderTotalCny;
  int status;
  num userFee;
  num userLevel;
  num userTotalSell;
  num userPayTotal;
  num outOfTime;
  num cancelOfTime;
  num updateTime;
  num createTime;
  String orderPayWay;
  int payMoneyStatus;
  int payCoinStatus;

  SellDetailModel(
      {this.id,
      this.adId,
      this.adUserId,
      this.sellMobile,
      this.userPayWay,
      this.userName,
      this.userMobile,
      this.userPayName,
      this.adUserPayNo,
      this.adOpenBank,
      this.adOpenBranchBank,
      this.userId,
      this.orderNo,
      this.orderNumber,
      this.orderPrice,
      this.orderTotalUsdt,
      this.orderTotalCny,
      this.status,
      this.userFee,
      this.userLevel,
      this.userTotalSell,
      this.userPayTotal,
      this.outOfTime,
      this.cancelOfTime,
      this.updateTime,
      this.createTime,
      this.orderPayWay,
      this.payMoneyStatus,
      this.payCoinStatus});

  SellDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adId = json['adId'];
    adUserId = json['adUserId'];
    userPayWay = json['userPayWay'];
    userName = json['userName'];
    userMobile = json['userMobile'];
    userPayName = json['userPayName'];
    adUserPayNo = json['adUserPayNo'];
    sellMobile = json["sellUserMobile"];
    adOpenBank = json['adOpenBank'];
    adOpenBranchBank = json['adOpenBranchBank'];
    userId = json['userId'];
    orderNo = json['orderNo'];
    orderNumber = json['orderNumber'];
    orderPrice = json['orderPrice'];
    orderTotalUsdt = json['orderTotalUsdt'];
    orderTotalCny = json['orderTotalCny'];
    status = json['status'];
    userFee = json['userFee'];
    userLevel = json['userLevel'];
    userTotalSell = json['userTotalSell'];
    userPayTotal = json['userPayTotal'];
    outOfTime = json['outOfTime'];
    cancelOfTime = json['cancelOfTime'];
    updateTime = json['updateTime'];
    createTime = json['createTime'];
    orderPayWay = json['orderPayWay'];
    payMoneyStatus = json['payMoneyStatus'];
    payCoinStatus = json['payCoinStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adId'] = this.adId;
    data['adUserId'] = this.adUserId;
    data['adUserPayWay'] = this.userPayWay;
    data['adUserName'] = this.userName;
    data['adUserMobile'] = this.userMobile;
    data['adUserPayName'] = this.userPayName;
    data['adUserPayNo'] = this.adUserPayNo;
    data['adOpenBank'] = this.adOpenBank;
    data['adOpenBranchBank'] = this.adOpenBranchBank;
    data['userId'] = this.userId;
    data['orderNo'] = this.orderNo;
    data['orderNumber'] = this.orderNumber;
    data['orderPrice'] = this.orderPrice;
    data['orderTotalUsdt'] = this.orderTotalUsdt;
    data['orderTotalCny'] = this.orderTotalCny;
    data['status'] = this.status;
    data['userFee'] = this.userFee;
    data['userLevel'] = this.userLevel;
    data['userTotalSell'] = this.userTotalSell;
    data['userPayTotal'] = this.userPayTotal;
    data['outOfTime'] = this.outOfTime;
    data['cancelOfTime'] = this.cancelOfTime;
    data['updateTime'] = this.updateTime;
    data['createTime'] = this.createTime;
    data['orderPayWay'] = this.orderPayWay;
    data['payMoneyStatus'] = this.payMoneyStatus;
    data['payCoinStatus'] = this.payCoinStatus;
    return data;
  }
}
