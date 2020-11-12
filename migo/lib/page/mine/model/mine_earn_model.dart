class MineEarnResponse {
  int code;
  List<EarnModel> data;
  String msg;

  MineEarnResponse({this.code, this.data, this.msg});

  MineEarnResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<EarnModel>();
      json['data'].forEach((v) {
        data.add(new EarnModel.fromJson(v));
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

class EarnModel {
  int coinId;
  String coinName;
  int createTime;
  num earnAmount;
  String earnDay;
  String earnName;
  int earnTime;
  int id;
  int mineBaseId;
  int mineUserId;
  int status;
  int userId;

  EarnModel(
      {this.coinId,
      this.coinName,
      this.createTime,
      this.earnAmount,
      this.earnDay,
      this.earnName,
      this.earnTime,
      this.id,
      this.mineBaseId,
      this.mineUserId,
      this.status,
      this.userId});

  EarnModel.fromJson(Map<String, dynamic> json) {
    coinId = json['coinId'];
    coinName = json['coinName'];
    createTime = json['createTime'];
    earnAmount = json['earnAmount'];
    earnDay = json['earnDay'];
    earnName = json['earnName'];
    earnTime = json['earnTime'];
    id = json['id'];
    mineBaseId = json['mineBaseId'];
    mineUserId = json['mineUserId'];
    status = json['status'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinId'] = this.coinId;
    data['coinName'] = this.coinName;
    data['createTime'] = this.createTime;
    data['earnAmount'] = this.earnAmount;
    data['earnDay'] = this.earnDay;
    data['earnName'] = this.earnName;
    data['earnTime'] = this.earnTime;
    data['id'] = this.id;
    data['mineBaseId'] = this.mineBaseId;
    data['mineUserId'] = this.mineUserId;
    data['status'] = this.status;
    data['userId'] = this.userId;
    return data;
  }
}
