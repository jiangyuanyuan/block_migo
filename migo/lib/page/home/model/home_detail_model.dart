class HomeDetailResponse {
  int code;
  HomeDetialModel data;
  String msg;

  HomeDetailResponse({this.code, this.data, this.msg});

  HomeDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new HomeDetialModel.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class HomeDetialModel {
  int endTime;
  List<MineEarnRecordModel> mineEarnRecordList;
  List<MinePayRecordModel> minePayRecordList;
  int mineTimes;
  num oneDayAmount;
  num totalMine;
  int useCount;

  HomeDetialModel(
      {this.endTime,
      this.mineEarnRecordList,
      this.minePayRecordList,
      this.mineTimes,
      this.oneDayAmount,
      this.totalMine,
      this.useCount});

  HomeDetialModel.fromJson(Map<String, dynamic> json) {
    endTime = json['endTime'];
    if (json['mineEarnRecordList'] != null) {
      mineEarnRecordList = new List<MineEarnRecordModel>();
      json['mineEarnRecordList'].forEach((v) {
        mineEarnRecordList.add(new MineEarnRecordModel.fromJson(v));
      });
    }
    if (json['minePayRecordList'] != null) {
      minePayRecordList = new List<MinePayRecordModel>();
      json['minePayRecordList'].forEach((v) {
        minePayRecordList.add(new MinePayRecordModel.fromJson(v));
      });
    }
    mineTimes = json['mineTimes'];
    oneDayAmount = json['oneDayAmount'];
    totalMine = json['totalMine'];
    useCount = json['useCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endTime'] = this.endTime;
    if (this.mineEarnRecordList != null) {
      data['mineEarnRecordList'] =
          this.mineEarnRecordList.map((v) => v.toJson()).toList();
    }
    if (this.minePayRecordList != null) {
      data['minePayRecordList'] =
          this.minePayRecordList.map((v) => v.toJson()).toList();
    }
    data['mineTimes'] = this.mineTimes;
    data['oneDayAmount'] = this.oneDayAmount;
    data['totalMine'] = this.totalMine;
    data['useCount'] = this.useCount;
    return data;
  }
}

class MineEarnRecordModel {
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

  MineEarnRecordModel(
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

  MineEarnRecordModel.fromJson(Map<String, dynamic> json) {
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

class MinePayRecordModel {
  int coinId;
  String coinName;
  int createTime;
  int id;
  int mineBaseId;
  int mineUserId;
  num payAmount;
  int payTime;
  int userId;

  MinePayRecordModel(
      {this.coinId,
      this.coinName,
      this.createTime,
      this.id,
      this.mineBaseId,
      this.mineUserId,
      this.payAmount,
      this.payTime,
      this.userId});

  MinePayRecordModel.fromJson(Map<String, dynamic> json) {
    coinId = json['coinId'];
    coinName = json['coinName'];
    createTime = json['createTime'];
    id = json['id'];
    mineBaseId = json['mineBaseId'];
    mineUserId = json['mineUserId'];
    payAmount = json['payAmount'];
    payTime = json['payTime'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinId'] = this.coinId;
    data['coinName'] = this.coinName;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['mineBaseId'] = this.mineBaseId;
    data['mineUserId'] = this.mineUserId;
    data['payAmount'] = this.payAmount;
    data['payTime'] = this.payTime;
    data['userId'] = this.userId;
    return data;
  }
}
