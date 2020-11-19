class RechargeResponse {
  int code;
  String msg;
  List<RechargeModel> data;

  RechargeResponse({this.code, this.msg, this.data});

  RechargeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<RechargeModel>();
      json['data'].forEach((v) {
        data.add(new RechargeModel.fromJson(v));
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

class RechargeModel {
  String coinName;
  String baseAddress;
  String trcAddress;
  String omniAddress;
  num minRechargeQty;

  RechargeModel({this.coinName, this.minRechargeQty, this.baseAddress, this.trcAddress, this.omniAddress});

  RechargeModel.fromJson(Map<String, dynamic> json) {
    coinName = json['coinName'];
    baseAddress = json['baseAddress'] ?? '';
    trcAddress = json['trcAddress'] ?? '';
    omniAddress = json['omniAddress'] ?? '';
    minRechargeQty = json["minRechargeQty"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinName'] = this.coinName;
    data['baseAddress'] = this.baseAddress;
    data['trcAddress'] = this.trcAddress;
    data['omniAddress'] = this.omniAddress;
    return data;
  }
}
