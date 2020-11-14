class RechageRecordResponse {
  int code;
  List<RechargeRecordModel> data;
  String msg;

  RechageRecordResponse({this.code, this.data, this.msg});

  RechageRecordResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<RechargeRecordModel>();
      json['data'].forEach((v) {
        data.add(new RechargeRecordModel.fromJson(v));
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

class RechargeRecordModel {
  num amount;
  String block;
  String coinName;
  int createTime;
  String fromAddress;
  int id;
  int status;
  String toAddress;
  String txId;
  int userId;

  RechargeRecordModel(
      {this.amount,
      this.block,
      this.coinName,
      this.createTime,
      this.fromAddress,
      this.id,
      this.status,
      this.toAddress,
      this.txId,
      this.userId});

  RechargeRecordModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    block = json['block'];
    coinName = json['coinName'];
    createTime = json['createTime'];
    fromAddress = json['fromAddress'];
    id = json['id'];
    status = json['status'];
    toAddress = json['toAddress'];
    txId = json['txId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['block'] = this.block;
    data['coinName'] = this.coinName;
    data['createTime'] = this.createTime;
    data['fromAddress'] = this.fromAddress;
    data['id'] = this.id;
    data['status'] = this.status;
    data['toAddress'] = this.toAddress;
    data['txId'] = this.txId;
    data['userId'] = this.userId;
    return data;
  }
}
