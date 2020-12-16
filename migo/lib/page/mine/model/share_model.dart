class ShareResponse {
  int code;
  List<ShareModel> data;
  String msg;

  ShareResponse({this.code, this.data, this.msg});

  ShareResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<ShareModel>();
      json['data'].forEach((v) {
        data.add(new ShareModel.fromJson(v));
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

class ShareModel {
  num amount;
  String coinName;
  int seniority;
  String timeString;

  ShareModel({this.amount, this.coinName, this.seniority, this.timeString});

  ShareModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    coinName = json['coinName'];
    seniority = json['seniority'];
    timeString = json['timeString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['coinName'] = this.coinName;
    data['seniority'] = this.seniority;
    data['timeString'] = this.timeString;
    return data;
  }
}
