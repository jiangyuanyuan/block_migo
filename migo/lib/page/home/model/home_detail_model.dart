class HomeDetailResponse {
  int code;
  String msg;
  HomeDetialModel data;

  HomeDetailResponse({this.code, this.msg, this.data});

  HomeDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new HomeDetialModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class HomeDetialModel {
  String baseName;
  String enBaseName;
  int count;
  num oneDayAmount;
  int mineTimes;
  double totalMine;
  String mineCoinName;
  String pledgeCoinName;
  num pledgeAmount;
  List<MmineUserModel> mmineUserList;

  HomeDetialModel(
      {this.baseName,
      this.enBaseName,
      this.count,
      this.oneDayAmount,
      this.mineTimes,
      this.totalMine,
      this.mineCoinName,
      this.pledgeCoinName,
      this.pledgeAmount,
      this.mmineUserList});

  HomeDetialModel.fromJson(Map<String, dynamic> json) {
    baseName = json['baseName'];
    enBaseName = json['enBaseName'];
    count = json['count'];
    oneDayAmount = json['oneDayAmount'];
    mineTimes = json['mineTimes'];
    totalMine = json['totalMine'];
    mineCoinName = json['mineCoinName'];
    pledgeCoinName = json['pledgeCoinName'];
    pledgeAmount = json['pledgeAmount'];
    if (json['mmineUserList'] != null) {
      mmineUserList = new List<MmineUserModel>();
      json['mmineUserList'].forEach((v) {
        mmineUserList.add(new MmineUserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseName'] = this.baseName;
    data['enBaseName'] = this.enBaseName;
    data['count'] = this.count;
    data['oneDayAmount'] = this.oneDayAmount;
    data['mineTimes'] = this.mineTimes;
    data['totalMine'] = this.totalMine;
    data['mineCoinName'] = this.mineCoinName;
    data['pledgeCoinName'] = this.pledgeCoinName;
    data['pledgeAmount'] = this.pledgeAmount;
    if (this.mmineUserList != null) {
      data['mmineUserList'] =
          this.mmineUserList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MmineUserModel {
  String id;
  String mineBaseId;
  String userId;
  num payAmount;
  int mineDays;
  int datetimeMineDays;
  int status;
  double mineEarnTotal;
  num mineEarnDay;
  int createTime;
  int beginTime;
  int endTime;

  MmineUserModel(
      {this.id,
      this.mineBaseId,
      this.userId,
      this.payAmount,
      this.mineDays,
      this.datetimeMineDays,
      this.status,
      this.mineEarnTotal,
      this.mineEarnDay,
      this.createTime,
      this.beginTime,
      this.endTime});

  MmineUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mineBaseId = json['mineBaseId'];
    userId = json['userId'];
    payAmount = json['payAmount'];
    mineDays = json['mineDays'];
    datetimeMineDays = json['datetimeMineDays'];
    status = json['status'];
    mineEarnTotal = json['mineEarnTotal'];
    mineEarnDay = json['mineEarnDay'];
    createTime = json['createTime'];
    beginTime = json['beginTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mineBaseId'] = this.mineBaseId;
    data['userId'] = this.userId;
    data['payAmount'] = this.payAmount;
    data['mineDays'] = this.mineDays;
    data['datetimeMineDays'] = this.datetimeMineDays;
    data['status'] = this.status;
    data['mineEarnTotal'] = this.mineEarnTotal;
    data['mineEarnDay'] = this.mineEarnDay;
    data['createTime'] = this.createTime;
    data['beginTime'] = this.beginTime;
    data['endTime'] = this.endTime;
    return data;
  }
}
