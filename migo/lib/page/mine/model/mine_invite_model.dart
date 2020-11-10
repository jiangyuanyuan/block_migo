class MineInviteResponse {
  int code;
  List<MineInviteModel> data;
  String msg;

  MineInviteResponse({this.code, this.data, this.msg});

  MineInviteResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<MineInviteModel>();
      json['data'].forEach((v) {
        data.add(new MineInviteModel.fromJson(v));
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

class MineInviteModel {
  int authStatus;
  int createTime;
  String userNumber;

  MineInviteModel({this.authStatus, this.createTime, this.userNumber});

  MineInviteModel.fromJson(Map<String, dynamic> json) {
    authStatus = json['authStatus'];
    createTime = json['createTime'];
    userNumber = json['userNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authStatus'] = this.authStatus;
    data['createTime'] = this.createTime;
    data['userNumber'] = this.userNumber;
    return data;
  }
}
