class TeamEarthResponse {
  int code;
  String msg;
  TeamEarthModel data;

  TeamEarthResponse({this.code, this.msg, this.data});

  TeamEarthResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new TeamEarthModel.fromJson(json['data']) : null;
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

class TeamEarthModel {
  num newAmount;
  String startToEndTime;
  String bonusStartToEndTime;
  MyDirectDTO myDirectDTO;
  MySubordinateDTO mySubordinateDTO;

  TeamEarthModel(
      {this.newAmount,
      this.startToEndTime,
      this.bonusStartToEndTime,
      this.myDirectDTO,
      this.mySubordinateDTO});

  TeamEarthModel.fromJson(Map<String, dynamic> json) {
    newAmount = json['newAmount'];
    startToEndTime = json['startToEndTime'];
    bonusStartToEndTime = json['bonusStartToEndTime'];
    myDirectDTO = json['myDirectDTO'] != null
        ? new MyDirectDTO.fromJson(json['myDirectDTO'])
        : null;
    mySubordinateDTO = json['mySubordinateDTO'] != null
        ? new MySubordinateDTO.fromJson(json['mySubordinateDTO'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newAmount'] = this.newAmount;
    data['startToEndTime'] = this.startToEndTime;
    data['bonusStartToEndTime'] = this.bonusStartToEndTime;
    if (this.myDirectDTO != null) {
      data['myDirectDTO'] = this.myDirectDTO.toJson();
    }
    if (this.mySubordinateDTO != null) {
      data['mySubordinateDTO'] = this.mySubordinateDTO.toJson();
    }
    return data;
  }
}

class MyDirectDTO {
  int userCount;
  int authUserCount;
  num thisWeekAmount;
  num totalAmount;

  MyDirectDTO(
      {this.userCount,
      this.authUserCount,
      this.thisWeekAmount,
      this.totalAmount});

  MyDirectDTO.fromJson(Map<String, dynamic> json) {
    userCount = json['userCount'];
    authUserCount = json['authUserCount'];
    thisWeekAmount = json['thisWeekAmount'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userCount'] = this.userCount;
    data['authUserCount'] = this.authUserCount;
    data['thisWeekAmount'] = this.thisWeekAmount;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}

class MySubordinateDTO {
  int subordinateUserCount;
  int subordinateAuthUserCount;
  num thisWeekSubordinateAmount;
  num totalSubordinateAmount;

  MySubordinateDTO(
      {this.subordinateUserCount,
      this.subordinateAuthUserCount,
      this.thisWeekSubordinateAmount,
      this.totalSubordinateAmount});

  MySubordinateDTO.fromJson(Map<String, dynamic> json) {
    subordinateUserCount = json['subordinateUserCount'];
    subordinateAuthUserCount = json['subordinateAuthUserCount'];
    thisWeekSubordinateAmount = json['thisWeekSubordinateAmount'];
    totalSubordinateAmount = json['totalSubordinateAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subordinateUserCount'] = this.subordinateUserCount;
    data['subordinateAuthUserCount'] = this.subordinateAuthUserCount;
    data['thisWeekSubordinateAmount'] = this.thisWeekSubordinateAmount;
    data['totalSubordinateAmount'] = this.totalSubordinateAmount;
    return data;
  }
}
