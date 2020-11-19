class MineCoinRecordResponse {
  int code;
  String msg;
  List<MineCoinRecordModel> data;

  MineCoinRecordResponse({this.code, this.msg, this.data});

  MineCoinRecordResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<MineCoinRecordModel>();
      json['data'].forEach((v) {
        data.add(new MineCoinRecordModel.fromJson(v));
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

class MineCoinRecordModel {
  int id;
  int userId;
  int accountId;
  num amount;
  int changeType;
  int businessType;
  String businessRemark;
  String enBusinessRemark;
  int createTime;
  int accountType;
  String coinName;

  MineCoinRecordModel(
      {this.id,
      this.userId,
      this.accountId,
      this.amount,
      this.changeType,
      this.businessType,
      this.businessRemark,
      this.createTime,
      this.accountType,
      this.coinName});

  MineCoinRecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    accountId = json['accountId'];
    amount = json['amount'];
    enBusinessRemark = json['enBusinessRemark'];
    changeType = json['changeType'];
    businessType = json['businessType'];
    businessRemark = json['businessRemark'];
    createTime = json['createTime'];
    accountType = json['accountType'];
    coinName = json['coinName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['accountId'] = this.accountId;
    data['amount'] = this.amount;
    data['changeType'] = this.changeType;
    data['businessType'] = this.businessType;
    data['businessRemark'] = this.businessRemark;
    data['createTime'] = this.createTime;
    data['accountType'] = this.accountType;
    data['coinName'] = this.coinName;
    return data;
  }
}
