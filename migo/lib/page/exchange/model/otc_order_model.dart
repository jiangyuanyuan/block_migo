import 'package:migo/page/exchange/model/sell_detail_model.dart';

class OtcOrderResponse {
  int code;
  String msg;
  List<SellDetailModel> data;

  OtcOrderResponse({this.code, this.msg, this.data});

  OtcOrderResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SellDetailModel>();
      json['data'].forEach((v) {
        data.add(new SellDetailModel.fromJson(v));
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

class AdDelegateResponse {
  int code;
  String msg;
  List<MyAdDelegateModel> data;

  AdDelegateResponse({this.code, this.msg, this.data});

  AdDelegateResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<MyAdDelegateModel>();
      json['data'].forEach((v) {
        data.add(new MyAdDelegateModel.fromJson(v));
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

class MyAdDelegateModel {
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
  int cancel;

  MyAdDelegateModel(
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
        this.cancel,
        this.createTime});

  MyAdDelegateModel.fromJson(Map<String, dynamic> json) {
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
    cancel = json['cancel'];
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
    data['cancel'] = this.cancel;
    data['createTime'] = this.createTime;
    return data;
  }
}
