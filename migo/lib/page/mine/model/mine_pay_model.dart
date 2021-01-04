class MinePaymethodResponse {
  int code;
  String msg;
  List<PaymethodModel> data;

  MinePaymethodResponse({this.code, this.msg, this.data});

  MinePaymethodResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<PaymethodModel>();
      json['data'].forEach((v) {
        data.add(new PaymethodModel.fromJson(v));
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

class PaymethodModel {
  String id;
  String userId;
  int payWay;
  String payName;
  String payNo;
  String openBank;
  String openBranchBank;
  int updateTime;
  int createTime;

  PaymethodModel(
      {this.id,
      this.userId,
      this.payWay,
      this.payName,
      this.payNo,
      this.openBank,
      this.openBranchBank,
      this.updateTime,
      this.createTime});

  PaymethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    payWay = json['payWay'];
    payName = json['payName'];
    payNo = json['payNo'];
    openBank = json['openBank'];
    openBranchBank = json['openBranchBank'];
    updateTime = json['updateTime'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['payWay'] = this.payWay;
    data['payName'] = this.payName;
    data['payNo'] = this.payNo;
    data['openBank'] = this.openBank;
    data['openBranchBank'] = this.openBranchBank;
    data['updateTime'] = this.updateTime;
    data['createTime'] = this.createTime;
    return data;
  }
}
