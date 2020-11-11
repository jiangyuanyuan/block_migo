class ExchangeResponse {
  int code;
  String msg;
  ExhangeModel data;

  ExchangeResponse({this.code, this.msg, this.data});

  ExchangeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new ExhangeModel.fromJson(json['data']) : null;
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

class ExhangeModel {
  List<ExchangeCoinModel> tradings;
  int level;
  int nextLevel;
  num levelReduction;
  num nextLevelReduction;
  List<String> canUseInputCoinNames;
  List<String> canUseOutputCoinNames;

  ExhangeModel(
      {this.tradings,
      this.level,
      this.nextLevel,
      this.levelReduction,
      this.nextLevelReduction,
      this.canUseInputCoinNames,
      this.canUseOutputCoinNames});

  ExhangeModel.fromJson(Map<String, dynamic> json) {
    if (json['tradings'] != null) {
      tradings = new List<ExchangeCoinModel>();
      json['tradings'].forEach((v) {
        tradings.add(new ExchangeCoinModel.fromJson(v));
      });
    }
    level = json['level'];
    nextLevel = json['nextLevel'];
    levelReduction = json['levelReduction'];
    nextLevelReduction = json['nextLevelReduction'];
    canUseInputCoinNames = json['canUseInputCoinNames'].cast<String>();
    canUseOutputCoinNames = json['canUseOutputCoinNames'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tradings != null) {
      data['tradings'] = this.tradings.map((v) => v.toJson()).toList();
    }
    data['level'] = this.level;
    data['nextLevel'] = this.nextLevel;
    data['levelReduction'] = this.levelReduction;
    data['nextLevelReduction'] = this.nextLevelReduction;
    data['canUseInputCoinNames'] = this.canUseInputCoinNames;
    data['canUseOutputCoinNames'] = this.canUseOutputCoinNames;
    return data;
  }
}

class ExchangeCoinModel {
  num inputCoinAmount;
  num outputCoinAmount;
  num oneInToOutAmount;
  String ntn;

  ExchangeCoinModel(
      {this.inputCoinAmount,
      this.outputCoinAmount,
      this.oneInToOutAmount,
      this.ntn});

  ExchangeCoinModel.fromJson(Map<String, dynamic> json) {
    inputCoinAmount = json['inputCoinAmount'];
    outputCoinAmount = json['outputCoinAmount'];
    oneInToOutAmount = json['oneInToOutAmount'];
    ntn = json['ntn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inputCoinAmount'] = this.inputCoinAmount;
    data['outputCoinAmount'] = this.outputCoinAmount;
    data['oneInToOutAmount'] = this.oneInToOutAmount;
    data['ntn'] = this.ntn;
    return data;
  }
}
