class SafeResponse {
  int code;
  String msg;
  SafeModel data;

  SafeResponse({this.code, this.msg, this.data});

  SafeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new SafeModel.fromJson(json['data']) : null;
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

class SafeModel {
  ///	实名认证状态 0待认证 1审核中 2审核通过 3审核拒绝
  int isAuth;
  String userNumber;
  int isTxPWD;
  int userNumberType;

  SafeModel({this.isAuth, this.userNumber, this.isTxPWD, this.userNumberType});

  SafeModel.fromJson(Map<String, dynamic> json) {
    isAuth = json['isAuth'];
    userNumber = json['userNumber'];
    isTxPWD = json['isTxPWD'];
    userNumberType = json['userNumberType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAuth'] = this.isAuth;
    data['userNumber'] = this.userNumber;
    data['isTxPWD'] = this.isTxPWD;
    data['userNumberType'] = this.userNumberType;
    return data;
  }
}
