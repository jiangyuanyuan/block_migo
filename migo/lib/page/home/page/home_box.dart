class HomeBoxReponse {
  int code;
  String msg;
  List<HomeBoxModel> data;

  HomeBoxReponse({this.code, this.msg, this.data});

  HomeBoxReponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<HomeBoxModel>();
      json['data'].forEach((v) {
        data.add(new HomeBoxModel.fromJson(v));
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

class HomeBoxModel {
  String id;
  String userId;
  int status;
  int createTime;
  int openTime;
  String toolboxId;
  num migosAmount;
  String userToolboxId;

  HomeBoxModel(
      {this.id,
      this.userId,
      this.status,
      this.createTime,
      this.openTime,
      this.toolboxId,
      this.migosAmount,
      this.userToolboxId});

  HomeBoxModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    status = json['status'];
    createTime = json['createTime'];
    openTime = json['openTime'];
    toolboxId = json['toolboxId'];
    migosAmount = json['migosAmount'];
    userToolboxId = json['userToolboxId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['openTime'] = this.openTime;
    data['toolboxId'] = this.toolboxId;
    data['migosAmount'] = this.migosAmount;
    data['userToolboxId'] = this.userToolboxId;
    return data;
  }
}
