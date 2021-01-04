class ExchangeResponse {
  int code;
  String msg;
  List<ExhangeModel> data;

  ExchangeResponse({this.code, this.msg, this.data});

  ExchangeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<ExhangeModel>();
      json['data'].forEach((v) {
        data.add(new ExhangeModel.fromJson(v));
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

class ExhangeModel {
  String id;
  String adNo;
  num orderNumber;
  num freezingNumber;
  int orderType;
  num orderPrice;
  String userId;
  num orderAmount;
  String orderPayWay;
  int priceType;
  num priceRate;
  int status;
  int createTime;

  ExhangeModel(
      {this.id,
      this.adNo,
      this.orderNumber,
      this.freezingNumber,
      this.orderType,
      this.orderPrice,
      this.userId,
      this.orderAmount,
      this.orderPayWay,
      this.priceType,
      this.priceRate,
      this.status,
      this.createTime});

  ExhangeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adNo = json['adNo'];
    orderNumber = json['orderNumber'];
    freezingNumber = json['freezingNumber'];
    orderType = json['orderType'];
    orderPrice = json['orderPrice'];
    userId = json['userId'];
    orderAmount = json['orderAmount'];
    orderPayWay = json['orderPayWay'];
    priceType = json['priceType'];
    priceRate = json['priceRate'];
    status = json['status'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adNo'] = this.adNo;
    data['orderNumber'] = this.orderNumber;
    data['freezingNumber'] = this.freezingNumber;
    data['orderType'] = this.orderType;
    data['orderPrice'] = this.orderPrice;
    data['userId'] = this.userId;
    data['orderAmount'] = this.orderAmount;
    data['orderPayWay'] = this.orderPayWay;
    data['priceType'] = this.priceType;
    data['priceRate'] = this.priceRate;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    return data;
  }
}
