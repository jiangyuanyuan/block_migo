class LoginStatusResponse {
  int code;
  String msg;
  List<LoginStatusModel> data;

  LoginStatusResponse({this.code, this.msg, this.data});

  LoginStatusResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<LoginStatusModel>();
      json['data'].forEach((v) {
        data.add(new LoginStatusModel.fromJson(v));
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

class LoginStatusModel {
  String id;
  String configKey;
  String configValue;
  int configType;
  String remark;
  int createTime;

  LoginStatusModel(
      {this.id,
      this.configKey,
      this.configValue,
      this.configType,
      this.remark,
      this.createTime});

  LoginStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    configKey = json['configKey'];
    configValue = "${json['configValue']}";
    configType = json['configType'];
    remark = json['remark'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['configKey'] = this.configKey;
    data['configValue'] = this.configValue;
    data['configType'] = this.configType;
    data['remark'] = this.remark;
    data['createTime'] = this.createTime;
    return data;
  }
}
