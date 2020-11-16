class MyShovelRecordResponse {
  int code;
  List<MyShovelRecordModel> data;
  String msg;

  MyShovelRecordResponse({this.code, this.data, this.msg});

  MyShovelRecordResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<MyShovelRecordModel>();
      json['data'].forEach((v) {
        data.add(new MyShovelRecordModel.fromJson(v));
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

class MyShovelRecordModel {
  num amount;
  String coinName;
  int createTime;
  String enRemark;
  int id;
  int mineRecordId;
  String remark;
  int userId;

  MyShovelRecordModel(
      {this.amount,
      this.coinName,
      this.createTime,
      this.enRemark,
      this.id,
      this.mineRecordId,
      this.remark,
      this.userId});

  MyShovelRecordModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    coinName = json['coinName'];
    createTime = json['createTime'];
    enRemark = json['enRemark'];
    id = json['id'];
    mineRecordId = json['mineRecordId'];
    remark = json['remark'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['coinName'] = this.coinName;
    data['createTime'] = this.createTime;
    data['enRemark'] = this.enRemark;
    data['id'] = this.id;
    data['mineRecordId'] = this.mineRecordId;
    data['remark'] = this.remark;
    data['userId'] = this.userId;
    return data;
  }
}
