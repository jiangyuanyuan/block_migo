class ReflectRecordResponse {
  int code;
  List<ReflectRecordModel> data;
  String msg;

  ReflectRecordResponse({this.code, this.data, this.msg});

  ReflectRecordResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<ReflectRecordModel>();
      json['data'].forEach((v) {
        data.add(new ReflectRecordModel.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class ReflectRecordModel {
  num amount;
  num chainFee;
  String coinName;
  String coinType;
  int createTime;
  num fee;
  String finishTime;
  String fromAddress;
  int id;
  int isFinish;
  int outType;
  int status;
  String toAddress;
  String txId;
  int userId;
  num withdrawAmount;

  ReflectRecordModel(
      {this.amount,
      this.chainFee,
      this.coinName,
      this.coinType,
      this.createTime,
      this.fee,
      this.finishTime,
      this.fromAddress,
      this.id,
      this.isFinish,
      this.outType,
      this.status,
      this.toAddress,
      this.txId,
      this.userId,
      this.withdrawAmount});

  ReflectRecordModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    chainFee = json['chainFee'];
    coinName = json['coinName'];
    coinType = json['coinType'];
    createTime = json['createTime'];
    fee = json['fee'];
    finishTime = json['finishTime'];
    fromAddress = json['fromAddress'];
    id = json['id'];
    isFinish = json['isFinish'];
    outType = json['outType'];
    status = json['status'];
    toAddress = json['toAddress'];
    txId = json['txId'];
    userId = json['userId'];
    withdrawAmount = json['withdrawAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['chainFee'] = this.chainFee;
    data['coinName'] = this.coinName;
    data['coinType'] = this.coinType;
    data['createTime'] = this.createTime;
    data['fee'] = this.fee;
    data['finishTime'] = this.finishTime;
    data['fromAddress'] = this.fromAddress;
    data['id'] = this.id;
    data['isFinish'] = this.isFinish;
    data['outType'] = this.outType;
    data['status'] = this.status;
    data['toAddress'] = this.toAddress;
    data['txId'] = this.txId;
    data['userId'] = this.userId;
    data['withdrawAmount'] = this.withdrawAmount;
    return data;
  }
}
