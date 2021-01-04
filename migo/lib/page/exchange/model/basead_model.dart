class BaseAdResponse {
  int code;
  String msg;
  BaseAdModel data;

  BaseAdResponse({this.code, this.msg, this.data});

  BaseAdResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new BaseAdModel.fromJson(json['data']) : null;
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

class BaseAdModel {
  num totalTradeAmount;
  String todayPrice;
  String yesterdayPrice;
  num todayTradeAmount;
  String newUsdtPrice;
  num balance;

  BaseAdModel(
      {this.totalTradeAmount,
      this.todayPrice,
      this.yesterdayPrice,
      this.balance,
      this.todayTradeAmount,
      this.newUsdtPrice});

  BaseAdModel.fromJson(Map<String, dynamic> json) {
    totalTradeAmount = json['totalTradeAmount'];
    todayPrice = json['todayPrice'];
    yesterdayPrice = json['yesterdayPrice'];
    balance = json["balance"];
    todayTradeAmount = json['todayTradeAmount'];
    newUsdtPrice = json['newUsdtPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalTradeAmount'] = this.totalTradeAmount;
    data['todayPrice'] = this.todayPrice;
    data['yesterdayPrice'] = this.yesterdayPrice;
    data['todayTradeAmount'] = this.todayTradeAmount;
    data['newUsdtPrice'] = this.newUsdtPrice;
    return data;
  }
}
