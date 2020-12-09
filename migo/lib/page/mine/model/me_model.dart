class MeResponse {
  int code;
  String msg;
  MeModel data;

  MeResponse({this.code, this.msg, this.data});

  MeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new MeModel.fromJson(json['data']) : null;
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

class MeModel {
  String logo;
  int id;
  String nickName;
  int teamUserCount;
  num totalTeamUserAmount;
  num todayProfit;
  num faceValue;
  List<MineCoinModel> accountList;

  MeModel(
      {this.logo,
      this.id,
      this.nickName,
      this.teamUserCount,
      this.totalTeamUserAmount,
      this.todayProfit,
      this.faceValue,
      this.accountList});

  MeModel.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    id = json['id'];
    nickName = json['nickName'];
    teamUserCount = json['teamUserCount'];
    totalTeamUserAmount = json['totalTeamUserAmount'];
    todayProfit = json['todayProfit'];
    faceValue = json['faceValue'];
    if (json['accountList'] != null) {
      accountList = new List<MineCoinModel>();
      json['accountList'].forEach((v) {
        accountList.add(new MineCoinModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['id'] = this.id;
    data['nickName'] = this.nickName;
    data['teamUserCount'] = this.teamUserCount;
    data['totalTeamUserAmount'] = this.totalTeamUserAmount;
    data['todayProfit'] = this.todayProfit;
    data['faceValue'] = this.faceValue;
    if (this.accountList != null) {
      data['accountList'] = this.accountList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MineCoinModel {
  int id;
  int userId;
  num amount;
  num frozenAmount;
  num refereeAmount;
  num teamAmount;
  int createTime;
  String coinUrl;
  num withdrawAmount;
  String coinName;
  String address;
  String omniAddress;
  int isShow;
  num gameAmount;
  String trcAddress;
  String privateKey;
  num releaseAmount;
  num exchangeAmount;
  num cnyAmount;
  String coinType;

  MineCoinModel(
      {this.id,
      this.userId,
      this.coinUrl,
      this.amount,
      this.frozenAmount,
      this.refereeAmount,
      this.teamAmount,
      this.createTime,
      this.withdrawAmount,
      this.coinName,
      this.address,
      this.omniAddress,
      this.cnyAmount,
      this.isShow,
      this.gameAmount,
      this.trcAddress,
      this.privateKey,
      this.releaseAmount,
      this.exchangeAmount,
      this.coinType});

  MineCoinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    amount = json['amount'];
    coinUrl = json["coinUrl"];
    frozenAmount = json['frozenAmount'];
    refereeAmount = json['refereeAmount'];
    teamAmount = json['teamAmount'];
    createTime = json['createTime'];
    withdrawAmount = json['withdrawAmount'];
    coinName = json['coinName'];
    address = json['address'];
    omniAddress = json['omniAddress'];
    cnyAmount = json["cnyAmount"] ?? 0;
    isShow = json['isShow'];
    gameAmount = json['gameAmount'];
    trcAddress = json['trcAddress'];
    privateKey = json['privateKey'];
    releaseAmount = json['releaseAmount'];
    exchangeAmount = json['exchangeAmount'];
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
    data['withdrawAmount'] = this.withdrawAmount;
    data['coinName'] = this.coinName;
    data['address'] = this.address;
    data['omniAddress'] = this.omniAddress;
    data['isShow'] = this.isShow;
    data['gameAmount'] = this.gameAmount;
    data['trcAddress'] = this.trcAddress;
    data['privateKey'] = this.privateKey;
    data['releaseAmount'] = this.releaseAmount;
    data['exchangeAmount'] = this.exchangeAmount;
    data['coinType'] = this.coinType;
    return data;
  }
}
