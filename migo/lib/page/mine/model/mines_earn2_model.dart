class MinesEarnsResponse {
  int code;
  Data data;
  String msg;

  MinesEarnsResponse({this.code, this.data, this.msg});

  MinesEarnsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int current;
  int pages;
  List<MinesEarnsModel> records;
  bool searchCount;
  int size;
  int total;

  Data(
      {this.current,
      this.pages,
      this.records,
      this.searchCount,
      this.size,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    pages = json['pages'];
    if (json['records'] != null) {
      records = new List<MinesEarnsModel>();
      json['records'].forEach((v) {
        records.add(new MinesEarnsModel.fromJson(v));
      });
    }
    searchCount = json['searchCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['pages'] = this.pages;
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    data['searchCount'] = this.searchCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class MinesEarnsModel {
  String coinId;
  String coinName;
  int createTime;
  num earnAmount;
  int earnDay;
  String earnName;
  int earnTime;
  String enEarnName;
  String id;
  String mineBaseId;
  String mineUserId;
  int status;
  String userId;

  MinesEarnsModel(
      {this.coinId,
      this.coinName,
      this.createTime,
      this.earnAmount,
      this.earnDay,
      this.earnName,
      this.earnTime,
      this.enEarnName,
      this.id,
      this.mineBaseId,
      this.mineUserId,
      this.status,
      this.userId});

  MinesEarnsModel.fromJson(Map<String, dynamic> json) {
    coinId = json['coinId'];
    coinName = json['coinName'];
    createTime = json['createTime'];
    earnAmount = json['earnAmount'];
    earnDay = json['earnDay'];
    earnName = json['earnName'];
    final String time = json['earnTime'];
    if(time != null) {
      earnTime = DateTime.parse(time).millisecondsSinceEpoch;
    }
    enEarnName = json['enEarnName'];
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
    data['enEarnName'] = this.enEarnName;
    data['id'] = this.id;
    data['mineBaseId'] = this.mineBaseId;
    data['mineUserId'] = this.mineUserId;
    data['status'] = this.status;
    data['userId'] = this.userId;
    return data;
  }
}
