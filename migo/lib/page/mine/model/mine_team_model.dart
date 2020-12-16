class MineTeamResponse {
  int code;
  TeamModel data;
  String msg;

  MineTeamResponse({this.code, this.data, this.msg});

  MineTeamResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new TeamModel.fromJson(json['data']) : null;
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

class TeamModel {
  DirectDTO directDTO;
  LeaderDTO leaderDTO;
  num minTeamAmount;
  ShareDTO shareDTO;
  num totalTeamAmount;
  num yesterdayTeamAmount;

  TeamModel(
      {this.directDTO,
      this.leaderDTO,
      this.minTeamAmount,
      this.shareDTO,
      this.totalTeamAmount,
      this.yesterdayTeamAmount});

  TeamModel.fromJson(Map<String, dynamic> json) {
    directDTO = json['directDTO'] != null
        ? new DirectDTO.fromJson(json['directDTO'])
        : null;
    leaderDTO = json['leaderDTO'] != null
        ? new LeaderDTO.fromJson(json['leaderDTO'])
        : null;
    minTeamAmount = json['minTeamAmount'];
    shareDTO = json['shareDTO'] != null
        ? new ShareDTO.fromJson(json['shareDTO'])
        : null;
    totalTeamAmount = json['totalTeamAmount'];
    yesterdayTeamAmount = json['yesterdayTeamAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directDTO != null) {
      data['directDTO'] = this.directDTO.toJson();
    }
    if (this.leaderDTO != null) {
      data['leaderDTO'] = this.leaderDTO.toJson();
    }
    data['minTeamAmount'] = this.minTeamAmount;
    if (this.shareDTO != null) {
      data['shareDTO'] = this.shareDTO.toJson();
    }
    data['totalTeamAmount'] = this.totalTeamAmount;
    data['yesterdayTeamAmount'] = this.yesterdayTeamAmount;
    return data;
  }
}

class DirectDTO {
  List<AccountDetailModel> accountDetailList;
  PdirectConfig pdirectConfig;

  DirectDTO({this.accountDetailList, this.pdirectConfig});

  DirectDTO.fromJson(Map<String, dynamic> json) {
    if (json['accountDetailList'] != null) {
      accountDetailList = new List<AccountDetailModel>();
      json['accountDetailList'].forEach((v) {
        accountDetailList.add(new AccountDetailModel.fromJson(v));
      });
    }
    pdirectConfig = json['pdirectConfig'] != null
        ? new PdirectConfig.fromJson(json['pdirectConfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accountDetailList != null) {
      data['accountDetailList'] =
          this.accountDetailList.map((v) => v.toJson()).toList();
    }
    if (this.pdirectConfig != null) {
      data['pdirectConfig'] = this.pdirectConfig.toJson();
    }
    return data;
  }
}

class AccountDetailModel {
  int accountId;
  int accountType;
  num amount;
  String businessRemark;
  int businessType;
  int changeType;
  String coinName;
  int createTime;
  int id;
  int userId;

  AccountDetailModel(
      {this.accountId,
      this.accountType,
      this.amount,
      this.businessRemark,
      this.businessType,
      this.changeType,
      this.coinName,
      this.createTime,
      this.id,
      this.userId});

  AccountDetailModel.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    accountType = json['accountType'];
    amount = json['amount'];
    businessRemark = json['businessRemark'];
    businessType = json['businessType'];
    changeType = json['changeType'];
    coinName = json['coinName'];
    createTime = json['createTime'];
    id = json['id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['accountType'] = this.accountType;
    data['amount'] = this.amount;
    data['businessRemark'] = this.businessRemark;
    data['businessType'] = this.businessType;
    data['changeType'] = this.changeType;
    data['coinName'] = this.coinName;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['userId'] = this.userId;
    return data;
  }
}

class PdirectConfig {
  int createTime;
  String id;
  num proportion;
  String remark;
  String enRemark;
  String seeRemark;
  int userLevel;

  PdirectConfig(
      {this.createTime,
      this.id,
      this.proportion,
      this.remark,
      this.seeRemark,
      this.userLevel});

  PdirectConfig.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    id = json['id'];
    enRemark = json["enRemark"];
    proportion = json['proportion'];
    remark = json['remark'];
    seeRemark = json['seeRemark'];
    userLevel = json['userLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['proportion'] = this.proportion;
    data['remark'] = this.remark;
    data['seeRemark'] = this.seeRemark;
    data['userLevel'] = this.userLevel;
    return data;
  }
}

class LeaderDTO {
  num minTeamPledgeAmount;
  int minTeamUserCount;
  List<SubordinateLeaderDTOModel> subordinateLeaderDTOList;
  String title;
  num totalTeamPledgeAmount;
  String enTitle;

  LeaderDTO(
      {this.minTeamPledgeAmount,
      this.minTeamUserCount,
      this.enTitle,
      this.subordinateLeaderDTOList,
      this.title});

  LeaderDTO.fromJson(Map<String, dynamic> json) {
    minTeamPledgeAmount = json['minTeamPledgeAmount'];
    minTeamUserCount = json['minTeamUserCount'];
    totalTeamPledgeAmount = json["totalTeamPledgeAmount"];
    enTitle = json["enTitle"];
    if (json['subordinateLeaderDTOList'] != null) {
      subordinateLeaderDTOList = new List<SubordinateLeaderDTOModel>();
      json['subordinateLeaderDTOList'].forEach((v) {
        subordinateLeaderDTOList.add(new SubordinateLeaderDTOModel.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minTeamPledgeAmount'] = this.minTeamPledgeAmount;
    data['minTeamUserCount'] = this.minTeamUserCount;
    if (this.subordinateLeaderDTOList != null) {
      data['subordinateLeaderDTOList'] =
          this.subordinateLeaderDTOList.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }
}

class SubordinateLeaderDTOModel {
  num maxTeamAmount;
  int subordinateUserCount;
  String userNumber;
  int isAuthStatus;

  SubordinateLeaderDTOModel(
      {this.maxTeamAmount, this.subordinateUserCount, this.userNumber});

  SubordinateLeaderDTOModel.fromJson(Map<String, dynamic> json) {
    maxTeamAmount = json['maxTeamAmount'];
    subordinateUserCount = json['subordinateUserCount'];
    userNumber = json['userNumber'];
    isAuthStatus = json["isAuthStatus"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxTeamAmount'] = this.maxTeamAmount;
    data['subordinateUserCount'] = this.subordinateUserCount;
    data['userNumber'] = this.userNumber;
    return data;
  }
}

class ShareDTO {
  List<PseniorityConfigModel> pseniorityConfigList;
  int todayAuthUserCount;
  int totalAuthUserCount;
  int userLevel;

  ShareDTO(
      {this.pseniorityConfigList,
      this.todayAuthUserCount,
      this.totalAuthUserCount,
      this.userLevel});

  ShareDTO.fromJson(Map<String, dynamic> json) {
    if (json['pseniorityConfigList'] != null) {
      pseniorityConfigList = new List<PseniorityConfigModel>();
      json['pseniorityConfigList'].forEach((v) {
        pseniorityConfigList.add(new PseniorityConfigModel.fromJson(v));
      });
    }
    todayAuthUserCount = json['todayAuthUserCount'];
    totalAuthUserCount = json['totalAuthUserCount'];
    userLevel = json['userLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pseniorityConfigList != null) {
      data['pseniorityConfigList'] =
          this.pseniorityConfigList.map((v) => v.toJson()).toList();
    }
    data['todayAuthUserCount'] = this.todayAuthUserCount;
    data['totalAuthUserCount'] = this.totalAuthUserCount;
    data['userLevel'] = this.userLevel;
    return data;
  }
}

class PseniorityConfigModel {
  int createTime;
  String id;
  num proportion;
  String remark;
  String enRemark;
  int userCount;
  int userLevel;
  String seeRemark;
  String enSeeRemark;

  PseniorityConfigModel(
      {this.createTime,
      this.id,
      this.proportion,
      this.remark,
      this.enSeeRemark,
      this.userCount,
      this.userLevel});

  PseniorityConfigModel.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    id = json['id'];
    seeRemark = json["seeRemark"];
    proportion = json['proportion'];
    remark = json['remark'];
    enRemark = json['enRemark'];
    enSeeRemark = json["enSeeRemark"];
    userCount = json['userCount'];
    userLevel = json['userLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['proportion'] = this.proportion;
    data['remark'] = this.remark;
    data['userCount'] = this.userCount;
    data['userLevel'] = this.userLevel;
    return data;
  }
}
