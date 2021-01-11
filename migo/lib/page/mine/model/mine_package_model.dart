class MinepageageResponse {
  int code;
  String msg;
  List<MineShovelModel> data;

  MinepageageResponse({this.code, this.msg, this.data});

  MinepageageResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<MineShovelModel>();
      json['data'].forEach((v) {
        data.add(new MineShovelModel.fromJson(v));
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

class MineShovelModel {
  String id;
  String userId;
  num toolSpecs;
  String toolboxId;
  String userToolboxId;
  int status;
  int createTime;
  int useTime;
  int canUseTime;
  Toolbox toolbox;

  MineShovelModel(
      {this.id,
      this.userId,
      this.toolSpecs,
      this.toolboxId,
      this.userToolboxId,
      this.status,
      this.createTime,
      this.useTime,
      this.canUseTime,
      this.toolbox});

  MineShovelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    toolSpecs = json['toolSpecs'];
    toolboxId = json['toolboxId'];
    userToolboxId = json['userToolboxId'];
    status = json['status'];
    createTime = json['createTime'];
    useTime = json['useTime'];
    // useTime = 1610335755329;
    // 
    canUseTime = json['canUseTime'];
    toolbox =
        json['toolbox'] != null ? new Toolbox.fromJson(json['toolbox']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['toolSpecs'] = this.toolSpecs;
    data['toolboxId'] = this.toolboxId;
    data['userToolboxId'] = this.userToolboxId;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['useTime'] = this.useTime;
    data['canUseTime'] = this.canUseTime;
    if (this.toolbox != null) {
      data['toolbox'] = this.toolbox.toJson();
    }
    return data;
  }
}

class Toolbox {
  String id;
  String toolName;
  String enToolName;
  num toolValue;
  num toolSpecs;
  num toolSpecsMin;
  num toolSpecsMax;
  num achieveChannel;
  int status;
  int createTime;
  num migosAmount;
  num toolboxProportion;
  num candyAmount;
  num baseEfficiency;
  num specsExcept;
  num calculationEfficiency;
  num durable;
  num volume;
  int canUseTime;

  Toolbox(
      {this.id,
      this.toolName,
      this.toolValue,
      this.toolSpecs,
      this.toolSpecsMin,
      this.toolSpecsMax,
      this.achieveChannel,
      this.status,
      this.enToolName,
      this.createTime,
      this.migosAmount,
      this.toolboxProportion,
      this.candyAmount,
      this.baseEfficiency,
      this.specsExcept,
      this.calculationEfficiency,
      this.durable,
      this.volume,
      this.canUseTime});

  Toolbox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    toolName = json['toolName'];
    toolValue = json['toolValue'];
    toolSpecs = json['toolSpecs'];
    enToolName = json['enToolName'];
    toolSpecsMin = json['toolSpecsMin'];
    toolSpecsMax = json['toolSpecsMax'];
    achieveChannel = json['achieveChannel'];
    status = json['status'];
    createTime = json['createTime'];
    migosAmount = json['migosAmount'];
    toolboxProportion = json['toolboxProportion'];
    candyAmount = json['candyAmount'];
    baseEfficiency = json['baseEfficiency'];
    specsExcept = json['specsExcept'];
    calculationEfficiency = json['calculationEfficiency'];
    durable = json['durable'];
    volume = json['volume'];
    canUseTime = json['canUseTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['toolName'] = this.toolName;
    data['toolValue'] = this.toolValue;
    data['toolSpecs'] = this.toolSpecs;
    data['toolSpecsMin'] = this.toolSpecsMin;
    data['toolSpecsMax'] = this.toolSpecsMax;
    data['achieveChannel'] = this.achieveChannel;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['migosAmount'] = this.migosAmount;
    data['toolboxProportion'] = this.toolboxProportion;
    data['candyAmount'] = this.candyAmount;
    data['baseEfficiency'] = this.baseEfficiency;
    data['specsExcept'] = this.specsExcept;
    data['calculationEfficiency'] = this.calculationEfficiency;
    data['durable'] = this.durable;
    data['volume'] = this.volume;
    data['canUseTime'] = this.canUseTime;
    return data;
  }
}


class MinePackageHeadResponse {
  int code;
  String msg;
  MinePackageHeadModel data;

  MinePackageHeadResponse({this.code, this.msg, this.data});

  MinePackageHeadResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new MinePackageHeadModel.fromJson(json['data']) : null;
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

class MinePackageHeadModel {
  num totalProductivity;
  num todayForecast;
  num totalCapacity;
  num usedCapacity;
  num totalMIGOs;
  List<MineShovelModel> shovelList;

  MinePackageHeadModel(
      {this.totalProductivity,
      this.todayForecast,
      this.totalCapacity,
      this.usedCapacity,
      this.totalMIGOs,
      this.shovelList});

  MinePackageHeadModel.fromJson(Map<String, dynamic> json) {
    totalProductivity = json['totalProductivity'];
    todayForecast = json['todayForecast'];
    totalCapacity = json['totalCapacity'];
    usedCapacity = json['usedCapacity'];
    totalMIGOs = json['totalMIGOs'];
    if (json['shovelList'] != null) {
      shovelList = new List<MineShovelModel>();
      json['shovelList'].forEach((v) {
        shovelList.add(new MineShovelModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalProductivity'] = this.totalProductivity;
    data['todayForecast'] = this.todayForecast;
    data['totalCapacity'] = this.totalCapacity;
    data['usedCapacity'] = this.usedCapacity;
    data['totalMIGOs'] = this.totalMIGOs;
    data['shovelList'] = this.shovelList;
    return data;
  }
}

