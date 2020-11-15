class MinePayEarnResponse {
  int code;
  String msg;
  Data data;

  MinePayEarnResponse({this.code, this.msg, this.data});

  MinePayEarnResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<MinesPayEarnModel> records;
  int total;
  int size;
  int current;
  bool searchCount;
  int pages;

  Data(
      {this.records,
      this.total,
      this.size,
      this.current,
      this.searchCount,
      this.pages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = new List<MinesPayEarnModel>();
      json['records'].forEach((v) {
        records.add(new MinesPayEarnModel.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    searchCount = json['searchCount'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['size'] = this.size;
    data['current'] = this.current;
    data['searchCount'] = this.searchCount;
    data['pages'] = this.pages;
    return data;
  }
}

class MinesPayEarnModel {
  String id;
  String mineUserId;
  String mineBaseId;
  String userId;
  num payAmount;
  String coinName;
  String coinId;
  int createTime;
  int payTime;
  String earnName;
  String enEarnName;

  MinesPayEarnModel(
      {this.id,
      this.mineUserId,
      this.mineBaseId,
      this.userId,
      this.payAmount,
      this.coinName,
      this.coinId,
      this.createTime,
      this.payTime,
      this.earnName,
      this.enEarnName});

  MinesPayEarnModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mineUserId = json['mineUserId'];
    mineBaseId = json['mineBaseId'];
    userId = json['userId'];
    payAmount = json['payAmount'];
    coinName = json['coinName'];
    coinId = json['coinId'];
    createTime = json['createTime'];
    payTime = json['payTime'];
    earnName = json['earnName'];
    enEarnName = json['enEarnName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mineUserId'] = this.mineUserId;
    data['mineBaseId'] = this.mineBaseId;
    data['userId'] = this.userId;
    data['payAmount'] = this.payAmount;
    data['coinName'] = this.coinName;
    data['coinId'] = this.coinId;
    data['createTime'] = this.createTime;
    data['payTime'] = this.payTime;
    data['earnName'] = this.earnName;
    data['enEarnName'] = this.enEarnName;
    return data;
  }
}
