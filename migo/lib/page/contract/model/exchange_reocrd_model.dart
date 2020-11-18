class ExchangeRecordResponse {
  int code;
  String msg;
  List<ExchangeRecordModel> data;

  ExchangeRecordResponse({this.code, this.msg, this.data});

  ExchangeRecordResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<ExchangeRecordModel>();
      json['data'].forEach((v) {
        data.add(new ExchangeRecordModel.fromJson(v));
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

class ExchangeRecordModel {
  String id;
  String userId;
  String coinName;
  String toCoinName;
  num price;
  num inputnum;
  num toNum;
  num fee;
  num realNum;
  int createTime;
  num realToNum;
  String orderNumber;

  ExchangeRecordModel(
      {this.id,
      this.userId,
      this.coinName,
      this.toCoinName,
      this.price,
      this.inputnum,
      this.toNum,
      this.fee,
      this.realNum,
      this.createTime,
      this.realToNum,
      this.orderNumber});

  ExchangeRecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    coinName = json['coinName'];
    toCoinName = json['toCoinName'];
    price = json['price'];
    inputnum = json['num'];
    toNum = json['toNum'];
    fee = json['fee'];
    realNum = json['realNum'];
    createTime = json['createTime'];
    realToNum = json['realToNum'];
    orderNumber = json['orderNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['coinName'] = this.coinName;
    data['toCoinName'] = this.toCoinName;
    data['price'] = this.price;
    data['num'] = this.inputnum;
    data['toNum'] = this.toNum;
    data['fee'] = this.fee;
    data['realNum'] = this.realNum;
    data['createTime'] = this.createTime;
    data['realToNum'] = this.realToNum;
    data['orderNumber'] = this.orderNumber;
    return data;
  }
}
