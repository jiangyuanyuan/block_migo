class HomeListReponse {
  int code;
  String msg;
  List<HomeModel> data;

  HomeListReponse({this.code, this.msg, this.data});

  HomeListReponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<HomeModel>();
      json['data'].forEach((v) {
        data.add(new HomeModel.fromJson(v));
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

class HomeModel {
  String id;
  String mineTitle;
  String mineDesc;
  num pledgeAmount;
  String pledgeCoinId;
  String pledgeCoinName;
  String mineCoinName;
  int mineTimes;
  num totalMine;
  int createTime;
  int mineType;
  int count;
  String mineTypeName;
  num miningDifficulty;

  HomeModel(
      {this.id,
      this.mineTitle,
      this.mineDesc,
      this.pledgeAmount,
      this.pledgeCoinId,
      this.pledgeCoinName,
      this.mineCoinName,
      this.mineTimes,
      this.totalMine,
      this.count,
      this.createTime,
      this.mineType,
      this.mineTypeName,
      this.miningDifficulty});

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mineTitle = json['mineTitle'];
    mineDesc = json['mineDesc'];
    pledgeAmount = json['pledgeAmount'];
    pledgeCoinId = json['pledgeCoinId'];
    pledgeCoinName = json['pledgeCoinName'];
    mineCoinName = json['mineCoinName'];
    mineTimes = json['mineTimes'];
    count = json["count"];
    totalMine = json['totalMine'];
    createTime = json['createTime'];
    mineType = json['mineType'];
    mineTypeName = json['mineTypeName'];
    miningDifficulty = json['miningDifficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mineTitle'] = this.mineTitle;
    data['mineDesc'] = this.mineDesc;
    data['pledgeAmount'] = this.pledgeAmount;
    data['pledgeCoinId'] = this.pledgeCoinId;
    data['pledgeCoinName'] = this.pledgeCoinName;
    data['mineCoinName'] = this.mineCoinName;
    data['mineTimes'] = this.mineTimes;
    data['totalMine'] = this.totalMine;
    data['createTime'] = this.createTime;
    data['mineType'] = this.mineType;
    data['mineTypeName'] = this.mineTypeName;
    data['miningDifficulty'] = this.miningDifficulty;
    return data;
  }
}
